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

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 10
        layer.cornerRadius = 10
        backgroundColor = .white
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
    
    
    private func configureSubviews() {
        addSubviews([filmImageView, titleLabel, directorLabel, dateLabel])
        addLayoutConstraints()

        filmImageView.clipsToBounds = true
        filmImageView.contentMode = .scaleAspectFit
        filmImageView.layer.cornerRadius = 10
    }
    
    private func addLayoutConstraints() {
        
        let labelHeight : CGFloat = 15
        let topPadding : CGFloat = 8
        let leadingPadding : CGFloat = 16
        
        filmImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        directorLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont(name: Fonts.tangoSansBold.rawValue, size: 18.0)
        directorLabel.font = UIFont(name: Fonts.tangoSansRegular.rawValue, size: 12.0)
        dateLabel.font = UIFont(name: Fonts.tangoSansRegular.rawValue, size: 12.0)
        
        NSLayoutConstraint.activate([
            filmImageView.topAnchor.constraint(equalTo: topAnchor, constant: topPadding),
            filmImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            filmImageView.widthAnchor.constraint(equalToConstant: 75),
            filmImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: topPadding),
            titleLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: leadingPadding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            directorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topPadding),
            directorLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: leadingPadding),
            directorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            directorLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            dateLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: topPadding),
            dateLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: leadingPadding),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            dateLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        
    }
}
