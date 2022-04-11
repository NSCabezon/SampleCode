import XCTest

class TestCase: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = UITestConstants.LaunchArguments.defaultLaunchArguments
    }
}
