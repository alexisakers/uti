//
//  ConsoleProtocol
//
//  This file is part of the uti project.
//  Copyright (c) 2018 - present Alexis Aubry and the uti authors.
//
//  Licensed under the terms of the MIT License.
//

import Foundation

/**
 * An object that can output text to a buffer.
 */

public protocol Console {

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

    public func logError(_ error: Error) {
        let message = ((error as? LocalizedError)?.errorDescription) ?? "Unknown error."
        logError("💥  " + message)
    }

}

// MARK: - Terminal

/**
 * A console that prints to the system output / error file handles.
 */

public class Terminal: Console {

    private let stdout = FileHandle.standardOutput
    private let stderr = FileHandle.standardError

    /// Creates a new wrapper around terminal file handles.
    public init() {
        // no-op
    }

    public func log(_ text: String) {
        stdout.logLine(text)
    }

    public func logError(_ text: String) {
        stderr.logLine(text)
    }

}

extension FileHandle {

    /// Logs a block of text to the handle and appends a newline at the end.
    fileprivate func logLine(_ line: String) {
        let output = line + "\n"
        let outputBuffer = Data(output.utf8)
        write(outputBuffer)
    }

}
