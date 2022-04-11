import UIKit

final class HomeCoordinator: Coordinator {
    var parentNavigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.parentNavigationController = navigationController
    }
}

extension HomeCoordinator: HomeCoordinatorProtocol {
    func start() {
        let service = QuasarLocalServiceImpl()
        let repository = QuasarRepository(quasarLocalService: service)
        let historicUseCase = DefaultHistoricDataUseCase(historicRepository: repository)
        let liveDataUseCase = DefaultLiveDataUseCase(liveDataRepository: repository)
        let viewModel = HomeViewModel(coordinator: self,
                                      historicUseCase: historicUseCase,
                                      liveDataUseCase: liveDataUseCase)
        let viewController = HomeViewController(viewModel: viewModel)
        parentNavigationController.viewControllers = [viewController]
    }

    func openDetail() {
        let service = QuasarLocalServiceImpl()
        let repository = QuasarRepository(quasarLocalService: service)
        let historicUseCase = DefaultHistoricDataUseCase(historicRepository: repository)
        let viewModel = DetailViewModel(coordinator: self,
                                        historicUseCase: historicUseCase)
        let viewController = DetailViewController(viewModel: viewModel)
        parentNavigationController.pushViewController(viewController, animated: true)
    }
}
