//
//  ViewModel.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/3/25.
//

import SwiftUI
import SwiftData

@Observable class ViewModel: ContextReferencing {
    
    // MARK: - Properties
    private let modelContext: ModelContext
    var recipes: [Recipe] = []
    
    // MARK: Initialization
    
    required init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    
    
    // MARK: - Model Access
    
    
    // MARK: - User Intents
    
    func saveChanges() {
        try? modelContext.save()
    }
    
    // MARK: - Context referencing
    func update() {

    }
    
}
