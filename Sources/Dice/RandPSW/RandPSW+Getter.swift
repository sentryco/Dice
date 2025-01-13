import Foundation
/**
 * Helper methods (password recipe related)
 * - Remark: Derives a password from Dice framework based on current config
 * - Remark: It will make less sense to move this to table scope, too much logic
 * - Remark: Always keep logic less central etc, farthest out in the branches etc
 */
extension RandPSW {
   /**
    * Generates a password based on the recipe configuration.
    * - Description: This function generates a random password or word based on
    *                the provided parameters. The length, usage of words, numbers,
    *                symbols, hyphens, and uppercase letters can be customized.
    *                If 'useWords' is true, the function generates a password
    *                composed of words. Otherwise, it generates a character-based
    *                password. The function throws an error if the password cannot
    *                be generated.
    * - Fixme: ⚠️️ Rename to `getRandomWord`? or `getRandomPasswordOrWord`? this entire class is a bit messy atm, do the renaming when you work on it etc
    * - Fixme: ⚠️️ Add `isUppercased` flag? We would have to redesign the UI a bit first. seems to be in now, remove this comment?
    * ## Examples:
    * `let password = try RandPSW.makeRandomWord(length: 10, useWords: true, usesNum: true, usesSym: true, usesHyp: true)` generates a password like "word1-word2".
    * - Parameters:
    *   - length: The length of the output password.
    *   - useWords: Whether to compose the password of words.
    *   - useNumbers: Whether to use numbers in the password.
    *   - useSymbols: Whether to use symbols in the password.
    *   - useHyphen: Whether to use hyphens in the password.
    *   - isUppercased: Whether to use uppercase letters (only for words at the moment).
    * - Returns: A randomly generated password.
    */
   public static func makeRandomWord(length: Int, useWords: Bool, usesNum: Bool, usesSym: Bool, usesHyp: Bool, isUpperCased: Bool = false) throws -> String {
      if useWords { // Word based password
         return try RandPSW.makeRandomWords(
            length: length, // The length of the password
            seperator: usesHyp ? "-" : "" // The separator to use between words in the password
         ) // Generate a password based on random words
      } else { // Character based password
         let recipe: RandPSW.PasswordRecipe = Self.makePasswordRecipe(
            characterCount: length, // The number of characters in the password
            usesNum: usesNum, // Whether the password should contain numbers or not
            usesSym: usesSym // Whether the password should contain symbols or not
         ) // Generate a password recipe based on the given parameters
         return try RandPSW.makeRandomPassword(recipe: recipe) // Generate a password based on the recipe
      }
   }
   /**
    * Generates a random password based on the given recipe.
    * - Description: This function generates a random password based on the
    *                provided recipe. The recipe defines the number of characters,
    *                numeric characters, and special characters to be included in
    *                the password. The function throws an error if the password
    *                cannot be generated.
    * - Remark: If no password is made, the user will have to make one.
    * - Example:
    *   let password = try RandPSW.makeRandomWord(recipe: .init(charCount: 12, numCount: 2, symCount: 2))
    *   print(password) // Output: "A1!@#$%^"
    * - Parameters:
    *   - recipe: The recipe to use for generating the password.
    * - Returns: A randomly generated password.
    */
   public static func makeRandomPassword(recipe: PasswordRecipe) throws -> String {
      try makeRandomWord(
         charCount: recipe.charCount, // The number of characters in the password
         numCount: recipe.numCount, // The number of numeric characters in the password
         symCount: recipe.symCount // The number of special characters in the password
      ) // Generate a random password based on the given recipe
   }
}
/**
 * Bulk
 */
