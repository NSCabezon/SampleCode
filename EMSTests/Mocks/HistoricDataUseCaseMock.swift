import Foundation

@testable import EMS

class HistoricDataUseCaseMock: HistoricDataUseCase {
    
    var fetchHistoricDataRawOkResult: Result<HistoricData, Error> = .success(HistoricData.mock())
    var fetchHistoricDataRawKoResult: Result<HistoricData, Error> = .failure(ErrorMock.someRandomCase)
    
    var fetchHistoricDataRawCalled = false
    var fetchHistoricDataRawShouldReturnOk = true
    func fetchHistoricDataRaw(completion: @escaping (Result<HistoricData, Error>) -> Void) {
        fetchHistoricDataRawCalled = true
        if fetchHistoricDataRawShouldReturnOk {
            completion(fetchHistoricDataRawOkResult)
        } else {
            completion(fetchHistoricDataRawKoResult)
        }
    }
    
    
    
    var fetchHistoricDataOkResult: Result<HomeHistoricData, Error> = .success(HomeHistoricData.mock())
    var fetchHistoricDataKoResult: Result<HomeHistoricData, Error> = .failure(ErrorMock.someRandomCase)
    
    var fetchHistoricDataCalled = false
    var fetchHistoricDataShouldReturnOk = true
    
    func fetchHistoricData(completion: @escaping (Result<HomeHistoricData, Error>) -> Void) {
        fetchHistoricDataCalled = true
        if fetchHistoricDataShouldReturnOk {
            completion(fetchHistoricDataOkResult)
        } else {
            completion(fetchHistoricDataKoResult)
        }
    }
}

extension HistoricDataUseCaseMock: MockResetProtocol {
    func reset() {
        fetchHistoricDataRawCalled = false
        fetchHistoricDataRawShouldReturnOk = true
        fetchHistoricDataCalled = false
        fetchHistoricDataShouldReturnOk = true
    }
}
