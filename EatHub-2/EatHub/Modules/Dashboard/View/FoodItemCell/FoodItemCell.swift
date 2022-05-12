

import UIKit

class FoodItemCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var lblFreeDelivery: UILabel!
    @IBOutlet weak var btnCheck: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ item: FoodItem) {
        imgView.image = UIImage(named: item.image)
        lblName.text = item.name
        lblDescription.text = item.description
        viewRating.rating = item.rating
        lblFreeDelivery.isHidden = !item.freeDelivery
        btnCheck.isSelected = item.selected
        
        if item.selected {
            btnCheck.tintColor = UIColor(red: 0.20, green: 0.76, blue: 0.33, alpha: 1.00)
        } else {
            btnCheck.tintColor = UIColor(red: 1.00, green: 0.20, blue: 0.33, alpha: 1.00)
        }
    }
}
