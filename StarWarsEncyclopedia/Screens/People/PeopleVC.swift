//
//  PeopleVC.swift
//  StarWarsEncyclopedia
//
//  Created by Pau Ribot Pujolras on 19/10/22.
//

import UIKit

class PeopleVC: DataLoadingVC {
    
    var character: People!
    var avatarImage = UIImageView()
    var nameLabel = UILabel()
    let stats = PeopleStat.allCases
    let tableView = UITableView(frame: .zero, style: .insetGrouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHeaderView()
        configureTableView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureHeaderView() {
        view.addSubviews([avatarImage, nameLabel])
        
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.text = character.name
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 30)
        nameLabel.textColor = .white
        
        avatarImage.image = character.getAvatar()
        avatarImage.layer.cornerRadius = 75
        avatarImage.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            avatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImage.heightAnchor.constraint(equalToConstant: 150),
            avatarImage.widthAnchor.constraint(equalToConstant: 150),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 25),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func configureTableView(){
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.systemYellow.cgColor
        tableView.layer.cornerRadius = 10
        tableView.register(StatViewCell.self, forCellReuseIdentifier: StatViewCell.reuseID)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

extension PeopleVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PeopleStat.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatViewCell.reuseID, for: indexPath) as! StatViewCell
        cell.set(right: character.value(for: PeopleStat.allCases[indexPath.row]), left: PeopleStat.allCases[indexPath.row].rawValue)
        return cell
    }
    

}
