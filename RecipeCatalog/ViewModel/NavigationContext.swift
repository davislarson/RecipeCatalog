//
//  NavigationContext.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/9/25.
//

import SwiftUI

@Observable
class NavigationContext {
    var selectedCategoryName: String?
    var selectedRecipe: Recipe?
    var columnVisibility: NavigationSplitViewVisibility
    
    var sideBarTitle = "Categories"
    
    var contentListTitle: String {
       selectedCategoryName ?? "Recipes"
    }
    
    
    init(selectedCategoryName: String? = nil,
         selectedRecipe: Recipe? = nil,
         columnVisibility: NavigationSplitViewVisibility = .automatic) {
        self.selectedCategoryName = selectedCategoryName
        self.selectedRecipe = selectedRecipe
        self.columnVisibility = columnVisibility
    }
}
