//
//  FilmsVC.swift
//  StarWarsEncyclopedia
//
//  Created by Pau Ribot Pujolras on 18/10/22.
//

import UIKit

class FilmListVC: UIViewController {
    
    var films : [Film] = []
    let filmsTableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFilms()
    }
    
    private func getFilms() {
        Task {
            do{
                let results = try await NetworkManager.shared.get(type: FilmResult.self, for: Endpoint.films)
                films = results.results
                DispatchQueue.main.async {
                    self.filmsTableView.reloadData()
                }
            }catch{
                //show alert
                print("failed to get films")
            }
        }
    }
    
    private func configureTableView() {
        view.addSubview(filmsTableView)
        filmsTableView.translatesAutoresizingMaskIntoConstraints = false
        filmsTableView.delegate = self
        filmsTableView.dataSource = self
        filmsTableView.register(FilmCellView.self, forCellReuseIdentifier: FilmCellView.reuseID)
        filmsTableView.rowHeight = 150
        filmsTableView.separatorStyle = .none
        filmsTableView.backgroundColor = .clear
        
         
        NSLayoutConstraint.activate([
            filmsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            filmsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            filmsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            filmsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension FilmListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilmCellView.reuseID, for: indexPath) as! FilmCellView
        cell.set(film: films[indexPath.row])
        return cell
    }
}