extension RandPSW {
   /**
    * Creates a string of random words separated by the given separator.
    * - Description: This function generates a string of random words separated by a given separator. The words are generated based on a list of seed words and the length parameter determines the number of words in the string. The separator is inserted between each word in the string. The function can be used to generate a password composed of random words, which can be easier to remember than a random sequence of characters.
    * - Fixme: ⚠️️ Rename to `makeRandomPassword`? or? this entire class is a bit messy atm, do the renaming when you work on it etc
    * - Parameters:
    *   - length: The number of words to include in the password.
    *   - separator: The separator to use between words.
    * - Returns: A string of randomly generated words.
    * - Fix: seperator is misspelled, fix it later
    * Example usage:
    * ```
    * let password = try RandPSW.makeRandomWords(length: 8, separator: "-")
    * print(password) // Output: "panda-will-boat-fair-death-desire-blue-forest"
    * ```
    */
   public static func makeRandomWords(length: Int, seperator: String = "-", isUpperCased: Bool = false) throws -> String {
      let arr: [String] = try EntropyGenerator.ranNonceArr(
         length: length, // The length of each word in the array
         charSet: SeedWordList.words, // The character set to use for generating the words
         unique: true // Whether to generate unique words in the array
      )
      // Swift.print("arr:  \(arr)")
      let str: String = arr.joined(separator: seperator) // Join strings with separator in-between
      // Swift.print("str: \(str)")
      let uppercased = isUpperCased ? str : str.uppercased()
      // Swift.print("uppercased: \(uppercased)")
      return uppercased
   }
}
/**
 * Private helper
 */
