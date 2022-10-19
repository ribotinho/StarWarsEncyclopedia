//
//  FilmCellView.swift
//  StarWarsEncyclopedia
//
//  Created by Pau Ribot Pujolras on 18/10/22.
//

import UIKit

class FilmCellView: UICollectionViewCell {
    
    static let reuseID = "FilmCell"
    
    var filmImageView = UIImageView()
    var titleLabel = UILabel()
    var directorLabel = UILabel()
    var dateLabel = UILabel()
    var chevronImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemYellow.cgColor
        backgroundColor = UIColor.black
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(film : Film){
        filmImageView.image = UIImage(named: "episode_\(film.episodeId)")
        titleLabel.text = film.title
        directorLabel.text = film.director
        dateLabel.text = film.releaseDate
    }
    
    
    private func configureSubviews() {
        addSubviews([filmImageView, titleLabel, directorLabel, dateLabel, chevronImageView])
        addLayoutConstraints()

        filmImageView.clipsToBounds = true
        filmImageView.contentMode = .scaleAspectFit
        filmImageView.layer.cornerRadius = 10
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.image = UIImage(systemName: "chevron.right")
        chevronImageView.clipsToBounds = true
        chevronImageView.contentMode = .scaleAspectFit
    }
    
    private func addLayoutConstraints() {
        
        let labelHeight : CGFloat = 20
        let topPadding : CGFloat = 8
        let leadingPadding : CGFloat = 16
        
        filmImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        directorLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont(name: Fonts.tangoSansBold.rawValue, size: 16.0)
        titleLabel.textColor = UIColor.white
        
        directorLabel.font = UIFont(name: Fonts.tangoSansRegular.rawValue, size: 12.0)
        directorLabel.textColor = UIColor.white
        
        dateLabel.font = UIFont(name: Fonts.tangoSansRegular.rawValue, size: 12.0)
        dateLabel.textColor = UIColor.white
        
        
        
        NSLayoutConstraint.activate([
            filmImageView.topAnchor.constraint(equalTo: topAnchor, constant: topPadding),
            filmImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            filmImageView.widthAnchor.constraint(equalToConstant: 75),
            filmImageView.heightAnchor.constraint(equalToConstant: 125),
            
            chevronImageView.topAnchor.constraint(equalTo: topAnchor, constant: topPadding),
            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            chevronImageView.heightAnchor.constraint(equalTo: heightAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: 15),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: topPadding),
            titleLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: leadingPadding),
            titleLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            directorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topPadding),
            directorLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: leadingPadding),
            directorLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -8),
            directorLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            dateLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: topPadding),
            dateLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: leadingPadding),
            dateLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -8),
            dateLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        
    }
}
