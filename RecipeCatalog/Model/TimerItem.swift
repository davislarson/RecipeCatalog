//
//  TimerItem.swift
//  RecipeCatalog
//
//  Created by Copilot on 3/29/26.
//

import Foundation

struct TimerItem: Identifiable {
    let id: UUID
    var title: String
    let duration: TimeInterval
    var remainingTime: TimeInterval

    init(id: UUID = UUID(), title: String, duration: TimeInterval) {
        self.id = id
        self.title = title
        self.duration = duration
        self.remainingTime = duration
    }
}
