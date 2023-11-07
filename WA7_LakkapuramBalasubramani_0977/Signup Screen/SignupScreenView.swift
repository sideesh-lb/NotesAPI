//
//  SignupScreenView.swift
//  WA7_LakkapuramBalasubramani_0977
//
//  Created by Sideeshwaran Balasubramani on 11/2/23.
//

import UIKit

class SignupScreenView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var labelNotesTittle: UILabel!
    var textFieldName: UITextField!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var buttonLogin: UIButton!
    var labelSignup: UILabel!
    var buttonSignup: UIButton!
    var viewsignupLabelButton: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        
        
        setupLabelNotesTitle()
        setuptextFieldName()
        setuptextFieldEmail()
        setuptextFieldPassword()
        setupbuttonLogin()
        setupviewsignupLabelButton()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabelNotesTitle() {
        labelNotesTittle = UILabel()
        labelNotesTittle.text = "Welcome to __Notes__ "
        labelNotesTittle.textColor = .yellow
        labelNotesTittle.font = UIFont.boldSystemFont(ofSize: 24)
        labelNotesTittle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelNotesTittle)
        
        
    }
    
    func setuptextFieldName() {
        textFieldName = UITextField()
        textFieldName.attributedPlaceholder = NSAttributedString(
            string: "Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textFieldName.borderStyle = .roundedRect
        textFieldName.layer.borderColor = UIColor.yellow.cgColor
        textFieldName.layer.borderWidth = 1.0
        textFieldName.layer.cornerRadius = 10.0
        textFieldName.textColor = .yellow
        textFieldName.backgroundColor = .black
        textFieldName.autocapitalizationType = .none
        textFieldName.keyboardType = .emailAddress
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldName)
    }
    
    func setuptextFieldEmail() {
        textFieldEmail = UITextField()
        textFieldEmail.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.layer.borderColor = UIColor.yellow.cgColor
        textFieldEmail.layer.borderWidth = 1.0
        textFieldEmail.layer.cornerRadius = 10.0
        textFieldEmail.textColor = .yellow
        textFieldEmail.backgroundColor = .black
        textFieldEmail.autocapitalizationType = .none
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldEmail)
    }
    
    func setuptextFieldPassword() {
        textFieldPassword = UITextField()
        textFieldPassword.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.layer.borderColor = UIColor.yellow.cgColor
        textFieldPassword.layer.borderWidth = 1.0
        textFieldPassword.layer.cornerRadius = 10.0
        textFieldPassword.textColor = .yellow
        textFieldPassword.backgroundColor = .black
        textFieldPassword.autocapitalizationType = .none
        textFieldPassword.keyboardType = .emailAddress
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPassword)
    }
    
    func setupbuttonLogin() {
        buttonSignup = UIButton()
        buttonSignup = UIButton(type: .system)
        buttonSignup.setTitle("Signup", for: .normal)
        buttonSignup.backgroundColor = .yellow
        buttonSignup.setTitleColor(.black, for: .normal)
        buttonSignup.layer.cornerRadius = 10.0
        buttonSignup.layer.borderWidth = 1.0
        buttonSignup.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        buttonSignup.layer.borderColor = UIColor.clear.cgColor
        buttonSignup.showsMenuAsPrimaryAction = true
        buttonSignup.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSignup)
    }
    
    func setupviewsignupLabelButton() {
        
        labelSignup = UILabel()
        labelSignup.text = "Already a user?"
        labelSignup.textColor = .yellow
        labelSignup.font = UIFont.systemFont(ofSize: 16)
        labelSignup.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelSignup)
        
        buttonLogin = UIButton()
        buttonLogin = UIButton(type: .system)
        buttonLogin.setTitle("Login", for: .normal)
        buttonLogin.backgroundColor = .black
        buttonLogin.setTitleColor(.yellow, for: .normal)
        buttonLogin.layer.cornerRadius = 10.0
        buttonLogin.layer.borderWidth = 1.0
        buttonLogin.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        buttonLogin.layer.borderColor = UIColor.yellow.cgColor
        buttonLogin.showsMenuAsPrimaryAction = true
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonLogin)
    }
    
    func initConstraints() {
        
        let buttonLogintext = buttonLogin.title(for: .normal) ?? ""
        let buttonLogintextSize = (buttonLogintext as NSString).size(withAttributes: [NSAttributedString.Key.font: buttonLogin.titleLabel?.font ?? UIFont.systemFont(ofSize: 18)])
        
        let butttonSignuptext = buttonSignup.title(for: .normal) ?? ""
        let butttonSignuptextSize = (butttonSignuptext as NSString).size(withAttributes: [NSAttributedString.Key.font: buttonLogin.titleLabel?.font ?? UIFont.systemFont(ofSize: 16)])
        
        NSLayoutConstraint.activate([
            labelNotesTittle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            labelNotesTittle.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            textFieldName.topAnchor.constraint(equalTo: labelNotesTittle.bottomAnchor, constant: 50),
            textFieldName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            textFieldName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -60),
            
            textFieldEmail.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 20),
            textFieldEmail.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            textFieldEmail.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -60),
            
            textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 20),
            textFieldPassword.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            textFieldPassword.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -60),
            
            buttonSignup.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 40),
            buttonSignup.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonSignup.widthAnchor.constraint(equalToConstant: butttonSignuptextSize.width + 20),
            
            labelSignup.topAnchor.constraint(equalTo: buttonSignup.bottomAnchor, constant: 40),
            labelSignup.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonLogin.topAnchor.constraint(equalTo: labelSignup.bottomAnchor, constant: 10),
            buttonLogin.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonLogin.widthAnchor.constraint(equalToConstant: buttonLogintextSize.width + 20),
            
        ])
    }

}
