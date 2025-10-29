//
//  Item.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 10/28/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
