//
//  RecipeListView.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/9/25.
//

import SwiftUI

struct RecipeListView: View {
    let recipeCategoryName: String?
    
    @Environment(NavigationContext.self) private var navigationContext
    @SwiftDataViewModel private var vm: ViewModel
    
    init(recipeCategoryName: String?) {
        self.recipeCategoryName = recipeCategoryName
    }
    
    
    var body: some View {
        @Bindable var navigationContext = navigationContext
        if let recipeCategoryName {
            // Claude taught me how to use this group to apply multiple view modifiers to an empty state or list state
            Group {
                if vm.recipes.isEmpty {
                    ContentUnavailableView(
                        "No Recipes",
                        systemImage: "fork.knife",
                        description: Text("Add a recipe to get started.")
                    )
                } else {
                    List(selection: $navigationContext.selectedRecipe) {
                        ForEach(vm.recipes) { recipe in
                            NavigationLink(recipe.title, value: recipe)
                        }
                        .onDelete(perform: vm.deleteRecipes)
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: vm.addRecipe) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .onAppear {
                vm.fetchRecipes(for: recipeCategoryName)
            }
        } else {
            ContentUnavailableView(
                "Select a category to see recipes.",
                systemImage: "exclamationmark.triangle",
            )
        }
    }
}

//#Preview {
//    RecipeListView()
//}
