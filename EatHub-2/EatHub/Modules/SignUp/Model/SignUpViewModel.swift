//
//  SignUpViewModel.swift
//  EatHub
//
//  Created by RWS Macbook on 22/04/22.
//

import Foundation
import UIKit

class SignUpViewModel {
    
    var controller: SignUpVc?
    
    init(_ controller: SignUpVc) {
        self.controller = controller
    }
    
    func processToCreateNewUser() {
        UserInfoDatabaseHelper.fetchUsersInformation { [weak self] arr in
            guard let `self` = self else { return }
            var userAlreadyExist = false
            
            for x in arr {
                if x.email == self.controller?.tfEmail.text ?? "" {
                    userAlreadyExist = true
                    break
                }
            }
            
            if userAlreadyExist {
                CustomAlert.shared.showCustomAlert(ConstantStrings.errorTitle, ConstantStrings.emailAlreadyExist, self.controller?.view ?? UIView())
            } else {
                let userInfo = UserInfo(firstName: self.controller?.tfName.text ?? "", lastName: self.controller?.tfLastName.text ?? "", email: self.controller?.tfEmail.text ?? "", contactNumber: self.controller?.tfContactNum.text ?? "", password: self.controller?.tfPswrd.text ?? "")
                UserInfoDatabaseHelper.addNewUser(user: userInfo) { [weak self] _ in
                    guard let `self` = self else { return }
                    CustomAlert.shared.showCustomAlert(ConstantStrings.successTitle, ConstantStrings.accountCreatedSuccessfully, self.controller?.view ?? UIView()) {
                        self.controller?.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
}
