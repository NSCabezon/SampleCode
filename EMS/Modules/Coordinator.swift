import UIKit

protocol Coordinator: AnyObject {
    var parentNavigationController: UINavigationController { get set }
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }

    func start()
}
