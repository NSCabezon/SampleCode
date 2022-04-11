import Foundation

@testable import EMS

extension LiveData {
    static func mock() -> Self {
        return LiveData(solarPower: 12,
                        quasarsPower: 342,
                        gridPower: 23,
                        buildingDemand: 145,
                        systemSoc: 64,
                        totalEnergy: 23,
                        currentEnergy: 234)
    }
}
