

import UIKit

protocol CartCellDelegate: AnyObject {
    func actionIncrement(_ index: Int)
    func actionDecrement(_ index: Int)
}

class CartCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    var index: Int = -1
    weak var delegate: CartCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ item: FoodItem) {
        lblTitle.text = item.name
        lblDescription.text = item.description
        let total = item.price * Double(item.quantity)
        lblPrice.text = "\(rupeeSymbol)\(total)"
        lblCount.text = "\(item.quantity)"
        imgView.image = UIImage(named: item.image)
    }
    
    @IBAction func btnIncrement(_ sender: UIButton) {
        delegate?.actionIncrement(self.index)
    }
    
    @IBAction func btnDecrement(_ sender: UIButton) {
        delegate?.actionDecrement(self.index)
    }

    
}
