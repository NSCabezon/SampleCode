import XCTest
import SwiftyMocky

@testable import EMS

class HistoricUseCaseTests: XCTestCase {
    var sut: HistoricDataUseCase!
    var repositoryMock: QuasarRepositoryProtocolMock!

    override func setUp() {
        repositoryMock = QuasarRepositoryProtocolMock()
        sut = DefaultHistoricDataUseCase(historicRepository: repositoryMock)
    }

    func testFetchHistoricData() {
        // Arrange
        var sutResult: Result<HomeHistoricData, Error>?
        let expectation = expectation(description: "Waiting for the fetchHistoricData call to complete.")
        Perform(repositoryMock, .getHistoric(completion: .any, perform: { completion in
            completion(.success(HistoricData.mock()))
        }))

        // Act
        sut.fetchHistoricData { result in
            sutResult = result
            expectation.fulfill()
        }

        // Assert
        waitForExpectations(timeout: 2) { error in
            XCTAssertNil(error)
            switch sutResult {
            case .success(let historicData):
                XCTAssertNotNil(historicData)
                XCTAssertEqual(historicData, HomeHistoricData(totalDischarged: 0,
                                                              totalCharged: 0.008333333333333333,
                                                              pvPercentage: 42.857142857142854,
                                                              gridPercentage: 57.142857142857146))
            case .failure,
                 .none:
                XCTFail()
            }
        }
    }
}
