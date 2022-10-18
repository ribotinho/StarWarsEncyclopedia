//
//  FilmsVC.swift
//  StarWarsEncyclopedia
//
//  Created by Pau Ribot Pujolras on 18/10/22.
//

import UIKit

class FilmListVC: DataLoadingVC {
    
    var films : [Film] = []
    let filmsCollectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Films"
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFilms()
    }
    
    private func getFilms() {
        showLoadingView()
        Task {
            do{
                let results = try await NetworkManager.shared.get(type: FilmResult.self, for: Endpoint.films)
                films = results.results
                DispatchQueue.main.async {
                    self.dismissLoadingView()
                    self.filmsCollectionView.reloadData()
                }
            }catch{
                //show alert
                print("failed to get films")
            }
        }
    }
    
    private func configureCollectionView() {
        view.addSubview(filmsCollectionView)
        filmsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filmsCollectionView.delegate = self
        filmsCollectionView.dataSource = self
        filmsCollectionView.backgroundColor = .systemBackground
        filmsCollectionView.register(FilmCellView.self, forCellWithReuseIdentifier: FilmCellView.reuseID)
        
        NSLayoutConstraint.activate([
            filmsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            filmsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            filmsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            filmsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


extension FilmListVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        films.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCellView.reuseID, for: indexPath) as! FilmCellView
        cell.set(film: films[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 150)
    }
    
}
