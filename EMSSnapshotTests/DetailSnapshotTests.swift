import XCTest
import SnapshotTesting

@testable import EMS

class DetailSnapshotTests: XCTestCase {
    var sut: DetailViewController!

    func testDetailViewController() {
        let viewModelMock = DetailViewModelMock()
        sut = DetailViewController(viewModel: viewModelMock)
        let navController = UINavigationController(rootViewController: sut)

        navController.topViewController?.loadViewProgrammatically()
        navController.topViewController?.viewDidLoad()
        sleep(10)
        assertSnapshot(matching: navController, as: .image)
    }
}
