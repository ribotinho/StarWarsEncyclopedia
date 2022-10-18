//
//  FilmVC.swift
//  StarWarsEncyclopedia
//
//  Created by Pau Ribot Pujolras on 18/10/22.
//

import UIKit

class FilmVC: DataLoadingVC {

    var film : Film!
    var generalInfoView: UIView!
    var descriptionView: UIView!
    var charactersView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .systemBackground
        title = film.title
        configure()
    }
    
    init(film: Film) {
        super.init(nibName: nil, bundle: nil)
        self.film = film
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        generalInfoView = UIView(frame: .zero)
        descriptionView = UIView(frame: .zero)
        charactersView = UIView(frame: .zero)
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
        generalInfoView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: generalInfoView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: generalInfoView.leadingAnchor, constant: 8),
            imageView.widthAnchor.constraint(equalToConstant: 125),
            imageView.heightAnchor.constraint(equalToConstant: 175),
        ])
        
    }
    
    private func configureDescriptionView(){
        descriptionView.backgroundColor = .secondarySystemBackground
        descriptionView.layer.cornerRadius = 10
        descriptionView.layer.shadowColor = UIColor.black.cgColor
        descriptionView.layer.shadowRadius = 10
        
        let topLabel = UILabel()
        topLabel.text = "Description"
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        let bottomLabel = UILabel()
        bottomLabel.text = film.openingCrawl.replacingOccurrences(of: "\r\n\r\n", with: "\n\n").replacingOccurrences(of: "\r\n", with: " ")
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.font = UIFont.systemFont(ofSize: 12.0)
        bottomLabel.numberOfLines = 0
        bottomLabel.sizeToFit()
        
        descriptionView.addSubviews([topLabel, bottomLabel])
        
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: -25),
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
        charactersView.backgroundColor = .secondarySystemBackground
        charactersView.layer.cornerRadius = 10
        charactersView.layer.shadowColor = UIColor.black.cgColor
        charactersView.layer.shadowRadius = 10
        
        let topLabel = UILabel()
        topLabel.text = "Characters"
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        charactersView.addSubviews([topLabel])
        
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: charactersView.topAnchor, constant: -25),
            topLabel.leadingAnchor.constraint(equalTo: charactersView.leadingAnchor, constant: 8),
            topLabel.trailingAnchor.constraint(equalTo: charactersView.trailingAnchor, constant: -8),
            topLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
}
