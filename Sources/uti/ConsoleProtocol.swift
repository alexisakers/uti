import Foundation

/**
 * An object that can output text to a buffer.
 */

protocol Console {

    /**
     * Logs an information / success text to the general-purpose buffer.
     * - parameter text: The text to log.
     */

    func log(_ text: String)

    /**
     * Logs an error text to the error-reporting buffer.
     * - parameter text: The error text to log.
     */

    func logError(_ text: String)
}

extension Console {

    /**
     * Logs an error object to the error-reporting buffer.
     *
     * If the object is a `LocalizedError` that has a localized description, we show this value.
     * Otherwise, we log "Unknown error".
     * - parameter error: The error to log.
     */

    func logError(_ error: Error) {
        let message = ((error as? LocalizedError)?.errorDescription) ?? "Unknown error."
        logError("💥  " + message)
    }

}

// MARK: - Terminal

/**
 * A console that prints to the system output / error file handles.
 */

class Terminal: Console {

    private let stdout = FileHandle.standardOutput
    private let stderr = FileHandle.standardError

    func log(_ text: String) {
        stdout.logLine(text)
    }

    func logError(_ text: String) {
        stderr.logLine(text)
    }

}

extension FileHandle {

    /// Logs a block of text to the handle and appends a newline at the end.
    func logLine(_ line: String) {
        let output = line + "\n"
        let outputBuffer = Data(output.utf8)
        write(outputBuffer)
    }

}
