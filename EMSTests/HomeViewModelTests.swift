import XCTest

@testable import EMS
import SwiftyMocky

class HomeViewModelTests: XCTestCase {
    var sut: HomeViewModelProtocol!
    var navigationControllerMock = NavigationViewControllerMock()
    var coordinatorMock: HomeCoordinatorMock!
    var historicDataUseCaseMock: HistoricDataUseCaseMock!
    var liveDataUseCaseMock: LiveDataUseCaseMock!

    override func setUp() {
        coordinatorMock =  HomeCoordinatorMock(parentNavigationController: navigationControllerMock)
        historicDataUseCaseMock = HistoricDataUseCaseMock()
        liveDataUseCaseMock = LiveDataUseCaseMock()
        
        sut = HomeViewModel(coordinator: coordinatorMock,
                            historicUseCase: historicDataUseCaseMock,
                            liveDataUseCase: liveDataUseCaseMock)
    }

    override func tearDown() {
        navigationControllerMock.reset()
    }
    
    func testViewDidLoadUseCasesOk() {
        // Arrange
        self.historicDataUseCaseMock.fetchHistoricDataShouldReturnOk = true
        Perform(liveDataUseCaseMock, .fetchLiveData(completion: .any, perform: { completion in
            completion(.success(LiveData.mock()))
        }))

        // Assert
        sut.didGetHistoricData = { success in
            XCTAssertTrue(success)
            XCTAssertTrue(self.historicDataUseCaseMock.fetchHistoricDataCalled)
            XCTAssertEqual(self.sut.totalDischarged, "10.00 kWh")
        }
        sut.didGetLiveData = { success in
            XCTAssertTrue(success)
            Verify(self.liveDataUseCaseMock, 1, .fetchLiveData(completion: .any))
            XCTAssertEqual(self.sut.liveDataSolarText, "☀️ 12.00 kWh")
        }

        // Act
        sut.viewDidLoad()
    }

    func testViewDidLoadUseCasesKo() {
        // Arrange
        self.historicDataUseCaseMock.fetchHistoricDataShouldReturnOk = false
        Perform(liveDataUseCaseMock, .fetchLiveData(completion: .any, perform: { completion in
            completion(.failure(ErrorMock.someRandomCase))
        }))

        // Assert
        sut.didGetHistoricData = { success in
            XCTAssertFalse(success)

            XCTAssertTrue(self.historicDataUseCaseMock.fetchHistoricDataCalled)
            XCTAssertNil(self.sut.totalDischarged)
            XCTAssertNil(self.sut.totalCharged)

            XCTAssertNil(self.sut.pvPercentage)
            XCTAssertNil(self.sut.gridPercentage)
        }
        sut.didGetLiveData = { success in
            XCTAssertFalse(success)
            Verify(self.liveDataUseCaseMock, 1, .fetchLiveData(completion: .any))
            XCTAssertNil(self.sut.liveDataBuildingDemandText)
            XCTAssertNil(self.sut.liveDataSolarText)
            XCTAssertNil(self.sut.liveDataGridText)
        }

        // Act
        sut.viewDidLoad()
    }
    
    func testOpenDetail() {
        // Act
        sut.openDetail()
        
        // Assert
        XCTAssertTrue(self.coordinatorMock.openDetailCalled)
    }
}
