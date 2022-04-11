import UIKit

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var parentNavigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.parentNavigationController = navigationController
    }

    func start() {
        goToHome()
    }

    func goToHome() {
        let coordinator = HomeCoordinator(navigationController: parentNavigationController)
        coordinator.parentCoordinator = self
        children.append(coordinator)
        coordinator.start()
    }
}
