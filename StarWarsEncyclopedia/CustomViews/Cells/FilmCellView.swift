//
//  FilmCellView.swift
//  StarWarsEncyclopedia
//
//  Created by Pau Ribot Pujolras on 18/10/22.
//

import UIKit

class FilmCellView: UITableViewCell {
    
    static let reuseID = "FilmCell"
    
    var filmImageView = UIImageView()
    var titleLabel = UILabel()
    var directorLabel = UILabel()
    var dateLabel = UILabel()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        layer.cornerRadius = 10
        backgroundColor = .secondarySystemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(film : Film){
        filmImageView.image = UIImage(named: "episode1")
        titleLabel.text = film.title
        directorLabel.text = film.director
        dateLabel.text = film.releaseDate
    }
    
    
    private func configure() {
        addSubviews([filmImageView, titleLabel, directorLabel, dateLabel])
        
        filmImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        directorLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        filmImageView.clipsToBounds = true
        filmImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            filmImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            filmImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            filmImageView.widthAnchor.constraint(equalToConstant: 75),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),
            
            directorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            directorLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 16),
            directorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            directorLabel.heightAnchor.constraint(equalToConstant: 25),
            
            dateLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            dateLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
