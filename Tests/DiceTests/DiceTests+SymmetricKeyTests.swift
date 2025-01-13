import XCTest
@testable import Dice

extension DiceTests {

   /**
    * Tests key generation with the default count (32 bytes).
    * Verifies that the key is not nil.
    * Checks that the decoded key data length is exactly 32 bytes.
    */
   func testComputeSymmetricKeyDefaultCount() {
      guard let keyString = computeSymmetricKey() else {
         XCTFail("Failed to generate symmetric key with default count")
         return
      }
      
      guard let keyData = Data(base64Encoded: keyString) else {
         XCTFail("Failed to decode base64 key string")
         return
      }
      
      XCTAssertEqual(keyData.count, 32, "Key data length should be 32 bytes")
   }
   
   /**
    * Tests key generation with a custom byte count (e.g., 64 bytes).
    * Verifies that the key is not nil.
    * Checks that the decoded key data length matches the custom count.
    */
   func testComputeSymmetricKeyCustomCount() {
      let customCount = 64
      guard let keyString = computeSymmetricKey(count: customCount) else {
         XCTFail("Failed to generate symmetric key with custom count")
         return
      }
      
      guard let keyData = Data(base64Encoded: keyString) else {
         XCTFail("Failed to decode base64 key string")
         return
      }
      
      XCTAssertEqual(keyData.count, customCount, "Key data length should be \(customCount) bytes")
   }
   
   /**
    * Tests behavior when the count is zero.
    * Expects the function to return nil.
    */
   func testComputeSymmetricKeyZeroCount() {
      let zeroCount = 0
      let keyString = computeSymmetricKey(count: zeroCount)
      XCTAssertNil(keyString, "Key should be nil when count is zero")
   }
   
   /**
    * Tests behavior with a negative count.
    * Expects the function to return nil.
    */
   func testComputeSymmetricKeyNegativeCount() {
      let negativeCount = -1
      let keyString = computeSymmetricKey(count: negativeCount)
      XCTAssertNil(keyString, "Key should be nil when count is negative")
   }
}
extension DiceTests {
    // Tests that the `generateSymmetricKey()` function returns a non-nil `SymmetricKey` object.
    func testGenerateSymmetricKeyReturnsKey() {
        let key = generateSymmetricKey()
        XCTAssertNotNil(key, "The generated key should not be nil.")
    }
    
    /// Verifies that the generated key is 256 bits (32 bytes) in size.
    func testGenerateSymmetricKeySize() {
        let key = generateSymmetricKey()
        let keyData = key.withUnsafeBytes { Data($0) }
        XCTAssertEqual(keyData.count, 32, "The key size should be 256 bits (32 bytes).")
    }
    
    /// Ensures that multiple calls produce unique keys.
    func testGenerateSymmetricKeyUniqueness() {
        let key1 = generateSymmetricKey()
        let key2 = generateSymmetricKey()
        let keyData1 = key1.withUnsafeBytes { Data($0) }
        let keyData2 = key2.withUnsafeBytes { Data($0) }
        XCTAssertNotEqual(keyData1, keyData2, "Consecutive keys should not be equal.")
    }
}