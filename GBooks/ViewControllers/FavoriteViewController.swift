//
//  FavoriteViewController.swift
//  GBooks
//
//  Created by chandrasekhar yadavally on 4/13/20.
//  Copyright © 2020 chandrasekhar yadavally. All rights reserved.
//

import UIKit
import CoreData
import SCLAlertView

class FavoriteViewController: UIViewController {
    
    let tableView = UITableView()
    var favoriteBooks:[FavoriteBook] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchFavorites()
        navigationItem.title = "Favorite Books"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if favoriteBooks.isEmpty {
            let alert = SCLAlertView()
            alert.showError("No Favorite Books", subTitle: "Go to search to add books")
        }
        fetchFavorites()
        tableView.reloadData()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 120
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: String(describing: FavoriteCell.self))
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func fetchFavorites() {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteBook")
        do {
            favoriteBooks = try managedContext.fetch(request) as! [FavoriteBook]
        } catch {
            DispatchQueue.main.async {
                let alert = SCLAlertView()
                alert.showError("Fetch Error", subTitle: "Please try again")
            }
        }
    }
    
    func deleteFavorite(at indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.delete(favoriteBooks[indexPath.row])
        do {
            try managedContext.save()
        } catch {
            DispatchQueue.main.async {
                let alert = SCLAlertView()
                alert.showError("Deletion Error", subTitle: "Please try again")
            }
        }
    }
    
}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FavoriteCell.self), for: indexPath) as? FavoriteCell else { return FavoriteCell()}
        let favBook = favoriteBooks[indexPath.row]
        cell.set(favBook: favBook)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, completion in
            self.deleteFavorite(at: indexPath)
            self.favoriteBooks.remove(at: indexPath.row)
            self.tableView.reloadData()
            completion(true)
        }
        deleteAction.image = UIImage(named: "delete")
        deleteAction.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
}
