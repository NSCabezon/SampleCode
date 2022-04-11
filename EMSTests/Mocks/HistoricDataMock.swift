import Foundation

@testable import EMS

extension HistoricData {
    static func mock() -> Self {
        return [HistoricDataElement(buildingActivePower: 100,
                                    gridActivePower: 12,
                                    pvActivePower: 9,
                                    quasarsActivePower: 0.5,
                                    timestamp: Date())]
    }
}
