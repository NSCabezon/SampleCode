import Foundation

struct DefaultLiveDataUseCase {
    private let liveDataRepository: QuasarRepositoryProtocol

    init(liveDataRepository: QuasarRepositoryProtocol) {
        self.liveDataRepository = liveDataRepository
    }
}

extension DefaultLiveDataUseCase: LiveDataUseCase {
    func fetchLiveData(completion: @escaping (Result<LiveData, Error>) -> Void) {
        liveDataRepository.getLiveData(completion: completion)
    }
}
