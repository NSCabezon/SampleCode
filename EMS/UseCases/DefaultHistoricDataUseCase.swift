import Foundation

struct DefaultHistoricDataUseCase {
    private let historicRepository: QuasarRepositoryProtocol

    init(historicRepository: QuasarRepositoryProtocol) {
        self.historicRepository = historicRepository
    }
}

extension DefaultHistoricDataUseCase: HistoricDataUseCase {
    func fetchHistoricData(completion: @escaping (Result<HomeHistoricData, Error>) -> Void) {
        historicRepository.getHistoric { historicResult in
            switch historicResult {
            case .success(let historicArray):
                var totalCharge: Double = 0
                var totalDischarge: Double = 0
                var gridTotal: Double = 0
                var pvTotal: Double = 0

                for item in historicArray {
                    // Cars are being charged with energy from the grid
                    if item.quasarsActivePower > 0 {
                        totalCharge += item.quasarsActivePower / 60
                    }
                    // it is discharging to the building to supply the building demand
                    else if item.quasarsActivePower < 0 {
                        totalDischarge += fabs(item.quasarsActivePower / 60)
                    }
                    gridTotal += item.gridActivePower
                    pvTotal += item.pvActivePower
                }

                let totalConsumed = gridTotal + pvTotal

                let pvPercentage = 100 * pvTotal / totalConsumed
                let gridPercentage = 100 - pvPercentage

                let homeData = HomeHistoricData(totalDischarged: totalDischarge,
                                                totalCharged: totalCharge,
                                                pvPercentage: pvPercentage,
                                                gridPercentage: gridPercentage)
                completion(.success(homeData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchHistoricDataRaw(completion: @escaping (Result<HistoricData, Error>) -> Void) {
        historicRepository.getHistoric { historicResult in
            switch historicResult {
            case .success(let historicArray):
                completion(.success(historicArray))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
