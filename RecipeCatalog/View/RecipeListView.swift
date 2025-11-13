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
    @Environment(ViewModel.self) private var vm
    
    init(recipeCategoryName: String?) {
        self.recipeCategoryName = recipeCategoryName
    }
    
    
    var body: some View {
        @Bindable var navigationContext = navigationContext
        
        // Claude taught me how to use this group to apply multiple view modifiers to an empty state or list state
        Group {
            if let recipeCategoryName {
                if vm.recipes.isEmpty {
                    ContentUnavailableView(
                        "No Recipes in \(recipeCategoryName)",
                        systemImage: "fork.knife",
                        description: Text("Add a recipe to get started.")
                    )
                } else {
                    VStack {
                        TextField("Search", text: .constant(""))
                            .padding()
                        List(selection: $navigationContext.selectedRecipe) {
                            ForEach(vm.recipes) { recipe in
                                NavigationLink(recipe.title, value: recipe)
                            }
                            .onDelete(perform: vm.deleteRecipes)
                        }
                    }
                }
            } else {
                ContentUnavailableView(
                    "Select a Category",
                    systemImage: "list.bullet",
                    description: Text("Choose a category from the sidebar to view its recipes.")
                )
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: vm.addRecipe) {
                    Label("Add Item", systemImage: "plus")
                }

            }
        }
        .onAppear {
            print("RecipeListView appeared with category: \(recipeCategoryName ?? "nil")")
            vm.fetchRecipes(for: recipeCategoryName)
        }
        //- refetch when category changes
        .onChange(of: recipeCategoryName) { oldValue, newValue in
            print("Category changed from \(oldValue ?? "nil") to \(newValue ?? "nil")")
            vm.fetchRecipes(for: newValue)
        }
    }
}

#Preview {
    RecipeListView(recipeCategoryName: "Desserts")
}
