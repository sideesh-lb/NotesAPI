//
//  ProfileViewController.swift
//  WA7_LakkapuramBalasubramani_0977
//
//  Created by Sideeshwaran Balasubramani on 11/2/23.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController {
    
    let profileScreen = ProfileView()
    var x_access_token: String!
    
    let defaults = UserDefaults.standard
    
    override func loadView() {
        view = profileScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        x_access_token = defaults.object(forKey: "x_access_token") as! String?
        if let x_access_token = x_access_token {
            
            getProfileData()
            profileScreen.buttonLogout.addTarget(self, action: #selector(logout), for: .touchUpInside)
        }
        
        // Do any additional setup after loading the view.
    }
    
    func getProfileData() {
        let headers: HTTPHeaders = [
            "x-access-token": self.x_access_token
        ]
        if let url = URL(string: APIConfigs.baseURL + "me") {
            AF.request(url, method: .get,
                       headers: headers
            ).responseData(completionHandler: {response in
                print(response.result)
                
                let status = response.response?.statusCode
                
                switch response.result {
                case .success(let data):
                    
                    if let uwStatusCode = status {
                        print(uwStatusCode)
                        switch uwStatusCode {
                            
                        case 200...299:
                            
                            let decoder = JSONDecoder()
                            do {
                                let recievedData = try decoder.decode(Profile.self, from: data)
                                
                                self.profileScreen.labelName.text = "Name: \(recievedData.name)"
                                self.profileScreen.labelEmail.text = "Email: \(recievedData.email)"
                                self.profileScreen.labelPassword.text = "Id: \(recievedData._id)"
                            } catch {
                                print("JSON couldn't be decoded.")
                            }
                            
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
                    //MARK: there was a network error...
                    print(error)
                    break

                }
            })
        }
    }
    
    
    @objc func logout() {
        let headers: HTTPHeaders = [
            "x-access-token": self.x_access_token
        ]
        if let url = URL(string: APIConfigs.baseURL + "logout") {
            AF.request(url, method: .get,
                       headers: headers
            ).responseData(completionHandler: {response in
                print(response.result)
                
                let status = response.response?.statusCode
                
                switch response.result {
                case .success(let data):
                    
                    if let uwStatusCode = status {
                        print(uwStatusCode)
                        switch uwStatusCode {
                            
                        case 200...299:
                            self.defaults.set(nil, forKey: "x_access_token")
                            let loginController = ViewController()
                            var updatedViewControllers = self.navigationController?.viewControllers
                                                                    
                            updatedViewControllers?.removeAll()
                            updatedViewControllers?.append(loginController)
                            
                            self.navigationController?.setViewControllers(updatedViewControllers!, animated: true)
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
                    //MARK: there was a network error...
                    print(error)
                    break

                }
            })
        }
    }
    
    @objc func onButtonLogoutClicked() {
        let logoutAlert = UIAlertController(title: "Logout", message: "Are you sure you want to Logout?", preferredStyle: .alert)
        
        let logoutAction = UIAlertAction(title: "Logout", style: .default) { (action) in
            self.logout()
        }
        
        logoutAlert.addAction(logoutAction)
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(logoutAlert, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
