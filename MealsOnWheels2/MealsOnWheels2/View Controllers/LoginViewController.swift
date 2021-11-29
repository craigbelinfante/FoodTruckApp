//
//  LoginViewController.swift
//  MealsOnWheels2
//
//  Created by Craig Belinfante on 2/4/21.
//

import UIKit

enum LoginType {
    case signUp, signIn
}

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var loginController: LoginController?
    var loginType = LoginType.signUp
    
    @IBOutlet weak var signInSignUpSegmentedControl: UISegmentedControl!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    //have it change from sign up to image
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var showPasswordButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        loginButton.backgroundColor = .none
        loginButton.setImage(UIImage(named: "foodTruckrLogo-2"), for: .normal)
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        loginButton.backgroundColor = .none
//        loginButton.setImage(UIImage(named: "foodTruckrLogo-2"), for: .normal)
//    }
    
    @IBAction func showPasswordButtonTapped(_ sender: UIButton) {
        let toggled = passwordTextField.isSecureTextEntry
        if toggled {
            passwordTextField.isSecureTextEntry.toggle()
            showPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            passwordTextField.isSecureTextEntry.toggle()
            showPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    @IBAction func signInSegmentChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            loginType = .signUp
            loginButton.backgroundColor = .none
            loginButton.setImage(UIImage(named: "foodTruckrLogo-2"), for: .normal)
        } else {
            loginType = .signIn
            loginButton.backgroundColor = .none
            loginButton.setImage(UIImage(named: "foodTruckrLogo-2"), for: .normal)
            
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        userLoginType()
    }
    
    private func presentSignInSuccessAlert() {
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: "Sign Up Successful", message: "Please log in", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(alertAction)
            
            self.present(alertController, animated: true) {
                self.loginType = .signIn
                self.signInSignUpSegmentedControl.selectedSegmentIndex = 1
                self.loginButton.backgroundColor = .none
                self.loginButton.setImage(UIImage(named: "foodTruckrLogo-2"), for: .normal)
                //animation
                self.configureButton()
            }
        }
    }
    
    private func presentSignInFailedAlert() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Password was too short", message: "Try Again!", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(alertAction)
            
            self.present(alertController, animated: true) {
                self.loginType = .signUp
                self.signInSignUpSegmentedControl.selectedSegmentIndex = 0
            }
        }
    }
    
    private func userLoginType() {
        
        if let username = usernameTextField.text, !username.isEmpty,
           let password = passwordTextField.text, !password.isEmpty {
            
            let user = UserRep(username: username, password: password)
            
            switch loginType {
            case .signUp:
                loginController?.signUp(with: user, completion: { (result) in
                    do {
                        let success = try result.get()
                        if success {
                            self.presentSignInSuccessAlert()
                        }
                    } catch {
                        print("Error \(error)")
                    }
                })
            case .signIn:
                loginController?.signIn(with: user, completion: { (result) in
                    do {
                        let success = try result.get()
                        if success {
                            DispatchQueue.main.async {
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                    } catch {
                        if let error = error as? LoginController.NetworkError {
                            switch error {
                            case .noData, .noToken:
                                print("No data")
                            default:
                                print("Other Error")
                            }
                        }
                        
                    }
                })
            }
        }
    }
    
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = passwordTextField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
    //    newText.isValidPassword()
        updatePassword(newText)
        return true
    }
    
    private func configureButton() {
        guard let anticipationButton = loginButton else {return}
        
        anticipationButton.addTarget(self, action: #selector(anticipationButtonTapped), for: .touchUpInside)
    }
    
    @objc private func anticipationButtonTapped() {
        
        let animBlock = {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1) {
                self.loginButton.transform = CGAffineTransform(rotationAngle: .pi/8)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.2) {
                self.loginButton.transform = CGAffineTransform(rotationAngle: -.pi/8)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8) {
                self.loginButton.center = CGPoint(x: self.view.bounds.size.width + self.loginButton.bounds.size.width, y: self.view.center.y)
            }
        }
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: [], animations: animBlock, completion: nil)
    }
    
}

extension LoginViewController {
    
    private func updatePassword(_ password: String) {
        
        if  password.count < 8 {
            DispatchQueue.main.async {
                self.loginButton.isEnabled = false
            }
           // presentSignInFailedAlert()
        } else if password.count >= 8 {
            loginButton.isEnabled = true
        }
    }
}

// HELPER

extension String {
    func isValidPassword() -> Bool {
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)

        return passwordValidation.evaluate(with: self)
    }
}
