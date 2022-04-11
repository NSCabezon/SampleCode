import UIKit

extension UIViewController {
    func loadViewProgrammatically() {
        self.beginAppearanceTransition(true, animated: false)
        self.endAppearanceTransition()
    }
}
