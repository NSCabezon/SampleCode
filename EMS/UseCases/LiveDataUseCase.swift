import Foundation

// sourcery: AutoMockable
protocol LiveDataUseCase {
    func fetchLiveData(completion: @escaping (Result<LiveData, Error>) -> Void)
}
