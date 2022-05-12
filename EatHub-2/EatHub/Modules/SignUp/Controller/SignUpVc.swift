//
//  SignUpVc.swift
//  EatHub
//
//  Created by RWS Macbook on 21/04/22.
//

import UIKit

class SignUpVc: BaseViewController {
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPswrd: UITextField!
    @IBOutlet weak var tfCnfrmPswrd: UITextField!
    @IBOutlet weak var tfContactNum: UITextField!
    @IBOutlet weak var btnCheckbox: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnTerm_Services: UIButton!
    @IBOutlet weak var btnShowHidePassword: UIButton!
    @IBOutlet weak var btnShowConfrmHidePassword: UIButton!
    
    var isCheckboxSelected: Bool = false
    var viewModel: SignUpViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = .init(self)
        self.btnTerm_Services.underline()
    }

    @IBAction func btnShowPswrd(_ sender: Any) {
           self.btnShowHidePassword.isSelected = !self.btnShowHidePassword.isSelected
           self.tfPswrd.isSecureTextEntry = !self.tfPswrd.isSecureTextEntry
    }
    
    @IBAction func btnShowConfrmPswrd(_ sender: Any) {
           self.btnShowConfrmHidePassword.isSelected = !self.btnShowConfrmHidePassword.isSelected
           self.tfCnfrmPswrd.isSecureTextEntry = !self.tfCnfrmPswrd.isSecureTextEntry
    }
    
    @IBAction func btnSignInClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSignupClick(_ sender: Any) {
        
        self.view.endEditing(true)
        
        if tfName.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            CustomAlert.shared.showCustomAlert(ConstantStrings.errorTitle, ConstantStrings.blankFirstName, self.view)
            
        } else if tfLastName.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            
            CustomAlert.shared.showCustomAlert(ConstantStrings.errorTitle, ConstantStrings.blankLastName, self.view)
            
        } else if tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            
            CustomAlert.shared.showCustomAlert(ConstantStrings.errorTitle, ConstantStrings.blankEmail, self.view)
            
        } else if !ValidationHelper.isValidEmail(testStr: tfEmail.text ?? "") {
            
            CustomAlert.shared.showCustomAlert(ConstantStrings.errorTitle, ConstantStrings.invalidEmail, self.view)

        } else if tfContactNum.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            
            CustomAlert.shared.showCustomAlert(ConstantStrings.errorTitle, ConstantStrings.blankContactNumber, self.view)
            
        } else if tfPswrd.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            
            CustomAlert.shared.showCustomAlert(ConstantStrings.errorTitle, ConstantStrings.blankPassword, self.view)
            
        } else if (tfPswrd.text ?? "" != tfCnfrmPswrd.text ?? "") {
            
            CustomAlert.shared.showCustomAlert(ConstantStrings.errorTitle, ConstantStrings.passwordMismatch, self.view)
            
        } else if !isCheckboxSelected {
            
            CustomAlert.shared.showCustomAlert(ConstantStrings.errorTitle, ConstantStrings.acceptTermsCondition, self.view)

        } else {
            viewModel.processToCreateNewUser()
        }
    }
    
    @IBAction func btnCheckboxAction(_ sender: Any) {
        if self.isCheckboxSelected {
            self.isCheckboxSelected = false
            self.btnCheckbox.layer.cornerRadius = 2
            self.btnCheckbox.borderColor = UIColor(named: "subHeaderColor")
            self.btnCheckbox.setImage(UIImage(named: ""), for: .normal)
        } else {
            self.isCheckboxSelected = true
            self.btnCheckbox.borderColor = UIColor.white
            self.btnCheckbox.setImage(UIImage(named: "checkbox"), for: .normal)
        }
    }
}


extension SignUpVc: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let length = (textField.text!.count) + string.count - range.length
        
        switch textField {
        case tfName, tfLastName, tfPswrd, tfCnfrmPswrd:
            return length <= 20
        case tfEmail:
            return length <= 50
        case tfContactNum:
            return length <= 10
        default:
            break
        }
        return true
    }
}
