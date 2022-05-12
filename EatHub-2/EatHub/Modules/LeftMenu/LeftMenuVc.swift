

import UIKit

class LeftMenuVc: BaseViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblUserName: UILabel!
    var isExpand = false

    let arrMenu: [MenuItem] = [
        MenuItem("My Cart", "menu_cart"),
        MenuItem("About Us", "about"),
        MenuItem("Logout", "logout")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblView.register(UINib.init(nibName: String(describing: LeftMenuCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LeftMenuCell.self))
        self.lblUserName.text = "Hello " + (AppSharedData.shared.userInfo?.firstName ?? "").capitalized
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }
}

extension LeftMenuVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrMenu.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LeftMenuCell") as? LeftMenuCell {
            cell.configure(arrMenu[indexPath.row], self.isExpand)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = arrMenu[indexPath.row].title
        
        switch title {
        case "Logout":
            
            CustomAlert.shared.showCustomConfirmationAlert("! We will miss you !", "Sure you want to logout?", self.view) {
                UserDefaults.standard.set(false, forKey: AppSharedData.shared.keySession)
                AppSharedData.shared.moveToLogin()
            }

        case "My Cart":
            
            let storyBoard =  UIStoryboard(name: StoryBoardName.MyCart, bundle: Bundle.main)
            let vc = storyBoard.instantiateViewController(withIdentifier: "MyCartVc")
            self.navigationController?.pushViewController(vc, animated: true)
            
        case "About Us":
            
            let storyBoard =  UIStoryboard(name: StoryBoardName.AboutUs, bundle: Bundle.main)
            let vc = storyBoard.instantiateViewController(withIdentifier: "AboutUsVc")
            self.navigationController?.pushViewController(vc, animated: true)

        default:
            break
        }
        
        self.sideMenuViewController?.hideMenuViewController()

        
    }
}

class MenuItem {
    
    var title = ""
    var imageName = ""
    
    init(_ title: String, _ imageName: String) {
        self.title = title
        self.imageName = imageName
    }
}
