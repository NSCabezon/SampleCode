import Foundation
import HelpersSPM

let historicName = "historic_data"
let liveName = "live_data"

class Mocks {
    static func loadJSON<T: Decodable>(withName filename: String,
                                       in bundleParam: Bundle? = nil,
                                       as type: T.Type = T.self) -> T {
        var bundle: Bundle
        if let bundleParam = bundleParam {
            bundle = bundleParam
        } else {
            bundle = Bundle(for: Mocks.self)
        }
        let data: Data
        do {
            let path = bundle.path(forResource: filename, ofType: "json")!
            let url = URL(fileURLWithPath: path)
            data = try Data(contentsOf: url)
        } catch {
            fatalError("Couldn’t load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601WithoutDecimals)
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn’t parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
