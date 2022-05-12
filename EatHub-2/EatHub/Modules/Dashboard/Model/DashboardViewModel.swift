
import Foundation
import UIKit

class DashboardViewModel {
    
    var controller: DashboardVc?
    
    init(_ controller: DashboardVc) {
        self.controller = controller
    }
    
    var arrFoodItem: [FoodItem] = []
    
    
    func populateFoodItem() {
        switch controller?.index {
        case 0:
            arrFoodItem = FoodItemFactory.restaurantOneFoodItem
        case 1:
            arrFoodItem = FoodItemFactory.restaurantTwoFoodItem
        case 2:
            arrFoodItem = FoodItemFactory.restaurantThreeFoodItem
        case 3:
            arrFoodItem = FoodItemFactory.restaurantFourFoodItem
        default:
            arrFoodItem = FoodItemFactory.restaurantOneFoodItem
        }
        controller?.tblView.reloadData()
    }
    
    func makeCartItemSelected() {
        
        for i in 0..<self.arrFoodItem.count {
            self.arrFoodItem[i].selected = false
        }
        
        
        
        CartDatabaseHelper.fetchCartItem { [weak self] arr in
            guard let `self` = self else { return }
            for x in arr {
                if x.selected {
                    for i in 0..<self.arrFoodItem.count {
                        let obj  = self.arrFoodItem[i]
                        if x.id == obj.id {
                            self.arrFoodItem[i].selected = true
                            break
                        }
                    }
                }
            }
            self.controller?.tblView.reloadData()
        }
    }
}
