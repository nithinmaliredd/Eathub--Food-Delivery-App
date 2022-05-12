

import UIKit

class RestaurantCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ restaurant: Restaurant) {
        self.lblTitle.text = restaurant.name
        self.imgView.image = UIImage(named: restaurant.image)
    }
}
