//
//  BookCell.swift
//  GBooks
//
//  Created by chandrasekhar yadavally on 4/14/20.
//  Copyright © 2020 chandrasekhar yadavally. All rights reserved.
//

import UIKit

protocol FavoriteDelegate {
    func didTapFavoriteButton(book: Book)
}

class BookCell: UITableViewCell {
    
    let thumbnailView = ThumbnailView(frame: .zero)
    let label = TitleLabel(textAlignment: .left, fontSize: 20)
    let subTitleLabel = TitleLabel(textAlignment: .left, fontSize: 15)
    var delegate: FavoriteDelegate?
    var book: Book!
    var favoriteButton =  UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        configureFavoriteButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(book: Book) {
        self.book = book
        thumbnailView.downloadImage(from: book.smallThumbnail)
        label.text = book.title
        subTitleLabel.text = book.subtitle
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
    
    func configureFavoriteButton() {
        favoriteButton = UIButton(type: .system)
        favoriteButton.setImage(#imageLiteral(resourceName: "fav_star"), for: .normal)
        favoriteButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        accessoryView = favoriteButton
        
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
    }
    
    @objc func favoriteTapped() {
        delegate?.didTapFavoriteButton(book: book)
        self.favoriteButton.isEnabled = false
    }
    
}
