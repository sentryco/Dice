#if os(iOS)
import UIKit
public typealias OSColor = UIColor // A way to reference os independent color (OSColor does not colide with Color that is used in CommonLib etc)
#elseif os(macOS)
import Cocoa
public typealias OSColor = NSColor
#endif
/**
 * Threshold
 */
extension EntropyAsserter.Entropy {
   /**
    * The minimum accepted threshold for a password to be considered weak, medium, or strong.
    * - Description: Threshold struct defines the minimum number of each character type required for a password.
    * - Note: This threshold is used to determine the minimum number of letter, numeric, uppercase,
    */
   public struct Threshold {
      /** 
       * The minimum number of letter characters required 
       */
      public let letter: Int
      /** 
       * The minimum number of numeric characters required 
       */
      public let num: Int
      /** 
       * The minimum number of uppercase characters required 
       */
      public let upper: Int
      /** 
       * The minimum number of lowercase characters required 
       */
      public let lower: Int
      /** 
       * The minimum number of special characters required 
       */
      public let special: Int
      /**
       * - Fixme: ⚠️️ add doc
       */
      internal static var strongThreshold: Threshold =  // Return the minimum threshold for a strong password
         .init(
            letter: 16, // The minimum number of letters required
            num: 8, // The minimum number of numbers required
            upper: 4, // The minimum number of uppercase letters required
            lower: 4, // The minimum number of lowercase letters required
            special: 0 // The minimum number of special characters required
         )
      /**
       * - Fixme: ⚠️️ add doc
       */
      internal static var mediumThreshold: Threshold = // Return the minimum threshold for a medium password
         .init(
            letter: 6, // The minimum number of letters required
            num: 6, // The minimum number of numbers required
            upper: 2, // The minimum number of uppercase letters required
            lower: 2, // The minimum number of lowercase letters required
            special: 0 // The minimum number of special characters required
         )
      /**
       * - Fixme: ⚠️️ add doc
       */
      internal static var weakThreshold: Threshold = // Return the minimum threshold for a weak or invalid password
         .init(
            letter: 4, // The minimum number of letters required
            num: 2, // The minimum number of numbers required
            upper: 1, // The minimum number of uppercase letters required
            lower: 1, // The minimum number of lowercase letters required
            special: 0 // The minimum number of special characters required
         )
   }
   /**
    * Returns strength-type that is above these defined "max-thresholds" etc
    * - Description: This property returns the minimum thresholds for each
    *                character type (letter, number, uppercase, lowercase,
    *                special) required for a password to be considered of a
    *                certain strength (strong, medium, weak, none). The
    *                thresholds are defined based on the entropy level of the
    *                password.
    * - Fixme: ⚠️️ Use better thresholds, do some research into which we shoul use etc
    */
   public var threshold: Threshold {
      switch self {
      case .strong: return  .strongThreshold
        
      case .medium: return  .mediumThreshold
         
      case .weak: return  .weakThreshold

      case .none: return Threshold(letter: 0, num: 0, upper: 0, lower: 0, special: 0)
         
      }
   }
   /**
    * The color used to display the security grade text.
    * - Description: This property represents the color associated with the
    *                password's security level. It is used to provide a visual
    *                indication of the password's strength to the user.
    * - Remark: This color is used to give the user a visual indication of the
    *           password's security level.
    */
   public var color: OSColor {
      switch self {
      case .strong: return .systemGreen // Return the system green color for a strong password
      case .medium: return .systemOrange // Return the system orange color for a medium password
      case .weak: return .systemRed // Return the system red color for a weak password
      case .none:  return .clear // Return the clear color for an invalid password
      }
   }
}
