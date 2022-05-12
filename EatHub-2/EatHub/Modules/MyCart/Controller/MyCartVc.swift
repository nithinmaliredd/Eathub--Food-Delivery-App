

import UIKit

class MyCartVc: BaseViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblTotalTitle: UILabel!
    @IBOutlet weak var btnCheckout: UIButton!
    @IBOutlet weak var viewEmptyCart: UIView!

    var viewModel: MyCartViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MyCartViewModel(self)
        self.tblView.register(UINib.init(nibName: String(describing: CartCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CartCell.self))
        viewModel.fetchCartItem()
    }

    @IBAction func btnBack(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCheckOut(_ sender: UIButton) {
        
        showToast(message: "Order Placed Successfully", font: .systemFont(ofSize: 18))
        viewModel.deleteAllCartItem()
    }
}

extension MyCartVc: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrFoodItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CartCell.self)) as? CartCell {
            cell.configure(viewModel.arrFoodItem[indexPath.row])
            cell.delegate = self
            cell.index = indexPath.row
            return cell
        }
        return UITableViewCell()
    }
}

extension MyCartVc: CartCellDelegate {
    func actionIncrement(_ index: Int) {
        viewModel.performIncrement(index)
    }
    
    func actionDecrement(_ index: Int) {
        viewModel.performDecrement(index)
    }
}
