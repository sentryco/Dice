import XCTest
import Dice

final class DiceTests: XCTestCase {
   /**
    * Tests
    */
    func testExample() {
       do {
          try Self.testRecipe() // Tests password creation with a recipe
          try Self.testCryptoPassword() // Tests nonce based entropy
          try Self.testWordBasedCryptoPassword() // Tests word based nonce entropy
          // - Fixme: ⚠️️ add test that use the makePasswordRecipe
       } catch {
          Swift.print("Error:  \(error)")
       }
    }
}
extension DiceTests {
   /**
    * Password recipe test
    * - Description: Tests password creation with a recipe
    * - Fixme: ⚠️️ Test if password has the recipe setup somehow, use that apple api analyzer or some other analyser, see issues, what about katana? the repo is saved in priv repos etc
    */
   fileprivate static func testRecipe() throws {
      let recipe: RandPSW.PasswordRecipe = .init(
         charCount: 4, // The number of characters in the password
         numCount: 0, // The number of numbers in the password
         symCount: 4 // The number of symbols in the password
      ) // Create a password recipe with 4 characters and 4 symbols, but no numbers, and assign it to `recipe`
      let psw: String = try RandPSW.makeRandomPassword(recipe: recipe) // Generate a random password using the `RandPSW.getRandomPassword` method and the `recipe`, and assign it to `psw`. If the password generation fails, throw an error.
      // Swift.print("psw: \(String(describing: psw))")
      let equals: Bool = psw.count == 8
      Swift.print("Length equals: \(equals ? "✅" : "🚫")")
      XCTAssertTrue(equals)
   }
   /**
    * Test crypto based passwords (Nonce based entropy)
    * - Description: Tests if all characters are unique
    */
   fileprivate static func testCryptoPassword() throws {
      let cryptoBasedPSW: String = try RandPSW.makeRandomPassword(
         recipe: .init(
            charCount: 4, // The number of characters in the password
            numCount: 8, // The number of numbers in the password
            symCount: 2 // The number of symbols in the password
         )
      ) // Generate a random password with 4 characters, 8 numbers, and 2 symbols using the `RandPSW.getRandomPassword` method, and assign it to `cryptoBasedPSW`. If the password generation fails, throw an error.
      let hasNoDups: Bool = !ArrayAsserter.hasDuplicates(inputArr: cryptoBasedPSW.components(separatedBy: "")) // Check if the `cryptoBasedPSW` string has any duplicate characters by splitting it into an array of characters using `components(separatedBy:)`, and passing the resulting array to the `ArrayAsserter.hasDuplicates` method. We then negate the resulting boolean value using the `!` operator and assign it to `hasNoDups`. The comments describe each line of code and its purpose.
      Swift.print("hasNoDups: \(hasNoDups ? "✅" : "🚫")")
      XCTAssertTrue(hasNoDups)
   }
   /**
    * Test crypto based `word-based` password (Nonce based entropy)
    * - Description: Tests the generation of a word-based password using nonce-based entropy to ensure all words are unique and the password meets the specified length requirement.
    * - Remark: Tests if all words are unique
    * - Fixme: ⚠️️ add random count?
    */
   fileprivate static func testWordBasedCryptoPassword() throws {
      let wordBasedPassword: String = try RandPSW.makeRandomWords(
         length: 14, // The length of the password
         seperator: "-" // The separator to use between words in the password
      ) // Generate a random password consisting of 14 words separated by hyphens using the `RandPSW.getRandomWords` method, and assign it to `wordBasedPassword`. If the password generation fails, throw an error.
      let arr: [String.SubSequence] = wordBasedPassword.split(separator: "-") // Split the `wordBasedPassword` string into an array of substrings using the hyphen separator, and assign it to `arr`.
      XCTAssertEqual(arr.count, 14) // Assert that the `arr` array has a count of 14 using the `XCTAssertEqual` method.
      let hasNoDups: Bool = !ArrayAsserter.hasDuplicates(inputArr: wordBasedPassword.components(separatedBy: "-")) // Check if the `wordBasedPassword` string has any duplicate words by splitting it into an array of words using `components(separatedBy:)`, and passing the resulting array to the `ArrayAsserter.hasDuplicates` method. We then negate the resulting boolean value using the `!` operator and assign it to `hasNoDups`. The comments describe each line of code and its purpose.
      Swift.print("hasNoDups: \(hasNoDups ? "✅" : "🚫")")
      XCTAssertTrue(hasNoDups) // Assert that `hasNoDups` is true
   }
}
/**
 * Helpers
 */
final class ArrayAsserter {
   /**
    * - Description: Determines if an array contains duplicate elements by comparing each element with the rest of the array.
    * ## Examples:
    * hasDuplicats(inputArr: [1, 2, 3]) // false
    * hasDuplicats(inputArr: [1, 2, 1, 3]) // true
    */
   internal static func hasDuplicates<T: Comparable>(inputArr: [T]) -> Bool {
      // - Fixme: ⚠️️ You forget that self will give false posetive here?
      // - inputArr.contains { item in inputArr.contains { item == $0 } }
      var tempArr: [T] = inputArr // Create a mutable copy of the `inputArr` array and assign it to `tempArr`
      var last: T = tempArr[tempArr.count - 1] // Assign the last element of `tempArr` to `last`
      var hasDups: Bool = false // Initialize `hasDups` to `false`
      while !tempArr.isEmpty { // Loop while `tempArr` is not empty
         last = tempArr[tempArr.count - 1] // Assign the last element of `tempArr` to `last`
         tempArr = Array(tempArr[0..<(tempArr.count - 1)]) // Remove the last element from `tempArr`
         if tempArr.contains(last) { hasDups = true; break } // If `tempArr` contains `last`, set `hasDups` to `true` and break out of the loop
      }
      return hasDups // Return the value of `hasDups`
   }
}
