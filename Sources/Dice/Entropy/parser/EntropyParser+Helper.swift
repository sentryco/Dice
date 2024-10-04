import Foundation
/**
 * Helpers - Asserters
 */
extension PasswordMetaData {
   /**
    * Asserts whether a given password contains at least one numeric character.
    * - Description: This function checks if the given password contains at least one numeric character.
    * - Parameter password: The password to be checked.
    * - Returns: `true` if the password contains at least one numeric character, `false` otherwise.
    */
   public static func hasNum(psw: String) -> Bool {
      // Get the metadata for the given password
      let pswMeta: PasswordMetaData = EntropyParser.getPasswordMetaData(password: psw)
      // Check if the password contains at least one numeric character
      return pswMeta.numberCharCount > 0 // ⚠️️ isEmpty doesnt work on int
   }
   /**
    * Asserts whether a given password contains at least one special character.
    * - Description: This function checks if the given password contains at least one special character.
    * - Parameter psw: The password to be checked.
    * - Returns: `true` if the password contains at least one special character, `false` otherwise.
    */
   public static func hasSym(psw: String) -> Bool {
      // Get the metadata for the given password
      let pswMeta: PasswordMetaData = EntropyParser.getPasswordMetaData(password: psw)
      // Check if the password contains at least one special character
      return pswMeta.specialCharCount > 0 // ⚠️️ isEmpty doesnt work on int
   }
}
