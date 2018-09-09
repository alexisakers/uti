@testable import TypeKit

/**
 * An object that intercepts output.
 */

class MockConsole: Console {

    /// The list of texts that were written to the output buffer.
    private(set) var standardText: [String] = []

    /// The list of texts that were written to the error buffer.
    private(set) var errors: [String] = []

    func log(_ text: String) {
        standardText.append(text)
    }

    func logError(_ text: String) {
        errors.append(text)
    }

}
