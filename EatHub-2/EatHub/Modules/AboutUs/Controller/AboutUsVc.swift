

import UIKit

class AboutUsVc: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func btnBack(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
