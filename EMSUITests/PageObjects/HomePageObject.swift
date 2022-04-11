import XCTest

class HomePageObject: PageObject {
    private let dischargeLabel: XCUIElement
    private let detailWidgetButton: XCUIElement
    
    override init(application: XCUIApplication) {
        dischargeLabel = application.staticTexts[AccessibilityIdentifiers.HomeViewController.DischargeLabel]
        detailWidgetButton = application.buttons[AccessibilityIdentifiers.HomeViewController.DetailWidgetButton]
        super.init(application: application)
    }
    
    override func isVisible() -> Bool {
        return dischargeLabel.exists
    }

    func tapOnDetailWidget() {
        detailWidgetButton.tap()
    }

    private func cell(at index: Int) -> XCUIElement {
        return dischargeLabel.cells.element(boundBy: index)
    }
    
    override func distinctElement() -> XCUIElement {
        return dischargeLabel
    }
}
