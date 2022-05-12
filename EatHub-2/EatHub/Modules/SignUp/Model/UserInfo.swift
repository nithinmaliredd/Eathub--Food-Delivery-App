//
//  UserInfo.swift
//  EatHub
//
//  Created by RWS Macbook on 21/04/22.
//

import Foundation

class UserInfo: NSObject, NSCoding {
    var firstName = ""
    var lastName = ""
    var email = ""
    var contactNumber = ""
    var password = ""
    
    func encode(with aCoder: NSCoder) {

        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(contactNumber, forKey: "contactNumber")
        aCoder.encode(password, forKey: "password")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {

        let firstName: String = aDecoder.decodeObject(forKey: "firstName") as? String ?? ""
        let lastName: String = aDecoder.decodeObject(forKey: "lastName") as? String ?? ""
        let email: String = aDecoder.decodeObject(forKey: "email") as? String ?? ""
        let contactNumber: String = aDecoder.decodeObject(forKey: "contactNumber") as? String ?? ""
        let password: String = aDecoder.decodeObject(forKey: "password") as? String ?? ""
        self.init(firstName: firstName, lastName: lastName, email: email, contactNumber: contactNumber, password: password)
    }
    
    override init() {}
    
    init(firstName: String, lastName: String, email: String, contactNumber: String, password: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.contactNumber = contactNumber
        self.password = password
    }
}

