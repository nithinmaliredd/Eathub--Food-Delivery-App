

import Foundation
import UIKit
import CoreData

class UserInfoDatabaseHelper: NSObject {
    
    static let userDataEntityName = "UsersData"
    
    class func addNewUser(user: UserInfo, onComplete: (Bool) -> Void) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            
            let managedContext = delegate.managedContext
            
            managedContext.performAndWait {
                
                if let entity =  NSEntityDescription.entity(forEntityName: userDataEntityName,
                                                            in:managedContext) {
                    
                    let objMyCard =  NSManagedObject(entity: entity, insertInto: managedContext)
                    
                    objMyCard.setValue(user.firstName, forKey: "firstName")
                    objMyCard.setValue(user.lastName, forKey: "lastName")
                    objMyCard.setValue(user.email, forKey: "email")
                    objMyCard.setValue(user.contactNumber, forKey: "contactNumber")
                    objMyCard.setValue(user.password, forKey: "password")
                    do {
                        try managedContext.save()
                        onComplete(true)
                    } catch let error as NSError  {
                        print("Could not save \(error), \(error.userInfo)")
                        onComplete(false)
                    }
                }
            }
        }
    }
    
    class func fetchUsersInformation(OnComplete: @escaping ([UserInfo]) -> Void) {
        
        var arrUserInfo: [UserInfo] = []
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            
            let managedContext = delegate.managedContext
            
            managedContext.performAndWait {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: userDataEntityName)
                do {
                    let results =
                    try managedContext.fetch(fetchRequest)
                    
                    for object in results {
                        guard let result = object as? NSManagedObject else {continue}
                        
                        let userInfo = UserInfo()
                        
                        userInfo.firstName = extractString(dict: result, key: "firstName")
                        userInfo.lastName = extractString(dict: result, key: "lastName")
                        userInfo.email = extractString(dict: result, key: "email")
                        userInfo.contactNumber = extractString(dict: result, key: "contactNumber")
                        userInfo.password = extractString(dict: result, key: "password")
                        
                        arrUserInfo.append(userInfo)
                        
                    }
                    OnComplete(arrUserInfo)
                } catch let error {
                    print("error in deleting data -\(error)-")
                }
            }
        }
    }
}
    
class CartDatabaseHelper {
    
    static let cartEntityName = "CartItem"
    
    class func addItemToCart(item: FoodItem, onComplete: (Bool) -> Void) {
        
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            
            let managedContext = delegate.managedContext
            
            managedContext.performAndWait {
                
                if let entity =  NSEntityDescription.entity(forEntityName: cartEntityName,
                                                            in:managedContext) {
                    
                    let objMyCard =  NSManagedObject(entity: entity, insertInto: managedContext)
                    
                    objMyCard.setValue(item.quantity, forKey: "quantity")
                    objMyCard.setValue(item.id, forKey: "id")
                    objMyCard.setValue(item.price, forKey: "price")
                    objMyCard.setValue(item.rating, forKey: "rating")
                    objMyCard.setValue(item.description, forKey: "desc")
                    objMyCard.setValue(item.image, forKey: "image")
                    objMyCard.setValue(item.name, forKey: "name")
                    objMyCard.setValue(item.freeDelivery, forKey: "freeDelivery")
                    objMyCard.setValue(item.selected, forKey: "selected")
                    do {
                        try managedContext.save()
                        onComplete(true)
                    } catch let error as NSError  {
                        print("Could not save \(error), \(error.userInfo)")
                        onComplete(false)
                    }
                }
            }
        }
    }

    class func fetchCartItem(OnComplete: @escaping ([FoodItem]) -> Void) {
        
        var arrCartItem: [FoodItem] = []
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            
            let managedContext = delegate.managedContext
            
            managedContext.performAndWait {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: cartEntityName)
                do {
                    let results =
                    try managedContext.fetch(fetchRequest)
                    
                    for object in results {
                        guard let result = object as? NSManagedObject else {continue}
                        
                        let cartItem = FoodItem()
                        
                        cartItem.quantity = extractInteger(dict: result, key: "quantity")
                        cartItem.id = extractInteger(dict: result, key: "id")
                        cartItem.price = extractDouble(dict: result, key: "price")
                        cartItem.rating = extractDouble(dict: result, key: "rating")
                        cartItem.description = extractString(dict: result, key: "desc")
                        cartItem.image = extractString(dict: result, key: "image")
                        cartItem.name = extractString(dict: result, key: "name")
                        cartItem.freeDelivery = extractBoolean(dict: result, key: "freeDelivery")
                        cartItem.selected = extractBoolean(dict: result, key: "selected")
                        
                        arrCartItem.append(cartItem)
                        
                    }
                    OnComplete(arrCartItem)
                } catch let error {
                    print("error in deleting data -\(error)-")
                }
            }
        }
    }
    
    class func deleteAllCartItem(onComplete: (() -> Void)) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            
            let managedContext = delegate.managedContext
            
            managedContext.performAndWait {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: cartEntityName)
                fetchRequest.returnsObjectsAsFaults = false

                do {
                    
                    let results =
                    try managedContext.fetch(fetchRequest)
                    for object in results {
                        guard let objectData = object as? NSManagedObject else {continue}
                      
                        managedContext.delete(objectData)

                    }
                    try managedContext.save()
                    onComplete()
                } catch let error {
                    print("error in deleting data -\(error)-")
                }
            }
        }
    }
    
    class func deleteCartItem(itemId: Int, onComplete: (() -> Void)) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            
            let managedContext = delegate.managedContext
            
            managedContext.performAndWait {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: cartEntityName)
                fetchRequest.returnsObjectsAsFaults = false
                fetchRequest.predicate = NSPredicate(format: "id == %@", "\(itemId)")

                do {
                    
                    let results =
                    try managedContext.fetch(fetchRequest)
                    for object in results {
                        guard let objectData = object as? NSManagedObject else {continue}
                        
                        if itemId == extractInteger(dict: objectData, key: "id") {
                            managedContext.delete(objectData)
                            break
                        }
                    }
                    try managedContext.save()
                    onComplete()
                } catch let error {
                    print("error in deleting data -\(error)-")
                }
            }
        }
    }
    
    
    
    
    
    
    class func changeItemCount(itemId: Int, count: Int, onComplete: (() -> Void)) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            
            let managedContext = delegate.managedContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: cartEntityName)
            
            fetchRequest.predicate = NSPredicate(format: "id = %@", "\(itemId)")
            
            do {
                let results =
                try managedContext.fetch(fetchRequest)
                
                for object in results {
                    guard let objectData = object as? NSManagedObject else {continue}
                    objectData.setValue(count, forKey: "quantity")
                    break
                }
                
                try managedContext.save()
                onComplete()
                
            } catch let error {
                print("error in deleting data -\(error)-")
            }
        }
    }
}




 func extractString(dict: Any, key: String) -> String {
    
    if let str = (dict as AnyObject).value(forKey: key) as? String {
        return str
    } else {
        return ""
    }
}

 func extractInteger(dict: Any, key: String) -> Int {
    
    if let val = (dict as AnyObject).value(forKey: key) as? Int {
        return val
    } else {
        return 0
    }
}

func extractDouble(dict: Any, key: String) -> Double {
    
    if let val = (dict as AnyObject).value(forKey: key) as? Double {
        return val
    } else {
        return 0
    }
}

func extractBoolean(dict: Any, key: String) -> Bool {
    
    if let val = (dict as AnyObject).value(forKey: key) as? Bool {
        return val
    } else {
        return false
    }
}

