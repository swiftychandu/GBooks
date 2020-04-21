//
//  FavoriteBook+CoreDataProperties.swift
//  GBooks
//
//  Created by chandrasekhar yadavally on 4/20/20.
//  Copyright © 2020 chandrasekhar yadavally. All rights reserved.
//
//

import Foundation
import CoreData


extension FavoriteBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteBook> {
        return NSFetchRequest<FavoriteBook>(entityName: "FavoriteBook")
    }

    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var smallThumbnail: String?

}
