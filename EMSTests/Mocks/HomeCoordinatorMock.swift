import UIKit

@testable import EMS

class HomeCoordinatorMock: HomeCoordinatorProtocol {
    var parentNavigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    
    init(parentNavigationController: UINavigationController) {
        self.parentNavigationController = parentNavigationController
    }
    
    var startCalled = false
    func start() {
        startCalled = true
    }
    
    var openDetailCalled = false
    func openDetail() {
        openDetailCalled = true
    }
}

extension HomeCoordinatorMock: MockResetProtocol {
    func reset() {
        startCalled = false
        openDetailCalled = false
    }
}
