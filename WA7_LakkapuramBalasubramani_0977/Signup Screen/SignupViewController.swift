//
//  SignupViewController.swift
//  WA7_LakkapuramBalasubramani_0977
//
//  Created by Sideeshwaran Balasubramani on 11/2/23.
//

import UIKit
import Alamofire

class SignupViewController: UIViewController {
    
    let signupScreen = SignupScreenView()
    var x_access_token: String!
    
    let defaults = UserDefaults.standard
    
    override func loadView() {
        view = signupScreen
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        signupScreen.buttonLogin.addTarget(self, action: #selector(signupToLogin), for: .touchUpInside)
        signupScreen.buttonSignup.addTarget(self, action: #selector(onButtonSignupTapped), for: .touchUpInside)
    }
    
    
    @objc func signupToLogin() {
        navigationController?.popViewController(animated: true)
    }
    

    @objc func loginToSignup() {
        let signupViewController = SignupViewController()
        navigationController?.pushViewController(signupViewController, animated: true)
    }
    
    @objc func onButtonSignupTapped(){
        
        if let email = signupScreen.textFieldEmail.text,
           let name = signupScreen.textFieldName.text,
           let password = signupScreen.textFieldPassword.text{
            
            if name.isEmpty || email.isEmpty || password.isEmpty {
                showFieldEmptyErrorAlert()
            } else {
                if isValidEmail(email) {
                    signup(name: name, email: email, password: password)
                } else {
                    showMessageErrorAlert("Please enter a valid Email!")
                }
            }
            
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func showFieldEmptyErrorAlert() {
        let alert = UIAlertController(title: "Error!", message: "Some of the fields are empty! Please Recheck!!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func showMessageErrorAlert(_ messageText: String) {
        let alert = UIAlertController(title: "Error!", message: messageText, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func signup(name: String, email: String, password: String) {
        
        if let url = URL(string: APIConfigs.baseURL + "register") {
            AF.request(url, method: .post, parameters:
                        [
                            "name": name,
                            "email": email,
                            "password": password
                        ], encoder: URLEncodedFormParameterEncoder.default)
                .responseData(completionHandler: { response in
                
                    let status = response.response?.statusCode
                    
                    switch response.result{
                    case .success(let data):
                        
                        if let uwStatusCode = status {
                            switch uwStatusCode {
                            case 200...299:
                                
                                let decoder = JSONDecoder()
                                do{
                                    let receivedData = try decoder
                                        .decode(X_access_token.self, from: data)
                                    print(receivedData)
                                    
                                    if receivedData.auth {
                                        print(data)
                                        self.x_access_token = receivedData.token
                                        
                                        self.defaults.set(self.x_access_token, forKey: "x_access_token")
                                        self.showMessageErrorAlertwithAction(messageText: "Successfully registered user!")
                                        
                                    } else {
                                        self.showMessageErrorAlert("There ussername already exists!.")
                                        self.clearSignupFields()
                                    }
                                    
                                }catch{
                                    print("Couldnt decode JSON data")
                                }
                                break
                                
                            case 500:
                                self.showMessageErrorAlert("There was a problem registering the user.")
                                self.clearSignupFields()
                                break
                                
                            case 400...499:
                                print(data)
                                break
                                
                            default:
                                print(data)
                                break
                                
                            }
                        }
                        break
                        
                    case .failure(let error):
                        print(error)
                        break
                        
                    }
            })
        }
    }
    
    func clearSignupFields() {
        signupScreen.textFieldName.text = ""
        signupScreen.textFieldEmail.text = ""
        signupScreen.textFieldPassword.text = ""
    }
    
    func showMessageErrorAlertwithAction(messageText: String) {
        let alert = UIAlertController(title: "Success!", message: messageText, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) {action in
            
            let homeScreenViewController = HomeScreenViewController()
            var updatedViewControllers = self.navigationController?.viewControllers
            
            homeScreenViewController.x_access_token = self.x_access_token
                                                    
            updatedViewControllers?.removeAll()
            updatedViewControllers?.append(homeScreenViewController)
            
            self.clearSignupFields()
            self.navigationController?.setViewControllers(updatedViewControllers!, animated: true)
        })
        self.present(alert, animated: true)
    }

}
