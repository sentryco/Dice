import Foundation
import CryptoKit
/**
 * Helper
 */
extension String {
   /**
    * Generates a random string of a given length and character set.
    * - Description: This method generates a cryptographically secure random
    *                nonce string. The length and character set of the string
    *                can be specified. If the 'unique' parameter is set to true,
    *                the method ensures that no character is repeated in the
    *                generated string.
    * - Parameters:
    *   - len: The length of the random string to generate.
    *   - base: The characters to include in the random string.
    *   - unique: If true, the generated string will not contain repeated characters.
    * - Returns: A random string of the specified length and character set.
    * - Remark: This is a convenience function that calls the `randomString`
    *           function with the `charSet` parameter set to the `base`
    *           parameter as an array of characters.
    */
   public static func randomNonceStr(base: [Character] = EntropyGenerator.defaultCharSet, len: Int, unique: Bool = false) throws -> String {
      let strSet: [String] = base.map(String.init) /*base.map { String($0) }*/ // Convert the character set to an array of strings
      return try EntropyGenerator.randomNonceString(
         length: len, // The length of the nonce string
         charSet: strSet, // The character set to use for generating the nonce string
         unique: unique // Whether the nonce string should be unique or not
      ) // Call the `randomNonceString` function with the string array as the character set
   }
}
