import Foundation
/**
 * Helper - CharacterSetParser
 */
final class CharacterSetParser {
   /**
    * Returns the number of occurrences of a given character set in a string.
    * - Description: This function counts the number of occurrences of a specified character set in a given string. The character set can be inverted to count all characters not in the set.
    * - Fixme: ⚠️️ Maybe there is a faster way to count occurrences?
    * - Fix: rename to getOccurrences. there is a typo currently
    * - Examples:
    *   - `occurrences(str: "abc123$%#", characterSet: .decimalDigits)` returns `3` (numbers).
    *   - `occurrences(str: "abc123$%#", characterSet: .alphanumerics)` returns `6` (letters and numbers).
    *   - `occurrences(str: "abc123$%#", characterSet: .letters)` returns `3` (letters).
    *   - `occurrences(str: "abc123$%#", characterSet: .alphanumerics, inverted: false)` returns `3` (non-letter/numbers).
    * - Remark: We do the joined, because then we avoid the tail issue in components array.
    * - Parameters:
    *   - str: The string to count on.
    *   - characterSet: The character set to count.
    *   - inverted: Whether to count all but the given character set.
    * - Returns: The number of occurrences of the given character set in the string.
    */
   internal static func getOccurences(str: String, characterSet: CharacterSet, inverted: Bool = true) -> Int {
      let filteredString = str.unicodeScalars.filter { char in
         inverted ? !characterSet.contains(char) : characterSet.contains(char)
      }
      return filteredString.count
      // was ⚠️️
      // let charSet: CharacterSet = inverted ? characterSet.inverted : characterSet // Find all specified characters
      // return str.components(separatedBy: charSet).joined().count // Count the number of occurrences of the specified characters
   }
}
