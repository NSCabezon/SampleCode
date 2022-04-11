import Foundation
import XCTest

class PageObject {
    let app: XCUIApplication

    init(application: XCUIApplication) {
        app = application
    }
    
    /// This should be overriden by subclasses and the visibility
    /// of a distinct element per page (Eg. A label, a textfield)
    func isVisible() -> Bool {
        return false
    }
    
    func distinctElement() -> XCUIElement {
        fatalError("Implemented by subclasses")
    }
}

extension PageObject {
    func waitToAppear(timeout: TimeInterval = 10) -> Bool {
        return distinctElement().waitForExistence(timeout: timeout)
    }
}
