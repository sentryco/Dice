[![Tests](https://github.com/sentryco/Dice/actions/workflows/Tests.yml/badge.svg)](https://github.com/sentryco/Dice/actions/workflows/Tests.yml)
[![codebeat badge](https://codebeat.co/badges/1f72598b-1883-4211-9f5c-38acdde6f6cd)](https://codebeat.co/projects/github-com-sentryco-dice-main)

# Dice 🎲

> Random string generator

### Description
Utilizes a Nonce-based approach, leveraging entropy derived from kinetic inputs and other sources to enhance security.

### Features
- **Secure Random Password Generation**: Utilizes a Nonce-based approach for enhanced security.
- **Symmetric Key Generation**: Generates a random symmetric key using `SecRandomCopyBytes`. 
- **Entropy Testing**: Provides a pseudo code for testing the entropy of the password generation mechanism.  

### Example
```swift
let recipe: RandomPassword.PasswordRecipe = (4,0, Int.random(in: 2...8)) // Define a password recipe with 4 words and a separator, and a random word length between 2 and 8
let psw = try? RandomPassword.randomPassword(recipe: recipe) // Generate a random password using the given recipe, and assign it to `psw`
Swift.print("psw:  \(String(describing: psw))")
```
### Resources
- Apple has a built in validator and generator: Research `UITextInputPasswordRules` https://nshipster.com/uitextinputpasswordrules/

### Gotcha:
- Diceware is a method used to generate cryptographically strong passphrases. It is based on the principle that truly random selection of words from a wordlist can result in easily memorable passwords that are also extremely resistant to attack.

### Todo
- Make more tests
- Consider using apples password generator `UITextInputPasswordRules` for generating passwords
- Consider creating a warning system for weak passwords audit (healthCheck) based on apples `UITextInputPasswordRules`
- Improve Dice API 1 https://github.com/mssun/passforios/blob/master/passKit/Passwords/PasswordGenerator.swift
- Improve Dice API 2 https://github.com/keepassium/KeePassium/blob/master/KeePassiumLib/KeePassiumLib/util/PasswordGenerator.swift
- Improve Dice API 3 https://gist.github.com/brennanMKE/7b740c57cabfe16f337464f504fcb100
- Improve Dice API 4 (This has a nice reduce ) https://mgrebenets.github.io/swift/2015/02/23/password-generator-in-swift
- Make entropy test to verify good distribution
- Password generator with crypto secure SecRandomCopyBytes: https://github.com/RolfKr/Days/blob/6a556a83a87cd27526ef2b56fb93bf0bcd3ac302/Days/Supporting%20Files/Helper.swift
- https://checkmarx.com/de/blog/security-mistakes-developing-swift-applications-test/
- Remove the resoure files. or move to mockgen lib?

### Pseudo code for entropy test:
```swift
For the SecRandom password generator code.
Just hit the method enough times and check occurrence rate of similar characters etc.
Passwords = 1000*1000
Occurences = [:]
CharSet.forEach{
   Occurences[$0] +=Passwords.occurenceOf($0)
}
```

### Symetric key:
Generates a random symmetric key that can be used for encryption

```swift
import Foundation
import Security

func computeSymmetricKey() -> String? {
    // Create a new `Data` object with 32 bytes (256 bits) of count
    var keyData = Data(count: 32)
    // Generate random bytes using `SecRandomCopyBytes` and store them in `keyData`
    let result = keyData.withUnsafeMutableBytes {
        (mutableBytes: UnsafeMutablePointer) -> Int32 in
        SecRandomCopyBytes(kSecRandomDefault, keyData.count, mutableBytes)
    }
    // If the result is successful, return the base64-encoded string of `keyData`
    if result == errSecSuccess {
        return keyData.base64EncodedString()
    // If the result is not successful, return `nil`
    } else {
        return nil
    }
}
let secretKey = computeSymmetricKey()
```

## Swift package manager:

```swift
.package(url: "https://github.com/sentryco/Dice", branch: "main")
```

## Todo:
- Expand the unit tests to cover more scenarios, especially focusing on the entropy and security aspects of the password generation. This could include more rigorous testing of edge cases and failure modes.
- There is a pseudo code for entropy testing in the readme.md, but it appears that actual implementation might be missing or incomplete. Implement a robust entropy testing mechanism to ensure the randomness and security of the generated passwords, as outlined in the pseudo code
- Given the nature of the project (password generation), security is paramount. Conduct regular security audits and update the entropy generation methods based on the latest cryptographic research and standards.
