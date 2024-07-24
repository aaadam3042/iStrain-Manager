//
//  Item.swift
//  iStrain Manager
//
//  Created by Ahmad Adam on 24/7/2024.
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
