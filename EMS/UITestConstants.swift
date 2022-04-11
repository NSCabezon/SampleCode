import Foundation

final class UITestConstants {
    enum LaunchArguments: String {
        case uiTests = "-UI_TESTS"
        case resetApp = "-RESET_APP"

        var exists: Bool {
            return CommandLine.arguments.contains(rawValue)
        }

        static var defaultLaunchArguments: [String] {
            return [LaunchArguments.uiTests,
                    LaunchArguments.resetApp].map { $0.rawValue }
        }
    }
}
