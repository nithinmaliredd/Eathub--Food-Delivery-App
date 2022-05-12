//
//  FoodItem.swift
//  EatHub
//
//  Created by RWS Macbook on 18/04/22.
//

import Foundation
import UIKit

class FoodItem {
    var name = ""
    var image = ""
    var description = ""
    var rating: Double = 0.0
    var quantity = 0
    var selected = false
    var freeDelivery = false
    var price: Double = 0.0
    var id: Int = 0

    init(name: String, image: String, quantity: Int, selected: Bool, freeDelivery: Bool, rating: Double, description: String, price: Double, id: Int) {
        self.name = name
        self.image = image
        self.quantity = quantity
        self.selected = selected
        self.freeDelivery = freeDelivery
        self.rating = rating
        self.description = description
        self.price = price
        self.id = id
    }
    init() {}
}
