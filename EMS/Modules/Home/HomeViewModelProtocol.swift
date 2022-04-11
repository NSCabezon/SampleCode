import Foundation

protocol HomeViewModelProtocol {
    var coordinator: HomeCoordinatorProtocol { get }
    var didGetHistoricData: ((Bool) -> Void)? { get set }
    var didGetLiveData: ((Bool) -> Void)? { get set }

    var totalDischarged: String? { get }
    var totalCharged: String? { get }
    var pvPercentage: String? { get }
    var gridPercentage: String? { get }

    var liveDataBuildingDemandText: String? { get }
    var liveDataSolarText: String? { get }
    var liveDataGridText: String? { get }

    func viewDidLoad()
    func openDetail()
}
