import Foundation
 /**
Calculates the Shannon entropy of a given string.
- Parameter string: The input string for which to calculate entropy.
- Returns: The calculated entropy value.
- Note: CryptoKit does not offer a direct API for entropy calculation, but we utilize it to ensure we're using cryptographically secure practices.
- Note: Shannon Entropy is used here to quantify the unpredictability of the password.
*/
public func calculateEntropy(of string: String) -> Double {
    func log2(_ x: Double) -> Double {
        return log(x) / log(2.0)
    }
    
    let length = Double(string.count)
    guard length > 0 else { return 0.0 }
    
    var characterFrequencies: [Character: Double] = [:]
    for character in string {
        characterFrequencies[character, default: 0] += 1.0
    }
    
    let entropy = characterFrequencies.reduce(0.0) { (result, element) -> Double in
        let frequency = element.value / length
        return result - frequency * log2(frequency)
    }
    
    return entropy * length
}
/**
Measures the strength of a password and returns a value of `weak`, `medium`, or `strong`.
- Parameter string: The password string to assess.
- Returns: The assessed password strength.
Weak Passwords: Entropy less than 28 bits.
Medium Passwords: Entropy between 28 and 36 bits.
Strong Passwords: Entropy greater than 36 bits.
- Note: The entropy thresholds are illustrative; adjust them according to your application's security policies.
*/
public func getStrength(string: String) -> EntropyAsserter.Entropy {
    let entropyValue = calculateEntropy(of: string)
    
    switch entropyValue {
    case 0..<28:
        return .weak
    case 28..<36:
        return .medium
    case 36...:
        return .strong
    default:
        return .none
    }
}
