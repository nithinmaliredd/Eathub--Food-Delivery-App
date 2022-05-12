

import UIKit

class LeftMenuCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var viewImageBg: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ menuItem: MenuItem, _ isMenuOpen: Bool) {
        imgView.image = UIImage(named: menuItem.imageName)
        self.lblTitle.text = menuItem.title
    }
}
