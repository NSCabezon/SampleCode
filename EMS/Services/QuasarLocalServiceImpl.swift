import Foundation

class QuasarLocalServiceImpl: QuasarLocalService {
    private let historicData: HistoricData
    private let liveData: LiveData

    init() {
        self.historicData = Mocks.loadJSON(withName: historicName)
        self.liveData = Mocks.loadJSON(withName: liveName)
    }

    func getHistoric(completion: @escaping (HistoricResult) -> Void) {
        completion(.success(historicData))
    }

    func getLiveData(completion: @escaping (LiveResult) -> Void) {
        completion(.success(liveData))
    }
}
