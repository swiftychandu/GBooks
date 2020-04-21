//
//  DetailsViewController.swift
//  GBooks
//
//  Created by chandrasekhar yadavally on 4/16/20.
//  Copyright © 2020 chandrasekhar yadavally. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    let imageView = ThumbnailView(frame: .zero)
    let label = Bodylabel(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationController?.navigationBar.backgroundColor = .systemGray6
    }
    
    func configureUI() {
        view.addSubview(imageView)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.75),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.75),
            label.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }

}
