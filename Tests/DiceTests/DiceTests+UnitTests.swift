import XCTest
import Dice

extension DiceTests {
   /**
    * - Fixme: ⚠️️ add doc
    * - Description: Generates a large number of passwords and analyzes the distribution of characters to verify uniform randomness.
    */
   func testCharacterDistribution() throws {
      let passwordCount = 1_000_000
      var occurrences: [Character: Int] = [:]
      let characterSet = EntropyGenerator.defaultCharSet
      
      for _ in 0..<passwordCount {
         let password = try EntropyGenerator.randomNonceString(length: 1)
         let character = password.first!
         occurrences[character, default: 0] += 1
      }
      
      // Analyze the occurrences
      let expectedFrequency = passwordCount / characterSet.count
      let tolerance = expectedFrequency / 10  // Allow 10% variance
      
      for (character, count) in occurrences {
         XCTAssert(abs(count - expectedFrequency) < tolerance, "Character \(character) frequency is out of expected range.")
      }
   }
}
