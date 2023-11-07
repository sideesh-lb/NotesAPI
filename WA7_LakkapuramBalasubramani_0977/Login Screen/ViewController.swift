//
//  ViewController.swift
//  WA7_LakkapuramBalasubramani_0977
//
//  Created by Sideeshwaran Balasubramani on 11/1/23.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    let loginScreen = LoginScreenView()
    
    var x_access_token: String!
    
    let defaults = UserDefaults.standard
    
    override func loadView() {
        view = loginScreen
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let navigationBar = navigationController?.navigationBar {
            let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.yellow]
            navigationBar.titleTextAttributes = textAttributes
        }
        
//        self.defaults.set(nil, forKey: "x_access_token")
        x_access_token = defaults.object(forKey: "x_access_token") as! String?
        
        
        if let x_access_token = x_access_token {
            let homeScreenViewController = HomeScreenViewController()
            var updatedViewControllers = self.navigationController?.viewControllers
            
            homeScreenViewController.x_access_token = x_access_token
                                                    
            updatedViewControllers?.removeAll()
            updatedViewControllers?.append(homeScreenViewController)
            
            self.navigationController?.setViewControllers(updatedViewControllers!, animated: true)
        } else {
            loginScreen.buttonLogin.addTarget(self, action: #selector(onButtonLoginTapped), for: .touchUpInside)
            loginScreen.buttonSignup.addTarget(self, action: #selector(loginToSignup), for: .touchUpInside)
        }
    }
    
    @objc func loginToSignup() {
        let signupViewController = SignupViewController()
        navigationController?.pushViewController(signupViewController, animated: true)
    }
    
    @objc func onButtonLoginTapped(){
        
        if let email = loginScreen.textFieldEmail.text,
           let password = loginScreen.textFieldPassword.text{
            
            if email.isEmpty || password.isEmpty {
                showFieldEmptyErrorAlert()
            } else {
                if isValidEmail(email) {
                    login(email: email, password: password)
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
    
    func login(email: String, password: String) {
        
        if let url = URL(string: APIConfigs.baseURL + "login") {
            AF.request(url, method: .post, parameters:
                        [
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
                                        print("Login Successful")
                                        
                                        let homeScreenViewController = HomeScreenViewController()
                                        var updatedViewControllers = self.navigationController?.viewControllers
                                        
                                        homeScreenViewController.x_access_token = self.x_access_token
                                                                                
                                        updatedViewControllers?.removeAll()
                                        updatedViewControllers?.append(homeScreenViewController)
                                        
                                        self.clearLoginFields()
                                        self.navigationController?.setViewControllers(updatedViewControllers!, animated: true)
                                        
                                    } else {
                                        self.showMessageErrorAlert("Password Incorrect! Enter the correct password!")
                                        self.loginScreen.textFieldPassword.text = ""
                                    }
                                    
                                }catch{
                                    print("Couldnt decode JSON data")
                                }
                                break
                                
                            case 401:
                                let decoder = JSONDecoder()
                                do{
                                    let receivedData = try decoder
                                        .decode(X_access_token.self, from: data)
                                    print(receivedData)
                                    
                                    self.x_access_token = nil
                                    self.showMessageErrorAlert("Password Incorrect! Enter the correct password!")
                                    self.loginScreen.textFieldPassword.text = ""
                                    
                                }catch{
                                    print("Couldnt decode JSON data")
                                }
                                break
                                
                            case 400...499:
                                print(data)
                                self.x_access_token = nil
                                self.showMessageErrorAlert("No such user found!")
                                self.clearLoginFields()
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
    
    func clearLoginFields() {
        loginScreen.textFieldEmail.text = ""
        loginScreen.textFieldPassword.text = ""
    }
    


}

