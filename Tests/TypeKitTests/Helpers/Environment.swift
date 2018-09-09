//
//  Environment
//
//  This file is part of the uti project.
//  Copyright (c) 2018 - present Alexis Aubry and the uti authors.
//
//  Licensed under the terms of the MIT License.
//

import Foundation

/**
 * Provides access to the environment variables.
 */

enum Environment {

    /**
     * Returns the value of the environment variable with the specified key.
     * - parameter key: The key representing the environment variable name.
     * - returns: The value of the variable, if it was found.
     */

    static func variable(forKey key: String) -> String? {
        guard let rawValue = getenv(key) else {
            return nil
        }

        return String(cString: rawValue)
    }

    // MARK: - Helpers

    /// The URL to the home directory.
    static var homeDirectory: URL? {
        return variable(forKey: "HOME").map(URL.init(fileURLWithPath:))
    }

    /// The current directory.
    static var currentDirectory: URL {
        return URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    }

    /// The temporary directory.
    static var temporaryDirectory: URL {
        return URL(fileURLWithPath: NSTemporaryDirectory())
    }

}
