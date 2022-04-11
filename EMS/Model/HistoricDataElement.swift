import Foundation

typealias HistoricData = [HistoricDataElement]

struct HistoricDataElement: Decodable {
    let buildingActivePower: Double
    let gridActivePower: Double
    let pvActivePower: Double
    /// If the value is positive the cars are being charged with energy from the grid.
    /// If the value is negative it means it is discharging to the building to supply the building demand.
    let quasarsActivePower: Double
    let timestamp: Date

    enum CodingKeys: String, CodingKey {
        case buildingActivePower = "building_active_power"
        case gridActivePower = "grid_active_power"
        case pvActivePower = "pv_active_power"
        case quasarsActivePower = "quasars_active_power"
        case timestamp
    }
}
