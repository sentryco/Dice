import Foundation
import CryptoKit
/**
 * Const
 */
extension EntropyGenerator {
   /**
    * The default character set for generating random strings (alphanumeric, `-`, `.`, and `_`).
    * - Description: This character set is used as the default set of characters when generating random strings. It includes alphanumeric characters, as well as '-', '.', and '_'.
    * fix: we could consider using the character set methods that we use some other places etc
    */
   public static let defaultCharSet: [Character] = {
      .init("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
   }()
   /**
    * The default string set for generating random strings (derived from `defaultCharSet`).
    * - Description: This string set is derived from the default character set. It is used as the default set of strings when generating random strings. Each character in the default character set is converted to a string.
    */
   public static let defaultStrSet: [String] = defaultCharSet.map { String($0) }
}
