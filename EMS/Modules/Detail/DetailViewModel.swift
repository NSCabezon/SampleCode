import Foundation
import Charts
import UIKit

final class DetailViewModel: DetailViewModelProtocol {
    let coordinator: HomeCoordinatorProtocol
    var didGetHistoricData: ((Bool) -> Void)?
    var lineChartDataSets: (LineChartDataSet, LineChartDataSet)?

    private var historicUseCase: HistoricDataUseCase
    private var historicData: HistoricData?

    init(coordinator: HomeCoordinatorProtocol,
         historicUseCase: HistoricDataUseCase) {
        self.coordinator = coordinator
        self.historicUseCase = historicUseCase
    }

    func viewDidLoad() {
        historicUseCase.fetchHistoricDataRaw { [weak self] result in
            switch result {
            case .success(let historicData):
                self?.historicData = historicData

                var iterator = 0
                var solarEntries = [ChartDataEntry]()
                var gridEntries = [ChartDataEntry]()

                for item in historicData {
                    let solarEntry = ChartDataEntry(x: Double(iterator), y: item.pvActivePower)
                    solarEntries.append(solarEntry)
                    let gridEntry = ChartDataEntry(x: Double(iterator), y: item.gridActivePower)
                    gridEntries.append(gridEntry)
                    iterator += 1
                }

                let solarDataSet = LineChartDataSet(entries: solarEntries, label: "Solar")
                let gridDataSet = LineChartDataSet(entries: gridEntries, label: "Grid")

                self?.lineChartDataSets = (solarDataSet, gridDataSet)
                self?.didGetHistoricData?(true)
            case .failure:
                self?.didGetHistoricData?(false)
            }
        }
    }

    func string(for value: Double) -> String {
        guard let item = historicData?[Int(value)] else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let result = dateFormatter.string(from: item.timestamp)
        return result
    }
}
