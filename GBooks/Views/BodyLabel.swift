//
//  BodyLabel.swift
//  GBooks
//
//  Created by chandrasekhar yadavally on 4/13/20.
//  Copyright © 2020 chandrasekhar yadavally. All rights reserved.
//

import UIKit

   class Bodylabel: UILabel {
   override init(frame: CGRect) {
       super.init(frame: frame)
       configure()
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   init(textAlignment: NSTextAlignment) {
       super.init(frame: .zero)
       self.textAlignment = textAlignment
       configure()
   }
   
   private func configure() {
       translatesAutoresizingMaskIntoConstraints = false
       font = UIFont.preferredFont(forTextStyle: .body)
       textColor = .secondaryLabel
       adjustsFontSizeToFitWidth = true
       minimumScaleFactor = 0.75
       numberOfLines = 10
   }

}
