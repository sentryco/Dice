import Foundation
/**
 * Types
 */
extension RandPSW {
   /**
    * Random password error
    * - Description: Enumerates the potential errors that can occur during
    *                the random password generation process. Each case
    *                represents a specific type of failure that can prevent
    *                the successful creation of a password component.
    */
   enum RandErr: Error {
      // Define error cases for when we are unable to generate letters, numbers, symbols, or the base password.
      case unableToGenerateLetters // Indicates failure to generate alphabetical characters
      case unableToGenerateNumbers // Indicates failure to generate numeric characters
      case unableToGenerateSymbols // Indicates failure to generate special characters
      case unableToGenerateBase // Indicates failure to generate the base password
       var errorDescription: String? {
            switch self {
            case .unableToGenerateLetters:
                return "Unable to generate letters for the password."
            case .unableToGenerateNumbers:
                return "Unable to generate numbers for the password."
            case .unableToGenerateSymbols:
                return "Unable to generate symbols for the password."
            case .unableToGenerateBase:
                return "Unable to generate the base password."
            }
        }
   }
   /**
    * Recipe
    */
   public struct PasswordRecipe {
      /**
       * The number of alphabetical characters in the password.
       * - Description: The number of alphabetical characters in the password.
       *                This defines how many letters from the alphabet will be
       *                included to enhance the password's complexity and security.
       */
      public let charCount: Int
      /**
       * The number of numeric characters in the password.
       * - Description: The number of numeric characters in the password. This
       *                defines how many digits will be included to enhance the
       *                password's complexity and security.
       */
      public let numCount: Int
      /**
       * The number of symbol characters in the password.
       * - Description: The number of symbol characters in the password. This
       *                defines how many special characters like punctuation
       *                marks or other non-alphanumeric symbols will be included
       *                to increase the password's complexity and security.
       */
      public let symCount: Int
      /**
       * Generates a random password with the specified number of alphabetical
       * characters, numbers, and symbols.
       * - Description: Initializes a new `PasswordRecipe` with the specified
       *                number of alphabetical, numeric, and symbol characters.
       *                This recipe can be used to generate passwords that conform
       *                to specific complexity requirements.
       * - Parameters:
       *   - charCount: The number of alphabetical characters in the password.
       *   - numCount: The number of numeric characters in the password.
       *   - symCount: The number of symbol characters in the password.
       */
      public init(charCount: Int, numCount: Int, symCount: Int) {
         self.charCount = charCount
         self.numCount = numCount
         self.symCount = symCount
      }
   }
}
