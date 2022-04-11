import XCTest

class DetailPageObject: PageObject {
    private let chartView: XCUIElement

    override init(application: XCUIApplication) {
        chartView = application.otherElements[AccessibilityIdentifiers.DetailViewController.Chart]
        super.init(application: application)
    }

    override func isVisible() -> Bool {
        return chartView.exists
    }

    override func distinctElement() -> XCUIElement {
        return chartView
    }
}
