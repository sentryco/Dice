import Foundation
/**
 * Getter
 */
extension EntropyParser {
   /**
    * Returns a structure containing the analysis of a password.
    * - Description: This function analyzes a given password and returns a `PasswordMetaData` structure. The structure contains the count of various types of characters in the password, including letters, numbers, special characters, and the count of lowercase and uppercase letters.
    * - Remark: This function counts the number of letters, numbers, and special characters in the input password.
    * - Parameters:
    *   - password: The password to analyze.
    * - Returns: A `PasswordMetaData` structure containing the number of letters, numbers, and special characters in the password.
    * ## Example:
    *   let pswMeta: PasswordMetaData = passwordMetaData(password: "abc12345$")
    *   pswMeta.letterCharCount // 3
    *   pswMeta.numberCharCount // 5
    *   pswMeta.specialCharCount // 1
    */
   public static func getPasswordMetaData(password: String) -> PasswordMetaData {
      // - Fixme: ⚠️️ maybe break this method up ?
      let specialCount: Int = CharacterSetParser.getOccurences(
         str: password, // The string to count the occurrences in
         characterSet: .alphanumerics, // The character set to count the occurrences of
         inverted: false // Whether to invert the character set or not
      ) // Get number of special chars
      let numberCount: Int = CharacterSetParser.getOccurences(
         str: password, // The string to count the occurrences in
         characterSet: .decimalDigits // The character set to count the occurrences of
      )  // Get number of numbers chars
      let letterCount: Int = CharacterSetParser.getOccurences(
         str: password, // The string to count the occurrences in
         characterSet: .letters // The character set to count the occurrences of
      )  // Get number of letters
      let lowerCaseCount: Int = CharacterSetParser.getOccurences(
         str: password, // The string to count the occurrences in
         characterSet: .lowercaseLetters // The character set to count the occurrences of
      )  // Get number of upper-case letters
      let upperCaseCount: Int = CharacterSetParser.getOccurences(
         str: password, // The string to count the occurrences in
         characterSet: .uppercaseLetters // The character set to count the occurrences of
      )  // Get number of lower-case letters
      return .init(
         letterCharCount: letterCount, // The count of letter characters in the password
         numberCharCount: numberCount, // The count of number characters in the password
         specialCharCount: specialCount, // The count of special characters in the password
         lowerCaseCharCount: lowerCaseCount, // The count of lowercase characters in the password
         upperCaseCharCount: upperCaseCount // The count of uppercase characters in the password
      ) // Return Meta-data regarding the string
   }
}
