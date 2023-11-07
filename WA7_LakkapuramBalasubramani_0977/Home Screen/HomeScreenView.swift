//
//  HomeScreenView.swift
//  WA7_LakkapuramBalasubramani_0977
//
//  Created by Sideeshwaran Balasubramani on 11/2/23.
//

import UIKit

class HomeScreenView: UIView {
    
    var tableViewNotes: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        
        
        setupTableViewNotes()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableViewNotes() {
        tableViewNotes = UITableView()
        tableViewNotes.separatorStyle = .none
        tableViewNotes.backgroundColor = .black
        tableViewNotes.register(NotesTableViewCell.self, forCellReuseIdentifier: "notes")
        tableViewNotes.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewNotes)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            tableViewNotes.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            tableViewNotes.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewNotes.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableViewNotes.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            
            ])
    }

}
