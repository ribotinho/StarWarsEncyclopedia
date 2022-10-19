//
//  FilmVC.swift
//  StarWarsEncyclopedia
//
//  Created by Pau Ribot Pujolras on 18/10/22.
//

import UIKit

class FilmVC: DataLoadingVC {

    var film : Film!
    var characters : [People] = []
    var generalInfoView = UIView(frame: .zero)
    var descriptionView = UIView(frame: .zero)
    let charactersView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = Colors.backgroundColor
        title = film.title
        configure()
        getFilmCharacters()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        characters.removeAll()
    }
    
    init(film: Film) {
        super.init(nibName: nil, bundle: nil)
        self.film = film
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getFilmCharacters(){
        Task {
            for character in self.film.characters {
                do{
                    let character = try await NetworkManager.shared.get(type: People.self, for: character)
                    characters.append(character)
                    DispatchQueue.main.async {
                        self.charactersView.reloadData()
                    }
                }catch {
                    //show alert or text in the charactersView?
                    print("Error getting characters for \(film.title)")
                }
            }
        }
    }
    
    private func configure(){
        view.addSubviews([generalInfoView, descriptionView, charactersView])
        
        generalInfoView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        charactersView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            generalInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            generalInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            generalInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            generalInfoView.heightAnchor.constraint(equalToConstant: 200),
            
            descriptionView.topAnchor.constraint(equalTo: generalInfoView.bottomAnchor, constant: 25),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            descriptionView.heightAnchor.constraint(equalToConstant: 200),
            
            charactersView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 40),
            charactersView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            charactersView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            charactersView.heightAnchor.constraint(equalToConstant: 150),
        ])
        
        configureGeneralInfoView()
        configureDescriptionView()
        configurecharactersView()
    }
    
    private func configureGeneralInfoView(){
        let imageView = UIImageView(image: UIImage(named: "episode_\(film.episodeId)"))
        let episodeLabel = UILabel(frame: .zero)
        let directorLabel = UILabel(frame: .zero)
        let producerLabel = UILabel(frame: .zero)
        let dateLabel = UILabel(frame: .zero)
        generalInfoView.addSubviews([imageView, episodeLabel, directorLabel, dateLabel, producerLabel])
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        episodeLabel.translatesAutoresizingMaskIntoConstraints  = false
        directorLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        producerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        episodeLabel.text = "Episode \(film.episodeId)"
        directorLabel.text = "Director: \(film.director)"
        dateLabel.text = "Date: \(film.releaseDate)"
        producerLabel.text = "Producer \(film.producer)"
        
        episodeLabel.font = UIFont.systemFont(ofSize: 12)
        directorLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        producerLabel.font = UIFont.systemFont(ofSize: 12)
        
        episodeLabel.textColor = .white
        directorLabel.textColor = .white
        dateLabel.textColor = .white
        producerLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: generalInfoView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: generalInfoView.leadingAnchor, constant: 8),
            imageView.widthAnchor.constraint(equalToConstant: 125),
            imageView.heightAnchor.constraint(equalToConstant: 175),
            
            episodeLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            episodeLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            episodeLabel.trailingAnchor.constraint(equalTo: generalInfoView.trailingAnchor, constant: -8),
            episodeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            directorLabel.topAnchor.constraint(equalTo: episodeLabel.bottomAnchor, constant: 8),
            directorLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            directorLabel.trailingAnchor.constraint(equalTo: generalInfoView.trailingAnchor, constant: -8),
            directorLabel.heightAnchor.constraint(equalToConstant: 20),
            
            producerLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 8),
            producerLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            producerLabel.trailingAnchor.constraint(equalTo: generalInfoView.trailingAnchor, constant: -8),
            producerLabel.heightAnchor.constraint(equalToConstant: 20),
            
            dateLabel.topAnchor.constraint(equalTo: producerLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: generalInfoView.trailingAnchor, constant: -8),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
    }
    
    private func configureDescriptionView(){
        descriptionView.backgroundColor = Colors.backgroundColor
        descriptionView.layer.cornerRadius = 10
        
        let topLabel = UILabel()
        topLabel.text = "Opening Crawl"
        topLabel.textColor = UIColor.systemYellow
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        let bottomLabel = UILabel()
        bottomLabel.text = film.openingCrawl.replacingOccurrences(of: "\r\n\r\n", with: "\n\n").replacingOccurrences(of: "\r\n", with: " ")
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.font = UIFont.systemFont(ofSize: 12.0)
        bottomLabel.numberOfLines = 0
        bottomLabel.sizeToFit()
        bottomLabel.textColor = .white
        
        descriptionView.addSubviews([topLabel, bottomLabel])
        
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: -30),
            topLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 8),
            topLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -8),
            topLabel.heightAnchor.constraint(equalToConstant: 25),
            
            bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 8),
            bottomLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 8),
            bottomLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -8),
            bottomLabel.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: -8)
        ])
    }
    
    private func configurecharactersView(){
        
        let topLabel = UILabel()
        topLabel.text = "Main characters"
        topLabel.textColor = .systemYellow
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        view.addSubviews([topLabel])
        
        charactersView.layer.cornerRadius = 10
        charactersView.backgroundColor = Colors.backgroundColor
        charactersView.showsHorizontalScrollIndicator = false
        charactersView.register(AvatarCellView.self, forCellWithReuseIdentifier: AvatarCellView.reuseID)
        charactersView.delegate = self
        charactersView.dataSource = self
        
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: charactersView.topAnchor, constant: -30),
            topLabel.leadingAnchor.constraint(equalTo: charactersView.leadingAnchor, constant: 8),
            topLabel.trailingAnchor.constraint(equalTo: charactersView.trailingAnchor, constant: -8),
            topLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}


extension FilmVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvatarCellView.reuseID, for: indexPath) as! AvatarCellView
        cell.set(character: characters[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destination = PeopleVC()
        destination.character = characters[indexPath.row]
        navigationController?.pushViewController(destination, animated: true)
    }
}
