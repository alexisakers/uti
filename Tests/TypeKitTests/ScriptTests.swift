//
//  ScriptTests
//
//  This file is part of the uti project.
//  Copyright (c) 2018 - present Alexis Aubry and the uti authors.
//
//  Licensed under the terms of the MIT License.
//

import XCTest
@testable import TypeKit

/**
 * Tests the script.
 */

class ScriptTests: XCTestCase {

    /// The object that contains the output text of the script.
    var console: MockConsole!

    override func setUp() {
        super.setUp()
        console = MockConsole()
    }

    override func tearDown() {
        console = nil
        super.tearDown()
    }

    // MARK: - Success Commands

    func testThatItOutputsUTI() {
        // GIVEN
        let arguments = ["/usr/local/bin/uti", "get", "~/Desktop"]

        // WHEN
        Script.main(arguments: arguments, console: console)

        // THEN
        XCTAssertTrue(console.errors.isEmpty)
        XCTAssertEqual(console.standardText, ["public.folder"])
    }

    func testThatItChecksPositiveConformance() {
        // GIVEN
        let arguments = ["/usr/local/bin/uti", "conforms", "com.apple.bundle", "/System/Library/Frameworks/AppKit.framework"]

        // WHEN
        Script.main(arguments: arguments, console: console)

        // THEN
        XCTAssertTrue(console.errors.isEmpty)
        XCTAssertEqual(console.standardText, ["YES"])
    }

    func testThatItChecksNegativeConformance() {
        // GIVEN
        let arguments = ["/usr/local/bin/uti", "conforms", "public.audio", "/System/Library/Frameworks/AppKit.framework"]

        // WHEN
        Script.main(arguments: arguments, console: console)

        // THEN
        XCTAssertTrue(console.errors.isEmpty)
        XCTAssertEqual(console.standardText, ["NO"])
    }

    func testThatItShowsHelp() {
        // GIVEN
        let arguments = ["/usr/local/bin/uti", "help"]

        // WHEN
        Script.main(arguments: arguments, console: console)

        // THEN
        XCTAssertTrue(console.errors.isEmpty)
        XCTAssertEqual(console.standardText.count, 1)

        guard let text = console.standardText.first else {
            XCTFail("Expecting one standard output.")
            return
        }

        XCTAssertTrue(text.components(separatedBy: "\n").count > 1)
    }

}
