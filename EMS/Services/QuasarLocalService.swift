import Foundation

// sourcery: AutoMockable
protocol QuasarLocalService {
    func getHistoric(completion: @escaping (HistoricResult) -> Void)
    func getLiveData(completion: @escaping (LiveResult) -> Void)
}
