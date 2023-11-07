//
//  AddNoteView.swift
//  WA7_LakkapuramBalasubramani_0977
//
//  Created by Sideeshwaran Balasubramani on 11/2/23.
//

import UIKit

class AddNoteView: UIView {

    var textFieldNote: UITextField!
    var buttonLogin: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        
        
        setuptextViewNote()
        setupbuttonLogin()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setuptextViewNote() {
        textFieldNote = UITextField()
        textFieldNote.attributedPlaceholder = NSAttributedString(
            string: "Add your note here...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textFieldNote.borderStyle = .roundedRect
        textFieldNote.layer.borderColor = UIColor.yellow.cgColor
        textFieldNote.layer.borderWidth = 1.0
        textFieldNote.layer.cornerRadius = 10.0
        textFieldNote.textColor = .yellow
        textFieldNote.backgroundColor = .black
        textFieldNote.autocapitalizationType = .none
        textFieldNote.keyboardType = .emailAddress
        textFieldNote.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldNote)
    }
    
    func setupbuttonLogin() {
        buttonLogin = UIButton()
        buttonLogin = UIButton(type: .system)
        buttonLogin.setTitle("Save", for: .normal)
        buttonLogin.backgroundColor = .yellow
        buttonLogin.setTitleColor(.black, for: .normal)
        buttonLogin.layer.cornerRadius = 10.0
        buttonLogin.layer.borderWidth = 1.0
        buttonLogin.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        buttonLogin.layer.borderColor = UIColor.clear.cgColor
        buttonLogin.showsMenuAsPrimaryAction = true
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonLogin)
    }
    
    func initConstraints() {
        let buttonLogintext = buttonLogin.title(for: .normal) ?? ""
        let buttonLogintextSize = (buttonLogintext as NSString).size(withAttributes: [NSAttributedString.Key.font: buttonLogin.titleLabel?.font ?? UIFont.systemFont(ofSize: 18)])
        
        NSLayoutConstraint.activate([
            textFieldNote.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            textFieldNote.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            textFieldNote.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            buttonLogin.topAnchor.constraint(equalTo: textFieldNote.bottomAnchor, constant: 20),
            buttonLogin.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonLogin.widthAnchor.constraint(equalToConstant: buttonLogintextSize.width + 20),
        ])
    }

}
