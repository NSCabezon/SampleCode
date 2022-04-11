import XCTest

@testable import EMS

class HomeCoordinatorTests: XCTestCase {
    var sut: HomeCoordinator!
    let parentNavigationController = NavigationViewControllerMock()
    let window = UIWindow(frame: UIScreen.main.bounds)
    
    override func setUp() {
        window.rootViewController = parentNavigationController
        window.makeKeyAndVisible()
    }
    
    func testStart() {
        // Arrange
        sut = HomeCoordinator(navigationController: parentNavigationController)

        // Act
        sut.start()

        // Assert
        XCTAssert(parentNavigationController.viewControllers.count == 1)
        XCTAssert(parentNavigationController.topViewController is HomeViewController)
    }
    
    func testOpenDetail() {
        // Arrange
        sut = HomeCoordinator(navigationController: parentNavigationController)

        // Act
        sut.start()
        sut.openDetail()

        // Assert
        XCTAssert(parentNavigationController.pushViewControllerCalled)
        XCTAssertNotNil(sut.parentNavigationController)
    }
}
