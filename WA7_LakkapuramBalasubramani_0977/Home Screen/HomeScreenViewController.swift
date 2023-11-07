//
//  HomeScreenViewController.swift
//  WA7_LakkapuramBalasubramani_0977
//
//  Created by Sideeshwaran Balasubramani on 11/2/23.
//

import UIKit
import Alamofire

class HomeScreenViewController: UIViewController {
    
    let homeScreen = HomeScreenView()
    var x_access_token: String!
    
    let notificationCenter = NotificationCenter.default
    
    var notes = [Note]()
    
    let defaults = UserDefaults.standard
    
    override func loadView() {
        view = homeScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Notes"
        x_access_token = defaults.object(forKey: "x_access_token") as! String?
        if let x_access_token = x_access_token {
            print(x_access_token, "Home")
            
            homeScreen.tableViewNotes.dataSource = self
            homeScreen.tableViewNotes.delegate = self
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onButtonAddNoteTapped))
            navigationItem.rightBarButtonItem?.tintColor = .yellow
            
            var profileImage = UIImage(systemName: "person.crop.circle")
            profileImage = profileImage?.withTintColor(.yellow, renderingMode: .alwaysOriginal)
            
            let profileImageView = UIImageView(image: profileImage)
            profileImageView.isUserInteractionEnabled = true
            profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onButtonProfileTapped)))
            

            let leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
            leftBarButtonItem.target = self
            leftBarButtonItem.action = #selector(onButtonProfileTapped)

            navigationItem.leftBarButtonItem = leftBarButtonItem
            
            notificationCenter.addObserver(
                        self,
                        selector: #selector(reloadNotes(notification:)),
                        name: Notification.Name("NotesReload"),
                        object: nil)
            
            getAllNotes()
        }
    }
    
    @objc func reloadNotes(notification: Notification) {
        getAllNotes()
    }
    
    func getAllNotes() {
        let headers: HTTPHeaders = [
            "x-access-token": self.x_access_token
        ]
        if let url = URL(string: APIConfigs.baseNotesURL + "getall") {
            AF.request(url, method: .get,
                       headers: headers).responseData(completionHandler: { response in
                print(response.result)
                
                let status = response.response?.statusCode
                
                switch response.result {
                case .success(let data):
                    
                    if let uwStatusCode = status {
                        print(uwStatusCode)
                        switch uwStatusCode {
                            
                        case 200...299:
                            
                            self.notes.removeAll()
                            let decoder = JSONDecoder()
                            do {
                                let recievedData = try decoder.decode(Notes.self, from: data)
                                
                                for item in recievedData.notes {
                                    self.notes.append(item)
                                }
                                self.homeScreen.tableViewNotes.reloadData()
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
    
    
    
    @objc func onButtonAddNoteTapped() {
        let addNoteController = AddNoteViewController()
        navigationController?.pushViewController(addNoteController, animated: true)
    }
    
    @objc func onButtonProfileTapped() {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    

    
}

extension HomeScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notes", for: indexPath) as! NotesTableViewCell
        cell.labelName.text = self.notes[indexPath.row].text
        
        let buttonOptions = UIButton(type: .system)
        buttonOptions.sizeToFit()
        buttonOptions.showsMenuAsPrimaryAction = true
            
        buttonOptions.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
            
        buttonOptions.menu = UIMenu(title: "Delete?",
                                    children: [
                                        UIAction(title: "Delete",handler: {(_) in
                                            self.deleteSelectedFor(note: self.notes[indexPath.row])
                                        })
                                    ])
        cell.accessoryView = buttonOptions
        
        return cell
        
    }
    
    func deleteSelectedFor(note: Note) {
        let deleteAlert = UIAlertController(title: "Delete Note", message: "Are you sure you want to delete this Note?", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (action) in
            self.deleteNote(id: note._id)
        }
        
        deleteAlert.addAction(deleteAction)
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(deleteAlert, animated: true)
    }
    
    func deleteNote(id: String) {
        let headers: HTTPHeaders = [
            "x-access-token": self.x_access_token
        ]
        if let url = URL(string: APIConfigs.baseNotesURL + "delete") {
            AF.request(url, method: .post,
                       parameters: [
                        "id": id
                       ],
                       headers: headers).responseData(completionHandler: {response in
                let status = response.response?.statusCode
                
                switch response.result {
                case .success(let data):
                    
                    if let uwStatusCode = status {
                        print(uwStatusCode)
                        switch uwStatusCode {
                            
                        case 200...299:
                            self.showMessageErrorAlertwithAction(messageText: "Successfully deleted Note!")
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        getContactDetails(name: self.contactNames[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
