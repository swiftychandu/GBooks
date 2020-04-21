//
//  GBButton.swift
//  GBooks
//
//  Created by chandrasekhar yadavally on 4/15/20.
//  Copyright © 2020 chandrasekhar yadavally. All rights reserved.
//

import UIKit

class GBButton: UIButton {

 override init(frame: CGRect) {
       super.init(frame: frame)
       configure()
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   init(title: String, backgroundColor: UIColor) {
       super.init(frame: .zero)
       self.setTitle(title, for: .normal)
       self.backgroundColor = backgroundColor
       configure()
   }
   private func configure() {
       layer.cornerRadius = 10
       setTitleColor(.white, for: .normal)
       titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
       translatesAutoresizingMaskIntoConstraints = false
   }
   
   func set(backgroundColor: UIColor, title: String) {
       self.backgroundColor = backgroundColor
       setTitle(title, for: .normal)
   }

}
