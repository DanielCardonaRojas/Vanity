import XCTest
@testable import Vanity
/// Every apps defines their own theme spec

final class VanityTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let view = TestView(frame: .zero)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
