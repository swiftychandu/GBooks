//
//  GBTabBarController.swift
//  GBooks
//
//  Created by chandrasekhar yadavally on 4/13/20.
//  Copyright © 2020 chandrasekhar yadavally. All rights reserved.
//

import UIKit

class GBTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [createSearchNC(), createFavoriteNC()]
    }
    
    private func createSearchNC() -> UINavigationController {
        let booksNC = UINavigationController(rootViewController: SearchViewController())
        booksNC.tabBarItem =  UITabBarItem(tabBarSystemItem: .search, tag: 0)
        booksNC.navigationBar.tintColor = .systemGreen
        return booksNC
    }
    
    private func createFavoriteNC() -> UINavigationController {
        let favoriteVC = FavoriteViewController()
        
        let favoriteNC = UINavigationController(rootViewController: favoriteVC)
        favoriteNC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return favoriteNC
    }
    
    
    
    
    
}
