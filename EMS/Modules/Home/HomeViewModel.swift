import Foundation

final class HomeViewModel: HomeViewModelProtocol {
    enum HomeCell: CaseIterable {
        case discharge
        case charge
        case detail
    }

    let coordinator: HomeCoordinatorProtocol
    private var historicUseCase: HistoricDataUseCase
    private var liveDataUseCase: LiveDataUseCase
    private var historicData: HomeHistoricData?
    private var liveData: LiveData?

    var totalDischarged: String? {
        guard let totalDischarged = historicData?.totalDischarged else { return nil }
        return String(format: "%.2f kWh", totalDischarged)
    }
    var totalCharged: String? {
        guard let totalCharged = historicData?.totalCharged else { return nil }
        return String(format: "%.2f kWh", totalCharged)
    }
    var pvPercentage: String? {
        guard let pvPercentage = historicData?.pvPercentage else { return nil }
        return String(format: "☀️ Solar: %.2f%%", pvPercentage)
    }
    var gridPercentage: String? {
        guard let gridPercentage = historicData?.gridPercentage else { return nil }
        return String(format: "🔌 Grid: %.2f%%", gridPercentage)
    }

    var liveDataBuildingDemandText: String? {
        guard let totalCharged = liveData?.buildingDemand else { return nil }
        return String(format: "🏢 %.2f kWh", totalCharged)
    }
    var liveDataSolarText: String? {
        guard let totalCharged = liveData?.solarPower else { return nil }
        return String(format: "☀️ %.2f kWh", totalCharged)
    }
    var liveDataGridText: String? {
        guard let totalCharged = liveData?.gridPower else { return nil }
        return String(format: "🔌 %.2f kWh", totalCharged)
    }

    var didGetHistoricData: ((Bool) -> Void)?
    var didGetLiveData: ((Bool) -> Void)?

    init(coordinator: HomeCoordinatorProtocol,
         historicUseCase: HistoricDataUseCase,
         liveDataUseCase: LiveDataUseCase) {
        self.coordinator = coordinator
        self.historicUseCase = historicUseCase
        self.liveDataUseCase = liveDataUseCase
    }

    func viewDidLoad() {
        self.historicUseCase.fetchHistoricData { [weak self] result in
            switch result {
            case .success(let historicData):
                self?.historicData = historicData
                self?.didGetHistoricData?(true)
            case .failure:
                self?.didGetHistoricData?(false)
            }
        }
        self.liveDataUseCase.fetchLiveData { [weak self] result in
            switch result {
            case .success(let historicData):
                self?.liveData = historicData
                self?.didGetLiveData?(true)
            case .failure:
                self?.didGetLiveData?(false)
            }
        }
    }

    func openDetail() {
        coordinator.openDetail()
    }
}
