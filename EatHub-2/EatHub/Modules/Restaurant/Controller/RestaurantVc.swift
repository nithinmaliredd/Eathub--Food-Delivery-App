

import UIKit

class RestaurantVc: BaseViewController {
    
    @IBOutlet weak var tblView: UITableView!
    var viewModel: RestaurantViewModel!


    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RestaurantViewModel(self)
        self.tblView.register(UINib.init(nibName: String(describing: RestaurantCell.self), bundle: nil), forCellReuseIdentifier: String(describing: RestaurantCell.self))
    }
}


extension RestaurantVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrRestaurant.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantCell.self)) as? RestaurantCell {
            cell.configure(viewModel.arrRestaurant[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard =  UIStoryboard(name: StoryBoardName.Dashboard, bundle: Bundle.main)
        if let vc = storyBoard.instantiateViewController(withIdentifier: String(describing: DashboardVc.self)) as? DashboardVc {
            vc.index = indexPath.row
            vc.strTitle = viewModel.arrRestaurant[indexPath.row].name
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tblView.frame.size.width / 1.77
    }
}



