import Foundation
/**
 * Measures the strength of a password and returns a value of `weak`, `medium`, or `strong`.
 * - Abstract: The strength is determined by analyzing the password's entropy, length, and complexity.
 * - Description: The `EntropyAsserter` class is responsible for assessing the strength of a password. It does this by analyzing the password's entropy, length, and complexity. The result is a value of `weak`, `medium`, or `strong`, which represents the password's strength.
 * - Fixme: ⚠️️ Apple also has an entropy API that could be used to improve the password strength measurement.
 * - Fixme: ⚠️️ Consider incorporating this apple based entropy API in future updates.
 */
public final class EntropyAsserter {}
