//
//  BookImageView.swift
//  GBooks
//
//  Created by chandrasekhar yadavally on 4/13/20.
//  Copyright © 2020 chandrasekhar yadavally. All rights reserved.
//

import UIKit

class ThumbnailView: UIImageView {
    
    let bookPlaceholderImage = UIImage(named: "bookPlaceholderImage")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clipsToBounds = true
        image = bookPlaceholderImage
    }
    
    
    func downloadImage(from urlString: String) {
          
        guard let url = URL(string: urlString) else { return }
          
          URLSession.shared.dataTask(with: url) {  data, response, error in
              
              if error != nil { return }
              guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
              guard let data = data else { return }
              guard let image = UIImage(data: data) else { return }
              DispatchQueue.main.async { self.image = image }
          }.resume()
      }
  
}

