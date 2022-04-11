import Foundation

@testable import EMS

class LiveDataUseCaseMock: LiveDataUseCase {
    var fetchLiveDataOkResult: Result<LiveData, Error> = .success(LiveData.mock())
    var fetchLiveDataKoResult: Result<LiveData, Error> = .failure(ErrorMock.someRandomCase)
    
    var fetchLiveDataShouldReturnOk = true
    var fetchLiveDataDataCalled = true
    func fetchLiveData(completion: @escaping (Result<LiveData, Error>) -> Void) {
        fetchLiveDataDataCalled = true
        if fetchLiveDataShouldReturnOk {
            completion(fetchLiveDataOkResult)
        } else {
            completion(fetchLiveDataKoResult)
        }
    }
}

extension LiveDataUseCaseMock: MockResetProtocol {
    func reset() {
        fetchLiveDataShouldReturnOk = true
        fetchLiveDataDataCalled = false
    }
}
