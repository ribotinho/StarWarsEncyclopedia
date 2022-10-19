//
//  PeopleVC.swift
//  StarWarsEncyclopedia
//
//  Created by Pau Ribot Pujolras on 18/10/22.
//

import UIKit

class PeopleListVC: DataLoadingVC {
    
    var peopleResult : PeopleResult?
    var people : [People] = []
    var filteredPeople : [People] = []
    
    var peopleTableView = UITableView()
    var loadButton = UIButton()
    var searchBar = UISearchBar()
    
    var tablieViewBottomConstraint = NSLayoutConstraint()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "People List"
        view.backgroundColor = Colors.backgroundColor
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPeople()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        peopleResult = nil
        people.removeAll()
    }
    
    private func getPeople(){
        showLoadingView()
        Task{
            do{
                peopleResult = try await NetworkManager.shared.get(type: PeopleResult.self, for: Endpoint.people.rawValue)
                people.append(contentsOf: peopleResult?.results ?? [])
                if peopleResult?.next == nil { loadButton.isHidden = true }
                DispatchQueue.main.async {
                    self.dismissLoadingView()
                    self.peopleTableView.reloadData()
                }
            }catch{
                print("Could not load people")
            }
        }
    }
    
    
    private func configure(){
        view.addSubviews([peopleTableView, loadButton, searchBar])
        peopleTableView.translatesAutoresizingMaskIntoConstraints = false
        loadButton.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        peopleTableView.delegate = self
        peopleTableView.dataSource = self
        peopleTableView.backgroundColor = .black
        peopleTableView.layer.cornerRadius = 10
        peopleTableView.showsVerticalScrollIndicator = false
        peopleTableView.separatorStyle = .none
        peopleTableView.register(PeopleCellView.self, forCellReuseIdentifier: PeopleCellView.reuseID)
        
        loadButton.backgroundColor = .systemYellow
        loadButton.setTitle("Load more", for: .normal)
        loadButton.setTitleColor(.black, for: .normal)
        loadButton.layer.cornerRadius = 10
        loadButton.addTarget(self, action: #selector(loadButtonTapped(_:)), for: .touchUpInside)
        
        searchBar.barTintColor = .black
        searchBar.tintColor = .systemYellow
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
        searchBar.delegate = self
        
        NSLayoutConstraint.activate([
            loadButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            loadButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loadButton.heightAnchor.constraint(equalToConstant: 50),
            
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            peopleTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            peopleTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            peopleTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        tablieViewBottomConstraint = peopleTableView.bottomAnchor.constraint(equalTo: loadButton.topAnchor, constant: -20)
        tablieViewBottomConstraint.isActive = true
    }
    
    private func updateTableViewBottomConstraint(){
        tablieViewBottomConstraint.isActive = false
        tablieViewBottomConstraint = peopleTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        tablieViewBottomConstraint.isActive = true
    }
    
    @objc func loadButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
        
        guard let results = peopleResult else { return }
        guard let url = results.next else { return }
        
        showLoadingView()
        Task{
            do{
                peopleResult = try await NetworkManager.shared.get(type: PeopleResult.self, for: url)
                people.append(contentsOf: peopleResult?.results ?? [])
                if peopleResult?.next == nil {
                    loadButton.isHidden = true
                    self.updateTableViewBottomConstraint()
                }
                DispatchQueue.main.async {
                    self.dismissLoadingView()
                    UIView.animate(withDuration: 1.0) {
                        self.peopleTableView.layoutIfNeeded()
                    }
                    self.peopleTableView.reloadData()
                }
            }catch{
                print("Could not load more people")
            }
        }
    }
}

extension PeopleListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPeople.count == 0 ? people.count : filteredPeople.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PeopleCellView.reuseID, for: indexPath) as! PeopleCellView
        cell.set(people: filteredPeople.count == 0 ? people[indexPath.row] : filteredPeople[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

extension PeopleListVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPeople = people.filter({$0.name.contains(searchText)})
        DispatchQueue.main.async {
            self.peopleTableView.reloadData()
        }
    }
}
