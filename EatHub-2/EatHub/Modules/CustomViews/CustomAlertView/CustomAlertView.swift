

import UIKit

class CustomAlertView: UIView {
    
    var actionLeftButton: (() -> Void)?
    var actionRightButton: (() -> Void)?

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var viewInner: UIView!
    @IBOutlet var leftButton: UIButton!
    @IBOutlet var rightButton: UIButton!

    @IBAction func leftButton(_ sender: UIButton) {
        self.removeFromSuperview()
        self.actionLeftButton?()
    }

    @IBAction func rightButton(_ sender: UIButton) {
        self.removeFromSuperview()
        self.actionRightButton?()
    }
}
