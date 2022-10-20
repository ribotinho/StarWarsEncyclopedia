//
//  StatView.swift
//  StarWarsEncyclopedia
//
//  Created by Pau Ribot Pujolras on 20/10/22.
//

import UIKit

class StatViewCell: UITableViewCell {

    static let reuseID = "statCell"
    
    var leftLabel = UILabel()
    var rightLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        backgroundColor = .black
        layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(right: String, left: String){
        leftLabel.text = left
        rightLabel.text = right
    }
    
    private func configureView(){
        addSubviews([leftLabel, rightLabel])
        
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        leftLabel.numberOfLines = 0
        leftLabel.textColor = .white
        
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        rightLabel.numberOfLines = 0
        rightLabel.textColor = .white

        
        NSLayoutConstraint.activate([
            leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            leftLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftLabel.heightAnchor.constraint(equalToConstant: 20),
            
            rightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            rightLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
