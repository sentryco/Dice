import Foundation
/**
 * Entropy
 */
extension EntropyAsserter {
   /**
    * The strength of a password, as determined by its entropy.
    * - Description: This enum represents the possible levels of password
    *                strength, determined by the entropy of the password. The
    *                levels range from 'none' (no entropy, invalid password) to
    *                'strong' (high entropy, strong password).
    */
   public enum Entropy: String, CaseIterable {
      /**
       * Password has high entropy and is considered strong
       */
      case strong
      /**
       * Password has moderate entropy and is considered medium strength
       */
      case medium
      /**
       * Password has low entropy and is considered weak
       */
      case weak
      /**
       * Password has no entropy and is considered invalid
       */
      case none
   }
}
