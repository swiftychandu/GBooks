//
//  FavoriteCell.swift
//  GBooks
//
//  Created by chandrasekhar yadavally on 4/16/20.
//  Copyright © 2020 chandrasekhar yadavally. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    let thumbnailView = ThumbnailView(frame: .zero)
    let label = TitleLabel(textAlignment: .left, fontSize: 20)
    let subTitleLabel = TitleLabel(textAlignment: .left, fontSize: 15)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favBook: FavoriteBook) {
        guard let url = favBook.smallThumbnail else { return }
        thumbnailView.downloadImage(from: url)
        label.text = favBook.title
        subTitleLabel.text = favBook.subtitle
    }
    
    
    func configure() {
        addSubview(thumbnailView)
        addSubview(label)
        addSubview(subTitleLabel)
        backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            thumbnailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            thumbnailView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            thumbnailView.widthAnchor.constraint(equalToConstant: 120),
            thumbnailView.heightAnchor.constraint(equalToConstant: 100),
            
            label.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            label.heightAnchor.constraint(equalToConstant: bounds.height * 0.5),
            
            subTitleLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 10),
            subTitleLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 25),
            subTitleLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            subTitleLabel.heightAnchor.constraint(equalTo: label.heightAnchor)
            
        ])
    }    
}
