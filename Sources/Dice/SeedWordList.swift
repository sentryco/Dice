import Foundation
import JSONSugar
import FileSugar
import Logger
/**
 * JSON -> String-Array
 */
public final class SeedWordList {
   /**
    * Returns an array of "bitcoin-seed-words" used for word-based passwords.
    * - Description: This class provides a static collection of seed words that
    *                can be used to generate secure word-based passwords. The
    *                words are sourced from a JSON file containing a list
    *                compliant with the BIP-0039 standard for deterministic
    *                wallets.
    * - Remark: The `Config.Bundle.assets` cannot be used for some reason.
    * - Important: The files inside the assets bundle are moved into the
    *              resource path.
    * - Note: The word list is based on the BIP-0039 standard and can be found
    *         at https://github.com/bitcoin/bips/blob/master/bip-0039/english.txt#L608.
    * - Fixme: ⚠️️ Consider storing the word list in a plist instead of a JSON file.
    * - Fixme: ⚠️️ Consider throwing an error if the resources are not available.
    * - Fixme: ⚠️️ This functionality is also available via the Account package.
    */
   public static let words: [String] = {
      guard let resourcePath: String = Foundation.Bundle.module.resourcePath else {
         // This line logs a warning message with a trace and tag to the console
         Logger.warn("\(Trace.trace()) Error getting resourcePath", tag: .security)
         return []
      } // Get the resource path for the module
      let filePath: String = resourcePath + "/" + "words.json" // Define the file path to the word list
      guard let data: Data = FileParser.data(filePath: filePath) else {
         // This line logs a warning message with a trace and tag to the console
         Logger.warn("\(Trace.trace()) Error reading data: \(filePath)", tag: .security)
         return []
      } // Get the data from the file
      guard let items: [String] = try? data.decode() else {
         // This line logs a warning message with a trace and tag to the console
         Logger.warn("\(Trace.trace()) Error parsing JSON", tag: .security)
         return []
      } // Decode the data to a string array
      return items.sorted() // Sort the array alphabetically
   }()
}
