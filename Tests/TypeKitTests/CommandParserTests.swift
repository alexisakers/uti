import XCTest
@testable import TypeKit

/**
 * Tests the command argument parser.
 */

class CommandParserTests: XCTestCase {

    // MARK: - Success

    func testThatItParsesValidGetCommand() {
        // GIVEN
        let arguments = ["/usr/local/bin/uti", "get", "/bin/sh"]

        // WHEN
        let command = arguments.parseCommand()

        // THEN
        let expectedFileURL = URL(fileURLWithPath: "/bin/sh")
        XCTAssertSuccess(command, .getUTI(expectedFileURL))
    }

    func testThatItParsesValidConformsCommand() {
        // GIVEN
        let arguments = ["/usr/local/bin/uti", "conforms", "public.folder", "/bin/sh"]

        // WHEN
        let command = arguments.parseCommand()

        // THEN
        let expectedFileURL = URL(fileURLWithPath: "/bin/sh")
        XCTAssertSuccess(command, .checkConformance("public.folder", expectedFileURL))
    }

    func testThatItParsesValidHelpCommand() {
        // GIVEN
        let arguments = ["/usr/local/bin/uti", "help"]

        // WHEN
        let command = arguments.parseCommand()

        // THEN
        XCTAssertSuccess(command, .printHelp)
    }

    func testThatItParsesHelpCommandWithExtraParameters() {
        // GIVEN
        let arguments = ["/usr/local/bin/uti", "help", "conforms"]

        // WHEN
        let command = arguments.parseCommand()

        // THEN
        XCTAssertSuccess(command, .printHelp)
    }

    // MARK: - Failures

    func testThatItReturnsMissingCommandNameError() {
        // GIVEN
        let arguments = ["/usr/local/bin/uti"]

        // WHEN
        let command = arguments.parseCommand()

        // THEN
        XCTAssertFailure(command, CommandParserError.missingCommandName)
    }

    func testThatItReturnsInvalidUsageErrorForMissingGetFile() {
        // GIVEN
        let arguments = ["/usr/local/bin/uti", "get"]

        // WHEN
        let command = arguments.parseCommand()

        // THEN
        XCTAssertFailure(command, CommandParserError.invalidUsage(.getUTI))
    }

    func testThatItReturnsInvalidUsageErrorForMissingConformanceFile() {
        // GIVEN
        let arguments = ["/usr/local/bin/uti", "conforms", "public.folder"]

        // WHEN
        let command = arguments.parseCommand()

        // THEN
        XCTAssertFailure(command, CommandParserError.invalidUsage(.checkConformance))
    }

    func testThatItReturnsUnknownCommandError() {
        // GIVEN
        let arguments = ["/usr/local/bin/uti", "make-coffee"]

        // WHEN
        let command = arguments.parseCommand()

        // THEN
        XCTAssertFailure(command, CommandParserError.unknownCommand("make-coffee"))
    }

}
