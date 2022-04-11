import Foundation

struct AccessibilityIdentifiers {
    struct HomeViewController {
        private static let Identifier: String = "HomeViewController"
        static let DischargeLabel: String = Identifier + ".DischargeLabel"
        static let DetailWidgetButton: String = Identifier + ".DetailWidgetButton"
    }

    struct DetailViewController {
        private static let Identifier: String = "DetailViewController"
        static let Chart: String = Identifier + ".Chart"
    }
}
