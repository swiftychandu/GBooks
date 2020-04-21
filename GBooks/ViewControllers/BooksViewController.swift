//
//  SearchViewController.swift
//  GBooks
//
//  Created by chandrasekhar yadavally on 4/13/20.
//  Copyright © 2020 chandrasekhar yadavally. All rights reserved.
//

import UIKit
import SwiftyJSON
import SCLAlertView
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class BooksViewController: UIViewController {
    enum Section {
        case main
    }
    
    var searchQuery = ""
    var books: [Book] = []
    var filteredBooks: [Book] = []
    let tableView = UITableView()
    var datasource: UITableViewDiffableDataSource<Section,Book>!
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBooksVC()
        configureTableView()
        configureSearchController()
        configureDatasource()
        findBooks()
    }
    
    func configureBooksVC() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.tabBarItem =  UITabBarItem(tabBarSystemItem: .search, tag: 0)
        view.backgroundColor = .systemBackground
        navigationItem.title = searchQuery
    }
    
    @objc func findBooks() {
        NetworkManager.shared.fetchBooks(for: searchQuery) { data, error in
            if error != nil {
                DispatchQueue.main.async {
                    let alert = SCLAlertView()
                    alert.showError(String(describing: error?.rawValue), subTitle: "Please try again")
                }
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    let alert = SCLAlertView()
                    alert.showError(String(describing: error?.rawValue), subTitle: "Please try again")
                }
                return
            }
            do {
                var tempBooks: [Book] = []
                let booksData = try JSON(data: data)
                guard booksData["items"].count > 0 else {
                    DispatchQueue.main.async {
                        let alert = SCLAlertView()
                        alert.showError("No books Found", subTitle: "Please try again")
                    }
                    return }
                for i in 0...booksData["items"].count-1 {
                    var authors = [String]()
                    for j in booksData["items"][i]["volumeInfo"]["authors"].arrayValue {
                        authors.append(j.stringValue)
                    }
                    let title = booksData["items"][i]["volumeInfo"]["title"].stringValue
                    let subtitle = booksData["items"][i]["volumeInfo"]["subtitle"].stringValue
                    let description = booksData["items"][i]["volumeInfo"]["description"].stringValue
                    let smallThumbnail = booksData["items"][i]["volumeInfo"]["imageLinks"]["smallThumbnail"].stringValue
                    tempBooks.append(Book(title: title, subtitle: subtitle, authors: authors, description: description, smallThumbnail: smallThumbnail))
                    
                }
                self.books = tempBooks
                self.updateUI(on: self.books)
                
            } catch {
                DispatchQueue.main.async {
                    let alert = SCLAlertView()
                    alert.showError("Bad data received", subTitle: "Please try again")
                }
            }
        }
        
    }
    
    private func configureSearchController() {
        searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Filter the books"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 120
        tableView.delegate = self
        tableView.register(BookCell.self, forCellReuseIdentifier: String(describing: BookCell.self))
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    func configureDatasource() {
        datasource = UITableViewDiffableDataSource<Section, Book>(tableView: tableView, cellProvider: { tableView, indexPath, book -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BookCell.self), for: indexPath) as! BookCell
            cell.delegate = self
            cell.set(book: book)
            return cell
        })
    }
    
    func updateUI(on books: [Book]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Book>()
        snapshot.appendSections([.main])
        snapshot.appendItems(books)
        DispatchQueue.main.async {  self.datasource.apply(snapshot, animatingDifferences: true) }
    }
    
    func saveFavorite(book: Book, completion: (Bool) -> Void) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let favBook = FavoriteBook(context: managedContext)
        favBook.title = book.title
        favBook.subtitle = book.subtitle
        favBook.smallThumbnail = book.smallThumbnail
        
        do {
            try managedContext.save()
            completion(true)
        } catch {
            DispatchQueue.main.async {
                let alert = SCLAlertView()
                alert.showError("Saving Error", subTitle: "Please try again")
            }
            completion(false)
        }
    }
    
}

extension BooksViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text else { return }
        if filter.isEmpty { updateUI(on: self.books); return }
        filteredBooks = books.filter { $0.title.lowercased().contains(filter.lowercased()) }
        updateUI(on: filteredBooks)
    }
}

extension BooksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        showDetailVC(for: book)
    }
}

extension BooksViewController: FavoriteDelegate {
    func didTapFavoriteButton(book: Book) {
        saveFavorite(book: book) { done in
            if !done {
                DispatchQueue.main.async {
                    let alert = SCLAlertView()
                    alert.showError("Saving Error", subTitle: "Please try again")
                }
            }
        }
    }
    
    
}
