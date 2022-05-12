

import Foundation
import UIKit

class CustomAlert: NSObject {
    
    private override init() {}
    static let shared = CustomAlert()

    func showCustomConfirmationAlert(_ title: String, _ message: String, _ view: UIView, _ onConfirm: @escaping () -> Void) {
        
        if let viewVerifyConfirmation = Bundle.main.loadNibNamed("CustomAlertView", owner: self, options: nil)![0] as? CustomAlertView {
            
            if title.isEmpty {
                viewVerifyConfirmation.lblTitle.text = "Oops!"
            } else {
                viewVerifyConfirmation.lblTitle.text = title
            }
            
            viewVerifyConfirmation.lblDescription.text = message
            viewVerifyConfirmation.frame = view.frame
            viewVerifyConfirmation.actionLeftButton = {
            }
            viewVerifyConfirmation.actionRightButton = {
                onConfirm()
            }
            
            viewVerifyConfirmation.leftButton.isHidden = false
            viewVerifyConfirmation.rightButton.isHidden = false
            viewVerifyConfirmation.rightButton.setTitle("Yes", for: .normal)
            viewVerifyConfirmation.leftButton.setTitle("No", for: .normal)


            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                if let window = delegate.window {
                    window.addSubview(viewVerifyConfirmation)
                }
            }
            viewVerifyConfirmation.viewInner.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1.2, initialSpringVelocity: 0.8, options: [.curveEaseInOut]) {
                viewVerifyConfirmation.viewInner.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            } completion: { _ in
                UIView.animate(withDuration: 0.2) {
                    viewVerifyConfirmation.viewInner.transform = .identity
                }
            }
        }
    }
    
    
    func showCustomAlert(_ title: String, _ message: String, _ view: UIView, onComplete: (() -> Void)? = nil) {
        
        if let viewVerifyConfirmation = Bundle.main.loadNibNamed("CustomAlertView", owner: self, options: nil)![0] as? CustomAlertView {
            
            if title.isEmpty {
                viewVerifyConfirmation.lblTitle.text = "Oops!"
            } else {
                viewVerifyConfirmation.lblTitle.text = title
            }
            
            viewVerifyConfirmation.lblDescription.text = message
            viewVerifyConfirmation.frame = view.frame
            viewVerifyConfirmation.actionLeftButton = {
            }
            viewVerifyConfirmation.actionRightButton = {
                onComplete?()
            }
            
            viewVerifyConfirmation.leftButton.isHidden = true
            viewVerifyConfirmation.rightButton.isHidden = false
            viewVerifyConfirmation.rightButton.setTitle("OK", for: .normal)


            view.addSubview(viewVerifyConfirmation)
            
            viewVerifyConfirmation.viewInner.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1.2, initialSpringVelocity: 0.8, options: [.curveEaseInOut]) {
                viewVerifyConfirmation.viewInner.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            } completion: { _ in
                UIView.animate(withDuration: 0.2) {
                    viewVerifyConfirmation.viewInner.transform = .identity
                }
            }
        }
    }
    
    func showNativeAlert(_ title: String, _ message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            if let window = delegate.window {
                window.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
}
