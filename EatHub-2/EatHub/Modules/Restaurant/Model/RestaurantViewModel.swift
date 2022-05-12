

import Foundation
import UIKit

class RestaurantViewModel {
    
    var controller: RestaurantVc?
    var arrRestaurant: [Restaurant] =
    [
        Restaurant(name: "Quality Time", image: "Res_1"),
        Restaurant(name: "Time Square", image: "Res_2"),
        Restaurant(name: "Chit-Chat Cafe", image: "Res_3"),
        Restaurant(name: "Hotel Hilton", image: "Res_4")
    ]
    
    init(_ controller: RestaurantVc) {
        self.controller = controller
    }
}
