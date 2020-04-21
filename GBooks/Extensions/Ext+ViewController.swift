//
//  Ext+ViewController.swift
//  GBooks
//
//  Created by chandrasekhar yadavally on 4/16/20.
//  Copyright © 2020 chandrasekhar yadavally. All rights reserved.
//

import UIKit

extension UIViewController {
    func showDetailVC(for book: Book) {
        let destinationVC = DetailViewController()
        let navController = UINavigationController(rootViewController: destinationVC)
        destinationVC.title = book.title
        destinationVC.label.text = book.description
        destinationVC.imageView.downloadImage(from: book.smallThumbnail)
        present(navController, animated: true)
    }
}
