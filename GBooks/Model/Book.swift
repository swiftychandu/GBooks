//
//  Book.swift
//  GBooks
//
//  Created by chandrasekhar yadavally on 4/13/20.
//  Copyright © 2020 chandrasekhar yadavally. All rights reserved.
//

import Foundation

struct Book: Codable, Hashable {
    var id = UUID()
    var title: String
    var subtitle: String
    var authors: [String]
    var description: String
    var smallThumbnail: String
}
