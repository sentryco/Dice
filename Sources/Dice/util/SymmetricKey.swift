import Foundation
import Security
import CryptoKit
/**
 * Generates a random symmetric key of specified byte length.
 *
 * - Description:
 *   This function generates a cryptographically secure random symmetric key using the system's default random number generator (`SecRandomCopyBytes`). The key data is of the specified byte length and is returned as a base64-encoded string. If the provided count is less than or equal to zero, the function returns `nil`.
 *
 * - Parameters:
 *   - count: The number of bytes for the symmetric key. Defaults to 32 bytes (256 bits).
 *
 * - Returns:
 *   A base64-encoded string of the generated symmetric key, or `nil` if the key could not be generated.
 *
 * - Example:
 *   ```swift
 *   if let key = computeSymmetricKey(count: 32) {
 *       print("Generated Key: \(key)")
 *   } else {
 *       print("Failed to generate key.")
 *   }
 *   ```
 */
public func computeSymmetricKey(count: Int = 32) -> String? {
    guard count > 0 else { return nil }
    var keyData = Data(count: count)
    let result = keyData.withUnsafeMutableBytes { buffer -> OSStatus in
        guard let baseAddress = buffer.baseAddress else {
            return errSecParam
        }
        return SecRandomCopyBytes(kSecRandomDefault, buffer.count, baseAddress)
    }
    return result == errSecSuccess ? keyData.base64EncodedString() : nil
}
// - Note: Security Considerations: SecRandomCopyBytes provides cryptographically secure random numbers suitable for key generation.

/**
 * Generates a random symmetric key of specified byte length.
 *
 * - Description:
 *   This function generates a cryptographically secure random symmetric key using `SecRandomCopyBytes`. The key data is of the specified byte length and is returned as a base64-encoded string. If the key generation fails, it returns `nil`.
 *
 * - Parameters:
 *   - byteCount: The number of bytes for the symmetric key.
 *
 * - Returns:
 *   A base64-encoded string of the generated symmetric key, or `nil` if the key could not be generated.
 *
 * - Example:
 *   ```swift
 *   if let key = generateRandomKey(byteCount: 32) {
 *       print("Generated Key: \(key)")
 *   } else {
 *       print("Failed to generate key.")
 *   }
 *   ```
 */
func generateRandomKey(byteCount: Int) -> String? {
    var randomBytes = [UInt8](repeating: 0, count: byteCount)
    let status = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
    
    if status == errSecSuccess {
        let data = Data(randomBytes)
        return data.base64EncodedString()
    } else {
        print("Error generating random bytes: \(status)")
        return nil
    }
}
// - Note: Recommended Practice: If you're targeting modern Apple platforms, consider using CryptoKit for cryptographic operations, as it offers a higher-level and more secure API.

/**
 * Generates a symmetric key using CryptoKit.
 *
 * - Description:
 *   This function generates a cryptographically secure symmetric key using CryptoKit's `SymmetricKey`. The key is of 256 bits.
 *
 * - Returns:
 *   A `SymmetricKey` object representing the generated symmetric key.
 *
 * - Example:
 *   ```swift
 *   let key = generateSymmetricKey()
 *   let keyData = key.withUnsafeBytes { Data(Array($0)) }
 *   print("Generated Key: \(keyData.base64EncodedString())")
 *   ```
 */
public func generateSymmetricKey() -> SymmetricKey {
    return SymmetricKey(size: .bits256)
}
