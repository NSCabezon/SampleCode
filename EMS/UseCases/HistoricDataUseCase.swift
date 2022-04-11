import Foundation

protocol HistoricDataUseCase {
    func fetchHistoricData(completion: @escaping (Result<HomeHistoricData, Error>) -> Void)
    func fetchHistoricDataRaw(completion: @escaping (Result<HistoricData, Error>) -> Void)
}
