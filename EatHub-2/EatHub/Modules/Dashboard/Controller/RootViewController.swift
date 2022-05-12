

import UIKit

public class RootViewController: AKSideMenu, AKSideMenuDelegate {

    override public func awakeFromNib() {
        super.awakeFromNib()
        self.menuPreferredStatusBarStyle = .lightContent
        self.contentViewShadowColor = .black
        self.contentViewShadowOffset = CGSize(width: 0, height: 0)
        self.contentViewShadowOpacity = 0.6
        self.contentViewShadowRadius = 12
        self.contentViewShadowEnabled = true

        self.backgroundImage = UIImage(named: "Stars")
        self.delegate = self

        self.contentViewController = AppSharedData.shared.getViewController(storyboardName: StoryBoardName.Restaurant, viewControllerName: String(describing: RestaurantVc.self))
        self.leftMenuViewController = AppSharedData.shared.getViewController(storyboardName: StoryBoardName.LeftMenu, viewControllerName: String(describing: LeftMenuVc.self))
    }

    // MARK: - <AKSideMenuDelegate>

    public func sideMenu(_ sideMenu: AKSideMenu, willShowMenuViewController menuViewController: UIViewController) {
    }

    public func sideMenu(_ sideMenu: AKSideMenu, didShowMenuViewController menuViewController: UIViewController) {
    }

    public func sideMenu(_ sideMenu: AKSideMenu, willHideMenuViewController menuViewController: UIViewController) {
    }

    public func sideMenu(_ sideMenu: AKSideMenu, didHideMenuViewController menuViewController: UIViewController) {
    }
}
