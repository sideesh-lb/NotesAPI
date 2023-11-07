//
//  ProfileView.swift
//  WA7_LakkapuramBalasubramani_0977
//
//  Created by Sideeshwaran Balasubramani on 11/2/23.
//

import UIKit

class ProfileView: UIView {

    var labelName: UILabel!
    var labelEmail: UILabel!
    var labelPassword: UILabel!
    
    var buttonLogout: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        
        
        setuplabelName()
        setuplabelEmail()
        setuplabelPassword()
        setupbuttonLogout()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setuplabelName() {
        labelName = UILabel()
        labelName.textColor = .yellow
        labelName.layer.borderColor = UIColor.yellow.cgColor
        labelName.font = UIFont.systemFont(ofSize: 18)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }
    
    func setuplabelEmail() {
        labelEmail = UILabel()
        labelEmail.textColor = .yellow
        labelEmail.font = UIFont.systemFont(ofSize: 18)
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelEmail)
    }
    
    func setuplabelPassword() {
        labelPassword = UILabel()
        labelPassword.textColor = .yellow
        labelPassword.font = UIFont.systemFont(ofSize: 18)
        labelPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelPassword)
    }
    
    func setupbuttonLogout() {
        buttonLogout = UIButton()
        buttonLogout = UIButton(type: .system)
        buttonLogout.setTitle("Logout", for: .normal)
        buttonLogout.backgroundColor = .yellow
        buttonLogout.setTitleColor(.black, for: .normal)
        buttonLogout.layer.cornerRadius = 10.0
        buttonLogout.layer.borderWidth = 1.0
        buttonLogout.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        buttonLogout.layer.borderColor = UIColor.clear.cgColor
        buttonLogout.showsMenuAsPrimaryAction = true
        buttonLogout.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonLogout)
    }
    
    func initConstraints() {
        
        let buttonLogouttext = buttonLogout.title(for: .normal) ?? ""
        let buttonLogouttextSize = (buttonLogouttext as NSString).size(withAttributes: [NSAttributedString.Key.font: buttonLogout.titleLabel?.font ?? UIFont.systemFont(ofSize: 18)])
        
        NSLayoutConstraint.activate([
            labelName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            labelName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 10),
            labelEmail.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelPassword.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 10),
            labelPassword.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            buttonLogout.topAnchor.constraint(equalTo: labelPassword.bottomAnchor, constant: 50),
            buttonLogout.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonLogout.widthAnchor.constraint(equalToConstant: buttonLogouttextSize.width + 20),
        ])
    }

}
