import UIKit

class NavigationViewControllerMock: UINavigationController {
    var pushViewControllerCalled = false
	override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCalled = true
    }
}

// MARK: - Reset
extension NavigationViewControllerMock: MockResetProtocol {
    func reset() {
        pushViewControllerCalled = false
    }
}
