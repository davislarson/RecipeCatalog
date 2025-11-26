//
//  RecipeListView.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/9/25.
//

import SwiftUI

struct RecipeListView: View {
    let recipeCategoryName: String?
    
    @Environment(ViewModel.self) private var vm
    @State private var showAddRecipeSheet: Bool = false
    
    init(recipeCategoryName: String?) {
        self.recipeCategoryName = recipeCategoryName
    }
    
    
    var body: some View {
        @Bindable var vm = vm
        
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
                        List(selection: $vm.selectedRecipe) {
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
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showAddRecipeSheet = true
                } label: {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        .onAppear {
            vm.fetchRecipes(for: recipeCategoryName)
        }
        //- refetch when category changes
        .onChange(of: recipeCategoryName) { oldValue, newValue in
            vm.fetchRecipes(for: newValue)
        }
        .sheet(isPresented: $showAddRecipeSheet) {
            CreateRecipeView()
        }
    }
}

#Preview {
    RecipeListView(recipeCategoryName: "Desserts")
}
