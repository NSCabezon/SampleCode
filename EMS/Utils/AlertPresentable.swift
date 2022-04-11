import UIKit

typealias AlertCompletion = (_ action: UIAlertAction, _ alert: UIAlertController) -> Void

protocol AlertPresentable {
    func presentErrorAlert(message: String, acceptCompletion: AlertCompletion?, viewController: UIViewController)
    func presentAlert(title: String?,
                      message: String?,
                      acceptTitle: String?,
                      acceptCompletion: AlertCompletion?,
                      cancelTitle: String?,
                      cancelCompletion: AlertCompletion?,
                      style: UIAlertAction.Style?,
                      viewController: UIViewController)
}

extension AlertPresentable {
    func presentErrorAlert(message: String, acceptCompletion: AlertCompletion? = nil, viewController: UIViewController) {
        presentAlert(message: message, acceptCompletion: acceptCompletion, viewController: viewController)
    }

    func presentAlert(title: String? = nil,
                      message: String? = nil,
                      acceptTitle: String? = nil,
                      acceptCompletion: AlertCompletion? = nil,
                      cancelTitle: String? = nil,
                      cancelCompletion: AlertCompletion? = nil,
                      style: UIAlertAction.Style? = nil,
                      viewController: UIViewController) {
        AlertManager.showAlert(title: title,
                               message: message,
                               acceptTitle: acceptTitle,
                               acceptCompletion: acceptCompletion,
                               cancelTitle: cancelTitle,
                               cancelCompletion: cancelCompletion,
                               isDestructive: (style == .destructive),
                               viewController: viewController)
    }
}

class AlertManager: NSObject {
    class func showAlert(errorString: String?, completion: AlertCompletion?, viewController: UIViewController) {
        showAlert(title: nil,
                  message: errorString,
                  acceptTitle: nil,
                  acceptCompletion: completion,
                  cancelTitle: nil,
                  cancelCompletion: nil,
                  viewController: viewController)
    }

    class func showAlert(title: String? = "",
                         message: String?,
                         acceptTitle: String?,
                         acceptCompletion: AlertCompletion? = nil,
                         cancelTitle: String? = nil,
                         cancelCompletion: AlertCompletion? = nil,
                         isDestructive: Bool = false,
                         viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        if let cancel = cancelTitle {
            let cancelAction = UIAlertAction(title: cancel, style: isDestructive ? .destructive : .default, handler: { action in
                if let completion = cancelCompletion {
                    completion(action, alert)
                }
            })
            alert.addAction(cancelAction)
        }

        let okAction = UIAlertAction(title: acceptTitle, style: .default) { action in
            if let completion = acceptCompletion {
                completion(action, alert)
            }
        }

        alert.addAction(okAction)

        viewController.present(alert, animated: true, completion: nil)
    }
}
