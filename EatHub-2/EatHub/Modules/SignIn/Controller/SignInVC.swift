

import UIKit

class SignInVC: BaseViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnEye: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func actionShowPass(_ sender: UIButton) {
        self.btnEye.isSelected = !self.btnEye.isSelected
        self.tfPassword.isSecureTextEntry = !self.tfPassword.isSecureTextEntry
    }
    
    @IBAction func actionSignUp(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: StoryBoardName.SignUp, bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: SignUpVc.self))
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)

    }
    
    @IBAction func actionSignIn(_ sender: UIButton) {

        self.view.endEditing(true)
        if tfEmail.text?.isEmpty ?? true {
            CustomAlert.shared.showCustomAlert("", ConstantStrings.blankEmail, self.view)
        } else if !ValidationHelper.isValidEmail(testStr: tfEmail.text ?? "") {
            CustomAlert.shared.showCustomAlert("", ConstantStrings.invalidEmail, self.view)
        } else if tfPassword.text?.isEmpty ?? true {
            CustomAlert.shared.showCustomAlert("", ConstantStrings.blankEmail, self.view)
        } else {
            
            UserInfoDatabaseHelper.fetchUsersInformation { [weak self] arr in
                guard let `self` = self else { return }
                var userInfo: UserInfo?
                for user in arr {
                    if (user.email == self.tfEmail.text ?? "" && user.password == self.tfPassword.text ?? "") {
                        userInfo = user
                        break
                    }
                }
                if let userInfo = userInfo {
                    UserDefaults.standard.set(true, forKey: AppSharedData.shared.keySession)
                    AppSharedData.shared.userInfo = userInfo
                    AppSharedData.shared.saveToUserDefault(AppSharedData.shared.keyUserInfo, userInfo)
                    AppSharedData.shared.moveToDashboard()
                } else {
                    CustomAlert.shared.showCustomAlert(ConstantStrings.errorTitle, ConstantStrings.invaliEmailPassword, self.view)
                }
            }
        }
    }
}

extension SignInVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let length = (textField.text!.count) + string.count - range.length

        if textField == tfEmail {
            return length < 50
        } else if textField == tfPassword {
            return length < 20
        }
        return true
    }
}
