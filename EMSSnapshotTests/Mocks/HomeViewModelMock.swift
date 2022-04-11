import UIKit

@testable import EMS

final class HomeViewModelMock: HomeViewModelProtocol {
    var coordinator: HomeCoordinatorProtocol
    
    var didGetHistoricData: ((Bool) -> Void)?
    var didGetLiveData: ((Bool) -> Void)?
    
    var totalDischarged: String? = "102.12 kWh"
    var totalCharged: String? = "84.32 kWh"
    var pvPercentage: String? = "35%"
    var gridPercentage: String? = "65%"

    var liveDataBuildingDemandText: String? = "Building"
    var liveDataSolarText: String? = "Solar"
    var liveDataGridText: String? = "Live data"
    
    init() {
        self.coordinator = HomeCoordinatorMock(parentNavigationController: UINavigationController())
    }
    
    func viewDidLoad() {
        didGetHistoricData?(true)
        didGetLiveData?(true)
    }
    
    func openDetail() {
        
    }
}
