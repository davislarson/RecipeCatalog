//
//  ThreeColumnContentView.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/9/25.
//

import SwiftUI

struct ThreeColumnContentView: View {
    @Environment(NavigationContext.self) private var navigationContext
    
    var body: some View {
        @Bindable var navigationContext = navigationContext
        NavigationSplitView(columnVisibility: $navigationContext.columnVisibility) {
            CategoryListView()
                .navigationTitle(navigationContext.sideBarTitle)
        } content: {
            RecipeListView(recipeCategoryName: navigationContext.selectedCategoryName)
                .navigationTitle(navigationContext.contentListTitle)
        } detail: {
            NavigationStack{
                RecipeDetailView(recipe: navigationContext.selectedRecipe)
            }
        }
    }
}

#Preview {
    ThreeColumnContentView()
}
