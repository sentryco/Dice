[![Tests](https://github.com/sentryco/Dice/actions/workflows/Tests.yml/badge.svg)](https://github.com/sentryco/Dice/actions/workflows/Tests.yml)
[![codebeat badge](https://codebeat.co/badges/1f72598b-1883-4211-9f5c-38acdde6f6cd)](https://codebeat.co/projects/github-com-sentryco-dice-main)

# Dice 🎲

> Random string generator

### Description
Dice is a Swift library for generating cryptographically secure random passwords and symmetric keys. It utilizes a nonce-based approach, leveraging entropy derived from kinetic inputs and other sources to enhance security. The library provides tools for password generation, entropy testing, and supports word-based passphrases following the Diceware methodology.

# Problem

Modern applications require robust security measures to protect sensitive data and user information. There are three core challenges in this context:

1. **Generating Cryptographically Secure Passwords**: Creating complex, unpredictable passwords that can withstand brute-force and dictionary attacks.

2. **Producing Strong Symmetric Keys**: Generating truly random keys for encryption purposes to ensure data confidentiality.

3. **Creating Memorable Yet Secure Passphrases**: Balancing security and usability by providing passphrases that are easy to remember but hard to crack.

# Solution

**Dice** addresses these challenges with the following solutions:

1. **Secure Random Password Generation**: Utilizes a nonce-based approach combined with cryptographically secure random number generators to produce complex and unique passwords.

2. **Symmetric Key Generation**: Provides functionality to create strong symmetric keys using `SecRandomCopyBytes`, ensuring keys are random and suitable for encryption tasks.

3. **Word-Based Passphrase Generation**: Implements the Diceware methodology to generate passphrases from a seed word list, resulting in memorable yet secure passphrases for users.


### Features

- 🎲 **Secure Random Password Generation**: Generates random passwords using a nonce-based approach for enhanced security.

- 🔑 **Symmetric Key Generation**: Creates random symmetric keys using `SecRandomCopyBytes` for encryption purposes..

- 📚 **Word-Based Passphrase Generation**: Supports generating passphrases using a seed word list, following the Diceware method.

- 📊 **Entropy Testing**: Includes tools and pseudo-code for testing the entropy and randomness of the password generation mechanism.

- 🧪 **Comprehensive Unit Tests**: Provides extensive unit tests covering various scenarios, edge cases, and entropy validation.

### Example
```swift
// Example: Generating a random password with a custom recipe
import Dice

let recipe = RandPSW.PasswordRecipe(charCount: 8, numCount: 4, symCount: 2)
if let password = try? RandPSW.makeRandomPassword(recipe: recipe) {
    Swift.print("Generated Password: \(password)")
} else {
    Swift.print("Error generating password.")
}

// Example: Generating a word-based passphrase
if let wordPassword = try? RandPSW.makeRandomWords(length: 6, seperator: "-") {
    Swift.print("Generated Word Passphrase: \(wordPassword)")
} else {
    Swift.print("Error generating word-based passphrase.")
}

// Example: Generating a symmetric key
if let secretKey = computeSymmetricKey() {
    Swift.print("Generated Symmetric Key: \(secretKey)")
} else {
    Swift.print("Error generating symmetric key.")
}

// Example: Checking the strength of a password (using shannon entropy)
import Dice

let password = "My$up3r$trongP@ssw0rd!"
let strength = getStrength(string: password)
Swift.print("Password Strength: \(strength)")

```


#### Swift Package Manager


To add Dice to your project, include it in the `dependencies` section of your `Package.swift` file:
```
dependencies: [
    .package(url: "https://github.com/sentryco/Dice", branch: "main")
],
```
### Resources

- **Apple's Password Rules**: Research `UITextInputPasswordRules` for password validation and generation. [Learn more](https://nshipster.com/uitextinputpasswordrules/)

- **Security Best Practices**: Understanding common security mistakes in Swift applications. [Checkmarx Blog](https://checkmarx.com/de/blog/security-mistakes-developing-swift-applications-test/)


- **Apple's Password-Related APIs:**

  - [Password AutoFill Programming Guide](https://developer.apple.com/documentation/security/password_autofill_programming_guide)

  - [Certificate, Key, and Trust Services](https://developer.apple.com/documentation/security/certificate_key_and_trust_services)


- **Security Best Practices:**

  - [OWASP Password Storage Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html)

  - [Apple's Security Framework](https://developer.apple.com/documentation/security)

> **Note:** Diceware generates cryptographically strong passphrases by randomly selecting words from a wordlist. This results in memorable passwords that are highly resistant to attacks.

### Todo
- Make more tests ✅
- Consider using apples password generator `UITextInputPasswordRules` for generating passwords
- Consider creating a warning system for weak passwords audit (healthCheck) based on apples `UITextInputPasswordRules`
- Improve Dice API 1 https://github.com/mssun/passforios/blob/master/passKit/Passwords/PasswordGenerator.swift
- Improve Dice API 2 https://github.com/keepassium/KeePassium/blob/master/KeePassiumLib/KeePassiumLib/util/PasswordGenerator.swift
- Improve Dice API 3 https://gist.github.com/brennanMKE/7b740c57cabfe16f337464f504fcb100
- Improve Dice API 4 (This has a nice reduce ) https://mgrebenets.github.io/swift/2015/02/23/password-generator-in-swift
- Make entropy test to verify good distribution ✅
- Password generator with crypto secure SecRandomCopyBytes: https://github.com/RolfKr/Days/blob/6a556a83a87cd27526ef2b56fb93bf0bcd3ac302/Days/Supporting%20Files/Helper.swift
- https://checkmarx.com/de/blog/security-mistakes-developing-swift-applications-test/
- Remove the resoure files. or move to mockgen lib?

 