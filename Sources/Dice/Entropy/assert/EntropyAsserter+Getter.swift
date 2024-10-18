import Foundation
/**
 * Getter
 */
extension EntropyAsserter {
   /**
    * Returns the entropy strength (strong, medium, weak, none) for a given password string.
    * - Description: This function calculates the strength of a given password
    *                string based on its entropy. It uses the `EntropyParser` to
    *                get the metadata of the password, including the count of
    *                letter, number, and special characters. It then compares
    *                these counts with the thresholds defined for each entropy
    *                level (strong, medium, weak, none). The function returns the
    *                highest entropy level for which all thresholds are met. If
    *                no thresholds are met, it returns 'none'.
    * - Parameter string: The password string to measure the strength of.
    * - Returns: An `Entropy` value representing the strength of the password.
    * - Fixme: ⚠️️ Ask copilot to refactor and simplify? maybe use Range? copilot doesnt seem to find a better solution
    */
   public static func getStrength(string: String) -> Entropy {
      // Retrieves the metadata of the given password string using the EntropyParser
      let pswMeta = EntropyParser.getPasswordMetaData(password: string)
      // Check if the password meets the threshold for each character type
      return Entropy.allCases.first { entropy in
         pswMeta.letterCharCount >= entropy.threshold.letter && // Check if the number of letter characters meets the threshold for the current entropy level
         pswMeta.numberCharCount >= entropy.threshold.num && // Check if the number of numeric characters meets the threshold for the current entropy level
         pswMeta.specialCharCount >= entropy.threshold.special // Check if the number of special characters meets the threshold for the current entropy level
      } ?? .none // Return true if the password meets all the threshold requirements, Return the entropy value if a match was found, otherwise return none
   }
}
