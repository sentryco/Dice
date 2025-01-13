import XCTest
@testable import Dice

extension DiceTests {
   /**
    * - Fixme: ⚠️️ add doc
    * - Description: Generates a large number of passwords and analyzes the distribution of characters to verify uniform randomness.
    */
   func testCharacterDistribution() throws {
      let passwordCount = 1_000_000
      var occurrences: [Character: Int] = [:]
      let characterSet = EntropyGenerator.defaultCharSet
      
      for _ in 0..<passwordCount {
         let password = try EntropyGenerator.randomNonceString(length: 1)
         let character = password.first!
         occurrences[character, default: 0] += 1
      }
      
      // Analyze the occurrences
      let expectedFrequency = passwordCount / characterSet.count
      let tolerance = expectedFrequency / 10  // Allow 10% variance
      
      for (character, count) in occurrences {
         XCTAssert(abs(count - expectedFrequency) < tolerance, "Character \(character) frequency is out of expected range.")
      }
   }
   /**
    * - Fixme: ⚠️️ add doc
    */
   func testPasswordGenerationUsingRecipe() throws {
      let recipe = RandPSW.PasswordRecipe(charCount: 10, numCount: 5, symCount: 2)
      let password = try RandPSW.makeRandomPassword(recipe: recipe)
      XCTAssertEqual(password.count, 17)
      // Additional assertions to verify the composition of the password
   }
   /**
    * - Fixme: ⚠️️ add doc
    * - Fixme: ⚠️️ fix the broken tests
    */
   func testEntropyLevels() throws {
      // Test empty string
      XCTAssertEqual(EntropyAsserter.getStrength(string: ""), .none)
      
      // Test minimal weak password at threshold
      let weakPasswordAtThreshold = String(repeating: "a", count: 4) + String(repeating: "1", count: 2) + "A" + "b"
      XCTAssertEqual(EntropyAsserter.getStrength(string: weakPasswordAtThreshold), .weak)
      
      // Test just below weak threshold
      let weakPasswordBelowThreshold = String(repeating: "a", count: 3) + String(repeating: "1", count: 1)
      XCTAssertEqual(EntropyAsserter.getStrength(string: weakPasswordBelowThreshold), .none)
      
      // Test minimal medium password at threshold
      let mediumPasswordAtThreshold = String(repeating: "a", count: 6) + String(repeating: "1", count: 6) + "AA" + "bb"
      XCTAssertEqual(EntropyAsserter.getStrength(string: mediumPasswordAtThreshold), .medium)
      
      // Test just below medium threshold
      let mediumPasswordBelowThreshold = String(repeating: "a", count: 5) + String(repeating: "1", count: 5) + "A" + "b"
      XCTAssertEqual(EntropyAsserter.getStrength(string: mediumPasswordBelowThreshold), .weak)
      
      // Test minimal strong password at threshold
      let strongPasswordAtThreshold = String(repeating: "a", count: 16) + String(repeating: "1", count: 8) + String(repeating: "A", count: 4) + String(repeating: "b", count: 4)
      XCTAssertEqual(EntropyAsserter.getStrength(string: strongPasswordAtThreshold), .strong)
      
      // Test just below strong threshold
      let strongPasswordBelowThreshold = String(repeating: "a", count: 15) + String(repeating: "1", count: 7) + String(repeating: "A", count: 3) + String(repeating: "b", count: 3)
      XCTAssertEqual(EntropyAsserter.getStrength(string: strongPasswordBelowThreshold), .medium)
      
      // Test password with special characters (special characters are now counted towards thresholds)
//      let passwordWithSpecialChars = String(repeating: "a", count: 10) + String(repeating: "1", count: 5) + "!@#$%"
//      XCTAssertEqual(EntropyAsserter.getStrength(string: passwordWithSpecialChars), .strong)
      
      // Test password with only letters
//      let lettersOnlyPassword = String(repeating: "a", count: 20)
//      XCTAssertEqual(EntropyAsserter.getStrength(string: lettersOnlyPassword), .weak)
      
      // Test password with only numbers
//      let numbersOnlyPassword = String(repeating: "1", count: 20)
//      XCTAssertEqual(EntropyAsserter.getStrength(string: numbersOnlyPassword), .weak)
      
      // Test password with mixed uppercase and lowercase letters
//      let mixedCasePassword = String(repeating: "A", count: 10) + String(repeating: "b", count: 10)
//      XCTAssertEqual(EntropyAsserter.getStrength(string: mixedCasePassword), .medium)
      
      // Test password with Unicode characters
//      let unicodePassword = "密码12345ABCDEabcde"
//      XCTAssertEqual(EntropyAsserter.getStrength(string: unicodePassword), .strong)
      // Generate random passwords and test their strength
//      for _ in 0..<10 {
//         let randomLength = Int.random(in: 1...50)
//         let randomPassword = try EntropyGenerator.randomNonceString(length: randomLength)
//         let strength = EntropyAsserter.getStrength(string: randomPassword)
//         // Assert that random passwords of sufficient length are at least weak
//         if randomLength >= 6 {
//            XCTAssertNotEqual(strength, .none)
//         } else {
//            XCTAssertEqual(strength, .none)
//         }
//      }
      
      // Edge case: Very long password
      let veryLongPassword = String(repeating: "abcdABCD1234", count: 100)
      XCTAssertEqual(EntropyAsserter.getStrength(string: veryLongPassword), .strong)
   }
   // Test Password Length Constraints
   // Ensure that the password generator correctly handles minimum and maximum length constraints.
   func testPasswordLengthConstraints() throws {
      // Test minimum length
      let minLength = 1
      let passwordMin = try RandPSW.makeRandomPassword(
         recipe: .init(
               charCount: minLength,
               numCount: 0,
               symCount: 0
         )
      )
      XCTAssertEqual(passwordMin.count, minLength, "Password does not match the minimum length")

      // Test maximum length
      let maxLength = 100
      let passwordMax = try RandPSW.makeRandomPassword(
         recipe: .init(
               charCount: maxLength,
               numCount: 0,
               symCount: 0
         )
      )
      XCTAssertEqual(passwordMax.count, maxLength, "Password does not match the maximum length")

      // Test invalid length (zero or negative)
      XCTAssertThrowsError(
         try RandPSW.makeRandomPassword(
               recipe: .init(
                  charCount: 0,
                  numCount: 0,
                  symCount: 0
               )
         ),
         "Expected error for zero length not thrown"
      )
      XCTAssertThrowsError(
         try RandPSW.makeRandomPassword(
               recipe: .init(
                  charCount: -5,
                  numCount: 0,
                  symCount: 0
               )
         ),
         "Expected error for negative length not thrown"
      )
   }
   // Test Password Composition Constraints
   // Ensure that passwords are generated with the correct composition of characters as specified in the recipe.  
   func testPasswordComposition() throws {
      let recipe = RandPSW.PasswordRecipe(charCount: 5, numCount: 3, symCount: 2)
      let password = try RandPSW.makeRandomPassword(recipe: recipe)
      XCTAssertEqual(password.count, 10, "Password length does not match the sum of recipe components")

      // Analyze password composition
      let letters = password.filter { $0.isLetter }
      let numbers = password.filter { $0.isNumber }
      let symbols = password.filter { String.specialCharacters.contains($0) }

      XCTAssertEqual(letters.count, recipe.charCount, "Incorrect number of letters")
      XCTAssertEqual(numbers.count, recipe.numCount, "Incorrect number of numbers")
      XCTAssertEqual(symbols.count, recipe.symCount, "Incorrect number of symbols")
   }
   // Test Unique Characters in Passwords
   // Ensure that passwords generated with the unique flag have no duplicate characters.
   func testUniqueCharactersInPassword() throws {
      let length = EntropyGenerator.defaultStrSet.count
      let password = try EntropyGenerator.randomNonceString(length: length, unique: true)
      XCTAssertEqual(password.count, length, "Password length does not match the character set count")

      let uniqueChars = Set(password)
      XCTAssertEqual(uniqueChars.count, length, "Password contains duplicate characters")
   }
   // Test Word-Based Password Generation
   // Ensure that word-based passwords are generated correctly with the specified number of words and separators.
    func testWordBasedPasswordGeneration() throws {
       let wordCount = 6
       let separator = "-"
       let password = try RandPSW.makeRandomWords(length: wordCount, seperator: separator)
       let words = password.split(separator: Character(separator))
       XCTAssertEqual(words.count, wordCount, "Incorrect number of words in password")

       // Ensure each word is from the seed word list
       for word in words {
          XCTAssertTrue(SeedWordList.words.contains(String(word).lowercased()), "Word '\(word)' not found in seed word list")
       }
    }
    // Test Entropy Levels with Edge Cases
   // Test passwords that are on the edge of different entropy levels to ensure the EntropyAsserter correctly classifies them.
   func testEntropyLevelEdgeCases() throws {
      // Weak password edge case
      let weakPassword = "aA1"
      XCTAssertEqual(EntropyAsserter.getStrength(string: weakPassword), .none, "Weak password incorrectly classified")

      // Just meets weak threshold
      let weakThresholdPassword = "aA1bB2"
      XCTAssertEqual(EntropyAsserter.getStrength(string: weakThresholdPassword), .weak, "Password not classified as weak")

      // Medium password edge case
      let mediumPassword = "aA1bB2cC3dD4eE5fF6"
      XCTAssertEqual(EntropyAsserter.getStrength(string: mediumPassword), .medium, "Password not classified as medium")

      // Strong password edge case
      let strongPassword = String(repeating: "aA1", count: 10)
      XCTAssertEqual(EntropyAsserter.getStrength(string: strongPassword), .strong, "Password not classified as strong")
   }
   // Test Character Distribution Over Large Sample
   // Ensure that over a large sample, the character distribution is approximately uniform.
   func testCharacterDistributionOverLargeSample() throws {
      let passwordCount = 100_000
      var occurrences: [Character: Int] = [:]
      let characterSet = EntropyGenerator.defaultCharSet

      for _ in 0..<passwordCount {
         let password = try EntropyGenerator.randomNonceString(length: 1)
         let character = password.first!
         occurrences[character, default: 0] += 1
      }

      // Analyze the occurrences
      let expectedFrequency = Double(passwordCount) / Double(characterSet.count)
      let tolerance = expectedFrequency * 0.10  // Allow 10% variance

      for (character, count) in occurrences {
         let difference = abs(Double(count) - expectedFrequency)
         XCTAssertLessThanOrEqual(difference, tolerance, "Character \(character) frequency is out of expected range.")
      }
   }
   // Test Special Character Inclusion
   // Ensure that passwords include special characters when requested.
   func testSpecialCharacterInclusion() throws {
      let recipe = RandPSW.PasswordRecipe(charCount: 0, numCount: 0, symCount: 5)
      let password = try RandPSW.makeRandomPassword(recipe: recipe)
      XCTAssertEqual(password.count, 5, "Password length does not match the number of symbols requested")

      let symbols = password.filter { String.specialCharacters.contains($0) }
      XCTAssertEqual(symbols.count, 5, "Password does not contain the correct number of special characters")
   }
   // Test Numeric Only Password
   // Ensure that the generator can create a password with only numbers.
   func testNumericOnlyPassword() throws {
      let recipe = RandPSW.PasswordRecipe(charCount: 0, numCount: 10, symCount: 0)
      let password = try RandPSW.makeRandomPassword(recipe: recipe)
      XCTAssertEqual(password.count, 10, "Password length does not match the number of numbers requested")

      let numbers = password.filter { $0.isNumber }
      XCTAssertEqual(numbers.count, 10, "Password contains non-numeric characters")
   }
   // Test Exception Handling for Invalid Parameters
   // Ensure that the generator throws appropriate errors for invalid inputs.
   func testInvalidParametersHandling() {
      XCTAssertThrowsError(
         try RandPSW.makeRandomPassword(recipe: .init(charCount: -1, numCount: 0, symCount: 0)),
         "Expected error for negative character count not thrown"
      )

      XCTAssertThrowsError(
         try EntropyGenerator.randomNonceString(length: -5),
         "Expected error for negative length not thrown"
      )
      
      XCTAssertThrowsError(
         try EntropyGenerator.randomNonceString(length: 0),
         "Expected error for zero length not thrown"
      )
   }
   // Test Seed Word List Validity
   // Ensure that the seed word list is properly loaded and contains expected words.
   func testSeedWordListLoading() {
      let words = SeedWordList.words
      XCTAssertFalse(words.isEmpty, "Seed word list is empty")
      // Check for known words
      XCTAssertTrue(words.contains("abandon"), "Known word 'abandon' not found in seed word list")
      XCTAssertTrue(words.contains("yellow"), "Known word 'yellow' not found in seed word list")
   }
   // Test Password Generation with Empty Recipe
   // Ensure that the generator handles an empty recipe gracefully.
   func testPasswordGenerationWithEmptyRecipe() throws {
      let recipe = RandPSW.PasswordRecipe(charCount: 0, numCount: 0, symCount: 0)
      XCTAssertThrowsError(
         try RandPSW.makeRandomPassword(recipe: recipe),
         "Expected error for empty recipe not thrown"
      )
   }
   // Test Password Generation with Large Inputs
   // Ensure that the generator can handle very large inputs without performance degradation or errors.
   func testPasswordGenerationWithLargeInputs() throws {
      let recipe = RandPSW.PasswordRecipe(charCount: 20, numCount: 20, symCount: 10)
      let password = try RandPSW.makeRandomPassword(recipe: recipe)
      XCTAssertEqual(password.count, 50, "Password length does not match the sum of recipe components")
   }
   // Test Randomness of Passwords
   // Generate multiple passwords with the same recipe and ensure they are different.
   func testPasswordRandomness() throws {
      let recipe = RandPSW.PasswordRecipe(charCount: 10, numCount: 5, symCount: 2)
      let password1 = try RandPSW.makeRandomPassword(recipe: recipe)
      let password2 = try RandPSW.makeRandomPassword(recipe: recipe)
      XCTAssertNotEqual(password1, password2, "Passwords should not be equal")
   }
   // Test Entropy Threshold Adjustments
   // Ensure that changing entropy thresholds affects the password strength classification.
   func testEntropyThresholdAdjustments() throws {
      // Save original thresholds
      let originalStrongThreshold = EntropyAsserter.Entropy.Threshold.strongThreshold
      defer {
         // Restore original thresholds after test
         EntropyAsserter.Entropy.Threshold.strongThreshold = originalStrongThreshold
      }

      // Adjust strong threshold to be higher
      EntropyAsserter.Entropy.Threshold.strongThreshold = .init(letter: 50, num: 50, upper: 25, lower: 25, special: 10)

      let strongPassword = String(repeating: "aA1$", count: 10)
      XCTAssertEqual(EntropyAsserter.getStrength(string: strongPassword), .medium, "Password incorrectly classified after threshold adjustment")
   }
}
