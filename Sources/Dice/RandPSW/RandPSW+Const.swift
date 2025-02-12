import Foundation
/**
 * Const
 */
extension RandPSW.PasswordRecipe {
   /**
    * A strong password recipe that generates a password with 20 characters,
    * 20 numbers, and 4 symbols.
    * - Description: This recipe generates a strong password with a high degree
    *                of complexity. It includes 20 alphanumeric characters and
    *                4 special symbols, ensuring a high level of security.
    */
   public static let strongPassword: RandPSW.PasswordRecipe = {
      .init(
         charCount: 20, // The number of characters in the password
         numCount: 20, // The number of numbers in the password
         symCount: 4 // The number of symbols in the password
      ) // Strong password recipe
   }()
}
/**
 * - Description: This extension provides character sets that are used for
 *                generating passwords. It includes sets of special
 *                characters, lowercase letters, uppercase letters, both
 *                lowercase and uppercase letters, and numeric characters.
 *                These sets are used to create passwords with varying levels
 *                of complexity and security.
 * - Note: To avoid ambiguity we remove 0, O, 0, l, L, I from char sets
 *         (even tho this decrease entropy)
 * - Fixme: ⚠️️ Potentially add toggle flag that removes ambiguity etc 👈
 *           add this feature later
 */
extension String {
   /**
    * A list of special characters that can be used in generated passwords.
    * - Description: This is a list of special characters that can be used in the passwords generated by the RandPSW class. It includes a variety of symbols and punctuation marks to increase the complexity and security of the passwords.
    */
   internal static let specialCharacters: [Character] = {
      .init("-~!@#$%^&*_+=(){}[<>?]") // Get all special characters
   }()
   /**
    * A list of lowercase letters that can be used in generated passwords.
    * - Description: This is a list of lowercase letters that can be used in
    *                the passwords generated by the RandPSW class. It includes
    *                all the lowercase letters from 'a' to 'z' to increase the
    *                complexity and security of the passwords.
    * - Remark: We use `compactMap` to filter out any `nil` values that may be
    *           returned by `UnicodeScalar.init`.
    * - Note: Also works: internal static let letters: [Character] = .init("abcdefghijkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ") // Get all lower and upper case letters
    * - Fixme: ⚠️️ We can also do: `Array("a"..."z") // Directly create an array of characters from "a" to "z"`
    * fixme: test performance array vs unicodescalar
    */
   internal static let lowerCaseLetters: [Character] = {
      // Array("a"..."z")
      // ⚠️️ was
      (UnicodeScalar("a").value...UnicodeScalar("z").value) // Get the range of Unicode scalar values for lowercase letters
         .compactMap { UnicodeScalar($0) } // Convert the scalar values to Unicode scalars
         .map { Character($0) } // Convert the Unicode scalars to characters
   }()
   /**
    * A list of uppercase letters that can be used in generated passwords.
    * - Description: This is a list of uppercase letters that can be used in
    *                the passwords generated by the RandPSW class. It includes
    *                all the uppercase letters from 'A' to 'Z' to increase the
    *                complexity and security of the passwords.
    * - Remark: We use `compactMap` to filter out any `nil` values that may be
    *           returned by `UnicodeScalar.init`.
    * - Fixme: ⚠️️ We can also do: `Array("A"..."Z") // Directly create an array of characters from "A" to "Z"`
    * fixme: test performance array vs unicodescalar
    */
   internal static let upperCaseLetters: [Character] = {
     // Array("A"..."Z")
      // ⚠️️ was
      (UnicodeScalar("A").value...UnicodeScalar("Z").value) // Get the range of Unicode scalar values for uppercase letters
         .compactMap { UnicodeScalar($0) } // Convert the scalar values to Unicode scalars
         .map { Character($0) } // Convert the Unicode scalars to characters
   }()
   /**
    * A list of both lowercase and uppercase letters that can be used in generated passwords.
    * - Description: This is a list of both lowercase and uppercase letters
    *                that can be used in the passwords generated by the
    *                RandPSW class. It includes all the letters from 'a' to
    *                'z' and 'A' to 'Z' to increase the complexity and
    *                security of the passwords.
    * fixme: test performance array vs unicodescalar
    */
   internal static let lowerAndUpperCaseLetters: [Character] = {
      lowerCaseLetters + upperCaseLetters // Concatenate the lists of lowercase and uppercase letters
   }()
   /**
    * A list of numeric characters that can be used in generated passwords.
    * - Description: This is a list of numeric characters that can be used in
    *                the passwords generated by the RandPSW class. It includes
    *                all the numbers from '0' to '9' to increase the
    *                complexity and security of the passwords.
    * - Note: Also works: internal static let numbers: [Character] = .init("123456789") // Get all numbers
    * - Remark: We use `compactMap` to filter out any `nil` values that may be returned by `UnicodeScalar.init`.
    * - Fixme: ⚠️️ We can also do: `Array("0"..."9") // Directly create an array of characters from "0" to "9"`
    * fixme: test performance array vs unicodescalar
    */
   internal static let numerals: [Character] = {
      // Array("0"..."9")
      // ⚠️️ was
       (UnicodeScalar("0").value...UnicodeScalar("9").value) // Get the range of Unicode scalar values for numeric characters
          .compactMap { UnicodeScalar($0) } // Convert the scalar values to Unicode scalars
          .map { Character($0) } // Convert the Unicode scalars to characters
   }()
}
