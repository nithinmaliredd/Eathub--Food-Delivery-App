

import UIKit

// MARK: - UIViewController+AKSideMenu

extension UIViewController {

    public var sideMenuViewController: AKSideMenu? {
        guard var iterator = self.parent else { return nil }
        guard let strClass = String(describing: type(of: iterator)).components(separatedBy: ".").last else { return nil }

        while strClass != nibName {
            if iterator is AKSideMenu {
                return iterator as? AKSideMenu
            } else if iterator.parent != nil && iterator.parent != iterator {
                iterator = iterator.parent!
            }
        }
        return nil
    }

    // MARK: - Public
    // MARK: - IBAction Helper methods

    @IBAction public func presentLeftMenuViewController(_ sender: AnyObject) {
        self.sideMenuViewController?.presentLeftMenuViewController()
    }

    @IBAction public func presentRightMenuViewController(_ sender: AnyObject) {
        self.sideMenuViewController?.presentRightMenuViewController()
    }
    
    @IBAction public func goBack(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
