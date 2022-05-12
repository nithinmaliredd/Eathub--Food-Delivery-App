
import Foundation
import UIKit

class AppSharedData {

    private init() {}
    let keySession = "sessionKey"
    let keyUserInfo = "keyUserInfo"

    static let shared = AppSharedData()
    var rootNav: UINavigationController!
    var userInfo: UserInfo?
    
    func setRootViewController(controller: UIViewController) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = controller
        appDelegate.window?.makeKeyAndVisible()
    }

    func getViewController<T>(storyboardName:String, viewControllerName:String) -> T {
        let storyBoard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: viewControllerName) as! T
        return viewController
    }
    
    func moveToDashboard() {
        userInfo = getFromUserDefaults(keyUserInfo) as? UserInfo
        let storyboard = UIStoryboard(name: StoryBoardName.Dashboard, bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "RootNavigation")
        rootNav = vc as? UINavigationController
        setRootViewController(controller: vc)
    }
    
    func isSessionMaintained()  {
        
        if UserDefaults.standard.bool(forKey: keySession) {
            moveToDashboard()
        } else {
            moveToLogin()
        }
    }
    
    func moveToLogin() {
        let storyBoard =  UIStoryboard(name: StoryBoardName.SignIn, bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SignInVC")
        saveToUserDefault(keyUserInfo, "")
        setRootViewController(controller: vc)
    }
    
    func saveToUserDefault(_ key: String, _ value: Any) {
        
        let userDefault = UserDefaults.standard
        
        let data = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
        userDefault.setValue(data, forKey: key)
        userDefault.synchronize()
    }

    func getFromUserDefaults(_ key: String) -> Any? {
        
        let userDefault = UserDefaults.standard
        
        if let dataValue = userDefault.value(forKey: key) as? Data {
            
            let value = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dataValue)
            return value
        }
        return nil
    }

}


    
