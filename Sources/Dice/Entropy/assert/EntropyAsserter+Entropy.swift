import Foundation
/**
 * Entropy
 */
extension EntropyAsserter {
   /**
    * The strength of a password, as determined by its entropy.
    * - Description: This enum represents the possible levels of password strength, determined by the entropy of the password. The levels range from 'none' (no entropy, invalid password) to 'strong' (high entropy, strong password).
    */
   public enum Entropy: String, CaseIterable {
      /**
       * Password has high entropy and is considered strong
       * - Description: This level of password strength indicates a high level of complexity, including a mix of uppercase and lowercase letters, numbers, and special characters. It is the most secure level of password strength.
       */
      case strong
      /**
       * Password has moderate entropy and is considered medium strength
       * - Description: This level of password strength indicates a moderate level of complexity, including a mix of letters and numbers. It offers a reasonable level of security.
       */
      case medium
      /**
       * Password has low entropy and is considered weak
       * - Description: This level of password strength indicates a low level of complexity, often consisting of only letters or only numbers. It is the least secure level of password strength.
       */
      case weak
      /**
       * Password has no entropy and is considered invalid
       * - Description: This level of password strength indicates that the password does not meet the minimum requirements for complexity and is therefore considered invalid.
       */
      case none
   }
}
