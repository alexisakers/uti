import Foundation

/**
 * The result of an operation (either success or failure).
 */

enum Result<T> {

    /// The operation failed and returned an error.
    case error(Error)

    /// The operation succeeded and returned the expected side effect.
    case success(T)

}
