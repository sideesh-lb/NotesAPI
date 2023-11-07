//
//  AddNoteViewController.swift
//  WA7_LakkapuramBalasubramani_0977
//
//  Created by Sideeshwaran Balasubramani on 11/2/23.
//

import UIKit
import Alamofire

class AddNoteViewController: UIViewController {
    
    var x_access_token: String!
    let notificationCenter = NotificationCenter.default
    let defaults = UserDefaults.standard
    
    let addNoteScreen = AddNoteView()
    
    override func loadView() {
        view = addNoteScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Add a Note"
        x_access_token = defaults.object(forKey: "x_access_token") as! String?
        if let x_access_token = x_access_token {
            addNoteScreen.buttonLogin.addTarget(self, action: #selector(onButtonSaveClicked), for: .touchUpInside)
        }
    }
    
    @objc func onButtonSaveClicked() {
        if let text = addNoteScreen.textFieldNote.text {
            if !(text.isEmpty) {
                addNote(text: text)
            } else {
                showFieldEmptyErrorAlert()
            }
        }
    }
    
    func addNote(text: String) {
        let headers: HTTPHeaders = [
            "x-access-token": self.x_access_token
        ]
        if let url = URL(string: APIConfigs.baseNotesURL + "post") {
            AF.request(url, method: .post,
                       parameters: [
                        "text": text
                       ],
                       headers: headers).responseData(completionHandler: {response in
                let status = response.response?.statusCode
                
                switch response.result {
                case .success(let data):
                    
                    if let uwStatusCode = status {
                        print(uwStatusCode)
                        switch uwStatusCode {
                            
                        case 200...299:
                            self.showMessageErrorAlertwithAction(messageText: "Successfully added Note!")
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
    
    func showMessageErrorAlertwithAction(messageText: String) {
        let alert = UIAlertController(title: "Success!", message: messageText, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) {action in
            self.notificationCenter.post(
                name: Notification.Name("NotesReload"),
                object: nil)
            self.navigationController?.popViewController(animated: true)
        })
        self.present(alert, animated: true)
    }
    
    func showFieldEmptyErrorAlert() {
        let alert = UIAlertController(title: "Error!", message: "Some of the fields are empty! Please Recheck!!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
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
