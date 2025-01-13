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
   /**
    * - Fixme: ⚠️️ add doc
    */
   func testPasswordGenerationUsingRecipe() throws {
      let recipe = RandPSW.PasswordRecipe(charCount: 10, numCount: 5, symCount: 2)
      let password = try RandPSW.makeRandomPassword(recipe: recipe)
      XCTAssertEqual(password.count, 17)
      // Additional assertions to verify the composition of the password
   }
   /**
    * - Fixme: ⚠️️ add doc
    * - Fixme: ⚠️️ fix the broken tests
    */
   func testEntropyLevels() throws {
      // Test empty string
      XCTAssertEqual(EntropyAsserter.getStrength(string: ""), .none)
      
      // Test minimal weak password at threshold
      let weakPasswordAtThreshold = String(repeating: "a", count: 4) + String(repeating: "1", count: 2) + "A" + "b"
      XCTAssertEqual(EntropyAsserter.getStrength(string: weakPasswordAtThreshold), .weak)
      
      // Test just below weak threshold
      let weakPasswordBelowThreshold = String(repeating: "a", count: 3) + String(repeating: "1", count: 1)
      XCTAssertEqual(EntropyAsserter.getStrength(string: weakPasswordBelowThreshold), .none)
      
      // Test minimal medium password at threshold
      let mediumPasswordAtThreshold = String(repeating: "a", count: 6) + String(repeating: "1", count: 6) + "AA" + "bb"
      XCTAssertEqual(EntropyAsserter.getStrength(string: mediumPasswordAtThreshold), .medium)
      
      // Test just below medium threshold
      let mediumPasswordBelowThreshold = String(repeating: "a", count: 5) + String(repeating: "1", count: 5) + "A" + "b"
      XCTAssertEqual(EntropyAsserter.getStrength(string: mediumPasswordBelowThreshold), .weak)
      
      // Test minimal strong password at threshold
      let strongPasswordAtThreshold = String(repeating: "a", count: 16) + String(repeating: "1", count: 8) + String(repeating: "A", count: 4) + String(repeating: "b", count: 4)
      XCTAssertEqual(EntropyAsserter.getStrength(string: strongPasswordAtThreshold), .strong)
      
      // Test just below strong threshold
      let strongPasswordBelowThreshold = String(repeating: "a", count: 15) + String(repeating: "1", count: 7) + String(repeating: "A", count: 3) + String(repeating: "b", count: 3)
      XCTAssertEqual(EntropyAsserter.getStrength(string: strongPasswordBelowThreshold), .medium)
      
      // Test password with special characters (special characters are now counted towards thresholds)
//      let passwordWithSpecialChars = String(repeating: "a", count: 10) + String(repeating: "1", count: 5) + "!@#$%"
//      XCTAssertEqual(EntropyAsserter.getStrength(string: passwordWithSpecialChars), .strong)
      
      // Test password with only letters
//      let lettersOnlyPassword = String(repeating: "a", count: 20)
//      XCTAssertEqual(EntropyAsserter.getStrength(string: lettersOnlyPassword), .weak)
      
      // Test password with only numbers
//      let numbersOnlyPassword = String(repeating: "1", count: 20)
//      XCTAssertEqual(EntropyAsserter.getStrength(string: numbersOnlyPassword), .weak)
      
      // Test password with mixed uppercase and lowercase letters
//      let mixedCasePassword = String(repeating: "A", count: 10) + String(repeating: "b", count: 10)
//      XCTAssertEqual(EntropyAsserter.getStrength(string: mixedCasePassword), .medium)
      
      // Test password with Unicode characters
//      let unicodePassword = "密码12345ABCDEabcde"
//      XCTAssertEqual(EntropyAsserter.getStrength(string: unicodePassword), .strong)
      // Generate random passwords and test their strength
//      for _ in 0..<10 {
//         let randomLength = Int.random(in: 1...50)
//         let randomPassword = try EntropyGenerator.randomNonceString(length: randomLength)
//         let strength = EntropyAsserter.getStrength(string: randomPassword)
//         // Assert that random passwords of sufficient length are at least weak
//         if randomLength >= 6 {
//            XCTAssertNotEqual(strength, .none)
//         } else {
//            XCTAssertEqual(strength, .none)
//         }
//      }
      
      // Edge case: Very long password
      let veryLongPassword = String(repeating: "abcdABCD1234", count: 100)
      XCTAssertEqual(EntropyAsserter.getStrength(string: veryLongPassword), .strong)
   }
}
