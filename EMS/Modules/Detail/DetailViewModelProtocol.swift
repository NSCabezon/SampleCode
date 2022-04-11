import Foundation
import Charts

protocol DetailViewModelProtocol {
    var coordinator: HomeCoordinatorProtocol { get }
    var didGetHistoricData: ((Bool) -> Void)? { get set }
    var lineChartDataSets: (LineChartDataSet, LineChartDataSet)? { get }

    func viewDidLoad()
    func string(for value: Double) -> String
}
