import XCTest
@testable import TypeKit

/// Checks that a result value contains a success.
func XCTAssertSuccess<T: Equatable>(_ result: Result<T>, _ expectedValue: T, file: StaticString = #file, line: UInt = #line) {
    guard case let .success(value) = result else {
        XCTFail("The operation returned a failure (\(result))", file: file, line: line)
        return
    }

    XCTAssertEqual(value, expectedValue)
}

/// Checks that a result value contains a failure.
func XCTAssertFailure<T, E: Error & Equatable>(_ result: Result<T>, _ expectedError: E, file: StaticString = #file, line: UInt = #line) {
    guard case let .error(errorBox) = result else {
        XCTFail("The operation returned a failure", file: file, line: line)
        return
    }

    guard let error = errorBox as? E else {
        XCTFail("The error is not of the correct type (\(errorBox))", file: file, line: line)
        return
    }

    XCTAssertEqual(error, expectedError)
}
