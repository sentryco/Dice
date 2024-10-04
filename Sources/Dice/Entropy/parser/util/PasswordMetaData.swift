import Foundation
/**
 * A structure containing the analysis of a password.
 * - Description: This struct is used to store and analyze the metadata of a password. It includes the count of various types of characters such as letters, numbers, special characters, and also the count of lowercase and uppercase letters.
 * - Fixme: ⚠️️ Move to own file?
 * - Remark: This struct provides information on the number of letters, numbers, and special characters in the input password, as well as the number of lowercase and uppercase letters.
 * - Remark: This is a struct, because tuples are more suitable for simpler stuff.
 */
public struct PasswordMetaData {
   // - Fixme: ⚠️️ maybe add vertical space to this struct,
   // - Fixme: ⚠️️ maybe move it to its own file?
   public let letterCharCount: Int, // The number of letter characters in the password
              numberCharCount: Int, // The number of number characters in the password
              specialCharCount: Int, // The number of special characters in the password
              lowerCaseCharCount: Int, // The number of lowercase characters in the password
              upperCaseCharCount: Int // The number of uppercase characters in the password
}
