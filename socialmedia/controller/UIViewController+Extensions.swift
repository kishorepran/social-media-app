//
//  UIViewController+Extensions.swift
//  socialmedia
//
//  Created by Pran Kishore on 13/04/24.
//

import UIKit

extension UIViewController {
    typealias AlertComnpletion = ((UIAlertAction) -> Swift.Void)?
    
    /**
     Show Success alert with a title and message. Dismisses the view controller after the user presses OK button.
     
     - Parameter title: Title of the alert. Defaults to "Social Media App"
     - Parameter message: Message to be displayed to user
     - Parameter action: Action to be excecuted when the user presses the OK button.
     */
    func showSuccessAlert(title: String = "Social Media App", message: String, btnTitle: String = "OK", action: AlertComnpletion) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: btnTitle, style: UIAlertAction.Style.default, handler: action)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    /**
     Show Error alert with a title and message. Does not have any thing in completion. Stays on the view controller that is being called.
     
     - Parameter title: Title of the alert. Defaults to "Social Media App"
     - Parameter message: Message to be displayed to user
     */
    func showErrorAlert(_ title: String = "Social Media App", message: String) {
        let text: String = title
        let alertController = UIAlertController(title: text, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (_ : UIAlertAction) -> Void in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    /**
     Show Success alert with a title and message. Dismisses the view controller after the user presses OK button.
     
     - Parameter title: Title of the alert. Defaults to "Social Media App"
     - Parameter message: Message to be displayed to user
     - Parameter okAction: Action to be excecuted when the user presses the OK button.
     - Parameter cancelAction: Cancel Action to be excecuted when the user presses the OK button.
     */
    func showAlert(title: String = "Social Media App", message: String, okBtnTitle: String = "OK", cancelBtnTitle: String =  "Cancel", okAction: AlertComnpletion, cancelAction: AlertComnpletion) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: okBtnTitle, style: UIAlertAction.Style.default, handler: okAction)
        let cancel = UIAlertAction(title: cancelBtnTitle, style: UIAlertAction.Style.default, handler: cancelAction)
        alertController.addAction(action)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
}
