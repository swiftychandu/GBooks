//
//  GBError.swift
//  GBooks
//
//  Created by chandrasekhar yadavally on 4/13/20.
//  Copyright © 2020 chandrasekhar yadavally. All rights reserved.
//

import Foundation

enum GBError: String, Error {
        case invalidUrl = "Invalid URL. Please try again"
        case connectionError = "Connection Error. Please try again later"
        case invalidResponse = "Inalid response from server. Please try again later"
        case invalidData = "Invalid Data"
        case unableToFavorite = "Failed favoriting"
        case existingFavorite = "This favorite already added."
        case conversionFailed = "Data Conversion Failed"
}
