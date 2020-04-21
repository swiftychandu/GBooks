//
//  SearchViewController.swift
//  GBooks
//
//  Created by chandrasekhar yadavally on 4/15/20.
//  Copyright © 2020 chandrasekhar yadavally. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
     let logoImageView = UIImageView()
      let searchTextField = GBTextField()
      let getBooksButton = GBButton(title: "Get Books", backgroundColor: .systemGreen)
    var isSearchQueryEntered: Bool {  !(searchTextField.text?.isEmpty ?? true) }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        configureLogoImageView()
        configureButton()
        configureTextField()
        createDismissKeyBoardTapGesture()
    }
    
   @objc func showBooksViewController() {
    guard isSearchQueryEntered else { return }
       let booksVC = BooksViewController()
       booksVC.searchQuery = searchTextField.text!
       navigationController?.pushViewController(booksVC, animated: true)
    }
    
    func createDismissKeyBoardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    //UI Configuration
    func configureLogoImageView() {
         view.addSubview(logoImageView)
         logoImageView.translatesAutoresizingMaskIntoConstraints = false
         logoImageView.image = UIImage(named: "bookPlaceholderImage")
         
         NSLayoutConstraint.activate([
             logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
             logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             logoImageView.heightAnchor.constraint(equalToConstant: 200),
             logoImageView.widthAnchor.constraint(equalToConstant: 200)
         ])
     }
    
    func configureTextField() {
          view.addSubview(searchTextField)
          searchTextField.delegate = self
          NSLayoutConstraint.activate([
              searchTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 100),
              searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
              searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
              searchTextField.heightAnchor.constraint(equalToConstant: 50)
          ])
      }
    
    func configureButton() {
           view.addSubview(getBooksButton)
           getBooksButton.addTarget(self, action: #selector(showBooksViewController), for: .touchUpInside)
           
           NSLayoutConstraint.activate([
               getBooksButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
               getBooksButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
               getBooksButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
               getBooksButton.heightAnchor.constraint(equalToConstant: 50)
               
           ])
       }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        showBooksViewController()
       return true
    }
}
