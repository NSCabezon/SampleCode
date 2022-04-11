import Foundation

typealias HistoricResult = Result<HistoricData, Error>
typealias LiveResult = Result<LiveData, Error>

// sourcery: AutoMockable
protocol QuasarRepositoryProtocol {
    func getHistoric(completion: @escaping (HistoricResult) -> Void)
    func getLiveData(completion: @escaping (LiveResult) -> Void)
}
