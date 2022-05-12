

import UIKit

class DashboardVc: BaseViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    var strTitle = ""
    var viewModel: DashboardViewModel!
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = strTitle
        viewModel = DashboardViewModel(self)
        viewModel.populateFoodItem()
        self.tblView.register(UINib.init(nibName: String(describing: FoodItemCell.self), bundle: nil), forCellReuseIdentifier: String(describing: FoodItemCell.self))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.makeCartItemSelected()
    }
    
    @IBAction func btnMenu(_ sender: UIButton) {
        self.sideMenuViewController?.showLeftMenuViewController()
    }
    
    
}

extension DashboardVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrFoodItem.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FoodItemCell.self)) as? FoodItemCell {
            cell.configure(viewModel.arrFoodItem[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let obj = viewModel.arrFoodItem[indexPath.row]
        
        if obj.selected {
            CartDatabaseHelper.deleteCartItem(itemId: obj.id) { [weak self] in
                guard let `self` = self else { return }
                obj.selected = false
                obj.quantity = 0
                viewModel.arrFoodItem[indexPath.row] = obj
                self.tblView.reloadData()
            }
        } else {
            obj.quantity = 1
            obj.selected = true
            CartDatabaseHelper.addItemToCart(item: obj) { [weak self] status in
                guard let `self` = self else { return }
                if status {
                    viewModel.arrFoodItem[indexPath.row] = obj
                    self.tblView.reloadData()
                    
                }
            }
        }
        self.tblView.reloadData()
    }
}



