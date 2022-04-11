import Foundation

@testable import EMS

extension HomeHistoricData: Equatable {
    public static func ==(lhs: HomeHistoricData, rhs: HomeHistoricData) -> Bool {
        return lhs.gridPercentage == rhs.gridPercentage &&
        lhs.pvPercentage == rhs.pvPercentage &&
        lhs.totalCharged == rhs.totalCharged &&
        lhs.totalDischarged == rhs.totalDischarged
    }
}

extension HomeHistoricData {
    static func mock() -> Self {
        return HomeHistoricData(totalDischarged: 10,
                                totalCharged: 12,
                                pvPercentage: 42,
                                gridPercentage: 58)
    }
}
