import Foundation

struct LiveData: Decodable {
    let solarPower: Double
    let quasarsPower: Double
    let gridPower: Double
    let buildingDemand: Double
    let systemSoc: Double
    let totalEnergy: Int
    let currentEnergy: Int

    enum CodingKeys: String, CodingKey {
        case solarPower = "solar_power"
        case quasarsPower = "quasars_power"
        case gridPower = "grid_power"
        case buildingDemand = "building_demand"
        case systemSoc = "system_soc"
        case totalEnergy = "total_energy"
        case currentEnergy = "current_energy"
    }
}
