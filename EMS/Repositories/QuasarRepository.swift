import Foundation

final class QuasarRepository: QuasarRepositoryProtocol {
    private let quasarLocalService: QuasarLocalService

    init(quasarLocalService: QuasarLocalService) {
        self.quasarLocalService = quasarLocalService
    }

    func getHistoric(completion: @escaping (HistoricResult) -> Void) {
        quasarLocalService.getHistoric(completion: completion)
    }

    func getLiveData(completion: @escaping (LiveResult) -> Void) {
        quasarLocalService.getLiveData(completion: completion)
    }
}