extension RandPSW {
   /**
    * Generates a "password-recipe" based on the given parameters.
    * - Description: This function generates a password recipe based on the given parameters. The recipe includes the total number of characters in the password, and whether to include numeric and special characters. The function returns a password recipe that can be used to generate a password.
    * - Note: We evenly spread the charCount between the 3 types
    * - Note: the reason letters are always included is so that its always possible to generate something
    * - Fixme: ⚠️️ add support for discluding chars. only num and sym etc
    * - Parameters:
    *   - characterCount: The total number of characters in the password, (num, letter, specials)
    *   - usesNum: Whether to include numeric characters in the password.
    *   - usesSym: Whether to include special characters in the password.
    * - Returns: A password recipe based on the given parameters.
    */
   fileprivate static func makePasswordRecipe(characterCount: Int, usesNum: Bool, usesSym: Bool/*, usesLetters: Bool = true*/) -> RandPSW.PasswordRecipe {
      let typeCount: Int = 1 + (usesNum ? 1 : 0) + (usesSym ? 1 : 0) // + (usesLetters ? 1 : 0)
      let numberCount: Int = usesNum ? Int(characterCount / typeCount) : 0 // Calculate the number of numeric characters to include in the password
      let symbolCount: Int = usesSym ? Int(characterCount / typeCount) : 0 // Calculate the number of special characters to include in the password
      let newCharCount: Int = characterCount - numberCount - symbolCount // Calculate the number of alphabetical characters to include in the password
      // - Fixme: ⚠️️ Maybe min-max a bit here, or look at legacy code to see how it was done there
      return .init( // Return a password recipe based on the calculated values
         charCount: newCharCount, // The number of characters in the password
         numCount: numberCount, // The number of numbers in the password
         symCount: symbolCount // The number of symbols in the password
      )
   }
   /**
    * Returns a random string for a password recipe (letters, numbers, special-characters)
    * - Description: This function generates a random string based on the given parameters. The parameters specify the number of letters, numbers, and special characters to include in the string. The function uses the OS entropy database (Nonce) to generate a unique random string of a specified length.
    * - Uses the kinetic OS entropy database (Nonce) to generate the string
    * - The returned string will have a length equal to the sum of charCount, numCount, and symCount
    * - Throws RandErr.unableToGenerateBase if unable to generate a unique random string
    * - Note: Alt name: `makeRandomPassword`
    * ## Examples:
    * RandPSW.getRandomPassword(charCount: 4, numCount: 8, symCount: 2) // cPNe&$jXzp2p@
    * try? RandPSW.randomPassword(recipe: recipe)
    * - Parameters:
    *   - charCount: Number of letters in the returned string
    *   - numCount: Number of digits in the returned string
    *   - symCount: Number of special characters in the returned string
    * - Returns: A random string containing the specified number of letters, digits, and special characters
    */
   fileprivate static func makeRandomWord(charCount: Int, numCount: Int, symCount: Int) throws -> String {
      let letters: String = try letters(charCount: charCount) // Get random letters
      let nums: String = try numbers(numCount: numCount) // Get random numbers
      let spec: String = try specials(symCount: symCount) // Get random special characters
      let base: [Character] = .init(letters + nums + spec) // Combine the strings
      // Create random string of a length based on base
      guard let str: String = try? .randomNonceStr(  // Attempts to generate a random string using a nonce strategy
         base: base, // The base character set to use for generating the string
         len: base.count, // The length of the string to generate
         unique: true // Whether to generate a unique random string
      ) else {
         throw RandErr.unableToGenerateBase
      }
      return str // Return random string
   }
   /**
    * Generates a random string of letters with a length of charCount
    * - Description: This function generates a random string of letters. The length of the string is determined by the charCount parameter. The function uses the OS entropy database (Nonce) to generate a unique random string of a specified length.
    * - If charCount is 0, returns an empty string
    * - Throws RandErr.unableToGenerateLetters if unable to generate a unique random string
    * ## Examples:
    * try? RandPSW.letters(charCount: 8) // "aBcDeFgH"
    * - Parameters:
    *   - charCount: Number of letters in the returned string
    * - Returns: A random string containing the specified number of letters
    */
   fileprivate static func letters(charCount: Int) throws -> String {
      guard charCount > 0 else { return "" } // Simplified check for charCount being 0
      // Attempt to generate a random string of letters
      guard let letters: String = try? .randomNonceStr(
         base: String.lowerAndUpperCaseLetters, // Use both lower and upper case letters
         len: charCount // The desired length of the string
      ) else {
         throw RandErr.unableToGenerateLetters // Throw an error if unable to generate the string
      }
      return letters // Return the random string of letters
   }
   /**
    * Generates a random string of numbers with a length of numCount
    * - Description: This function generates a random string of numbers. The length of the string is determined by the numCount parameter. The function uses the OS entropy database (Nonce) to generate a unique random string of a specified length.
    * - If numCount is 0, returns an empty string
    * - Throws RandErr.unableToGenerateNumbers if unable to generate a unique random string
    * ## Examples:
    * try? RandPSW.numbers(numCount: 6) // "123456"
    * - Parameters:
    *   - numCount: Number of digits in the returned string
    * - Returns: A random string containing the specified number of digits
    * - Fixme: ⚠️️ Refactor this later, quick fix
    */
   fileprivate static func numbers(numCount: Int) throws -> String {
      // Return an empty string if the requested number count is 0
      guard numCount > 0 else { return "" }
      // Attempt to generate a random string of numbers using the specified length
      guard let numbers: String = try? .randomNonceStr(
         base: String.numerals, // Define numerals as the base characters for the string
         len: numCount // Set the desired length of the random string
      ) else {
         // Throw an error if the random string generation fails
         throw RandErr.unableToGenerateNumbers
      }
      // Return the successfully generated string of numbers
      return numbers
   }
   /**
    * Generates a random string of special characters with a length of symCount
    * - Description: This function generates a random string of special characters. The length of the string is determined by the symCount parameter. The function uses the OS entropy database (Nonce) to generate a unique random string of a specified length.
    * - If symCount is 0, returns an empty string
    * - Throws RandErr.unableToGenerateSymbols if unable to generate a unique random string
    * ## Examples:
    * try? RandPSW.specials(symCount: 4) // "!@#$"
    * - Parameters:
    *   - symCount: Number of special characters in the returned string
    * - Returns: A random string containing the specified number of special characters
    */
   fileprivate static func specials(symCount: Int) throws -> String {
      guard symCount > 0 else { return "" } // Directly return an empty string if symCount is 0
      // Attempt to generate a random string of special characters
      guard let specials: String = try? .randomNonceStr(
         base: String.specialCharacters, // Use special characters as the base
         len: symCount // Desired length of the string
      ) else {
         throw RandErr.unableToGenerateSymbols // Throw error if generation fails
      }
      return specials // Return the generated string
   }
}
// deprecated ⚠️️
extension RandPSW {
   // deprecated ⚠️️
   @available(*, deprecated, renamed: "makeRandomPassword")
   public static func makeRandomWord(recipe: PasswordRecipe) throws -> String {
      try makeRandomPassword(recipe: recipe)
   }
}
