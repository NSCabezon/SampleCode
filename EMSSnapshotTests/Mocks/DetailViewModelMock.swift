import UIKit
import Charts

@testable import EMS

final class DetailViewModelMock: DetailViewModelProtocol {
    var coordinator: HomeCoordinatorProtocol
    
    var didGetHistoricData: ((Bool) -> Void)?
    
    var lineChartDataSets: (LineChartDataSet, LineChartDataSet)? {
        return (LineChartDataSet(entries: [ChartDataEntry(x: 0.0, y: 10.0),
                                           ChartDataEntry(x: 1.0, y: 8.0),
                                           ChartDataEntry(x: 2.0, y: 4.0),
                                           ChartDataEntry(x: 3.0, y: 8.0)], label: "Grid"),
                LineChartDataSet(entries: [ChartDataEntry(x: 0.0, y: 2.0),
                                           ChartDataEntry(x: 1.0, y: 3.0),
                                           ChartDataEntry(x: 2.0, y: 13.0)], label: "Solar"))
    }
    
    init() {
        self.coordinator = HomeCoordinatorMock(parentNavigationController: UINavigationController())
    }
    
    func viewDidLoad() {
        didGetHistoricData?(true)
    }
    
    func string(for value: Double) -> String {
        return "0"
    }
}
