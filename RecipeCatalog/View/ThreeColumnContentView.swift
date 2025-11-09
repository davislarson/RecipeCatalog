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
        @Bindable var navigationConext = navigationContext
        NavigationSplitView(columnVisibility: $navigationConext.columnVisibility) {
            CategoryListView()
                .navigationTitle(navigationContext.sideBarTitle)
        } content: {
            RecipeListView(recipeCategoryName: navigationConext.selectedCategoryName)
                .navigationTitle(navigationConext.contentListTitle)
        } detail: {
            NavigationStack{
                RecipeDetailView(recipe: navigationConext.selectedRecipe)
            }
        }
    }
}

#Preview {
    ThreeColumnContentView()
}
