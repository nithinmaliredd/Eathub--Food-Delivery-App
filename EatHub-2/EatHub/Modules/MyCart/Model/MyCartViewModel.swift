

import Foundation
import UIKit

class MyCartViewModel {
    var controller: MyCartVc?
    var arrFoodItem: [FoodItem] = []
    
    
    init(_ controller: MyCartVc) {
        self.controller = controller
    }
    
    func fetchCartItem() {
        CartDatabaseHelper.fetchCartItem { [weak self] arr in
            guard let `self` = self else { return }

            self.arrFoodItem = arr
            self.controller?.tblView.reloadData()
            self.calculateTotal()
        }
    }
    
    func calculateTotal() {
        var total: Double = 0.0
        for x in arrFoodItem {
            total += x.price * Double(x.quantity)
        }
        controller?.lblTotal.text = "\(rupeeSymbol)\(total)"
        
        if arrFoodItem.isEmpty {
            controller?.viewEmptyCart.isHidden = false
            controller?.lblTotalTitle.isHidden = true
            controller?.lblTotal.isHidden = true
            controller?.btnCheckout.isHidden = true
        } else {
            controller?.viewEmptyCart.isHidden = true
            controller?.lblTotalTitle.isHidden = false
            controller?.lblTotal.isHidden = false
            controller?.btnCheckout.isHidden = false
        }
    }
    
    func deleteAllCartItem() {
        CartDatabaseHelper.deleteAllCartItem { [weak self] in
            guard let `self` = self else { return }
            _ = self.controller?.navigationController?.popViewController(animated: true)
        }
    }
    
    func performIncrement(_ index: Int) {
        let obj = self.arrFoodItem[index]
        obj.quantity += 1
        CartDatabaseHelper.changeItemCount(itemId: obj.id, count: obj.quantity) { [weak self] in
            guard let `self` = self else { return }

            self.arrFoodItem[index] = obj
            self.controller?.tblView.reloadData()
        }
        self.calculateTotal()
    }
    
    func performDecrement(_ index: Int) {
        let obj = self.arrFoodItem[index]
        obj.quantity -= 1
        if obj.quantity == 0 {
            CartDatabaseHelper.deleteCartItem(itemId: obj.id) { [weak self] in
                guard let `self` = self else { return }

                self.arrFoodItem.remove(at: index)
                self.controller?.tblView.reloadData()
            }
        } else {
            CartDatabaseHelper.changeItemCount(itemId: obj.id, count: obj.quantity) { [weak self] in
                guard let `self` = self else { return }

                self.arrFoodItem[index] = obj
                self.controller?.tblView.reloadData()
            }
        }
        self.calculateTotal()
    }
}
