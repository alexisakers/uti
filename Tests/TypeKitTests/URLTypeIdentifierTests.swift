//
//  URLTypeIdentifierTests
//
//  This file is part of the uti project.
//  Copyright (c) 2018 - present Alexis Aubry and the uti authors.
//
//  Licensed under the terms of the MIT License.
//

import XCTest
@testable import TypeKit

/**
 * Tests the URL extensions.
 */

class URLTypeIdentifierTests: XCTestCase {

    // MARK: - Expanding

    func testThatItExpandsHomeDirectory() throws {
        // GIVEN
        let path = "~/Desktop"

        // WHEN
        let url = try URL(relativeFilePath: path)

        // THEN
        let expectedURL = Environment.homeDirectory!.appendingPathComponent("Desktop")
        XCTAssertEqual(url, expectedURL)
    }

    func testThatItExpandsCurrentDirectory() throws {
        // GIVEN
        let path = "."

        // WHEN
        let url = try URL(relativeFilePath: path)

        // THEN
        let expectedURL = Environment.currentDirectory
        XCTAssertEqual(url, expectedURL)
    }

    func testThatItExpandsParentDirectory() throws {
        // GIVEN
        let path = ".."

        // WHEN
        let url = try URL(relativeFilePath: path)

        // THEN
        let expectedURL = Environment.currentDirectory.deletingLastPathComponent()
        XCTAssertEqual(url, expectedURL)
    }

    func testThatItDoesntExpandInvalidPath()  {
        // GIVEN
        let path = "/System/Library/Frameworks/MagicKit.framework"

        // THEN
        XCTAssertThrowsError(try URL(relativeFilePath: path)) { error in
            guard case URLTypeError.fileNotFound(path) = error else {
                XCTFail("Expecting `URLTypeError.fileNotFound` with the right path.")
                return
            }
        }
    }

    // MARK: - UTI

    func testThatItDetectsUTIOfExistingItem() throws {
        // GIVEN
        let folder = URL(fileURLWithPath: "/System/Library/Frameworks/AppKit.framework")

        // WHEN
        let uti = try folder.fetchTypeIdentifier()

        // THEN
        XCTAssertEqual(uti, "com.apple.framework")
    }

    func testThatItFailsWhenItemDoesntExist() {
        // GIVEN
        let folder = URL(fileURLWithPath: "/System/Library/Frameworks/MagicKit.framework")

        // THEN
        XCTAssertThrowsError(try folder.fetchTypeIdentifier()) { error in
            guard case URLTypeError.resourcesUnavailable = error else {
                XCTFail("Expecting `URLTypeError.resourcesUnavailable`.")
                return
            }
        }
    }

}
