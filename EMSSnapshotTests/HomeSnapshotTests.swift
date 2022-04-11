import XCTest
import SnapshotTesting

@testable import EMS

class HomeSnapshotTests: XCTestCase {
    var sut: HomeViewController!

    func testHomeViewController() {
        let viewModelMock = HomeViewModelMock()
        sut = HomeViewController(viewModel: viewModelMock)
        let navController = UINavigationController(rootViewController: sut)

        navController.topViewController?.loadViewProgrammatically()

        assertSnapshot(matching: navController, as: .image)
    }
}
