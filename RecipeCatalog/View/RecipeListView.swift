//
//  RecipeListView.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/9/25.
//

import SwiftUI

struct RecipeListView: View {
    let recipeFilter: RecipeFilter?
    
    @Environment(ViewModel.self) private var vm
    @State private var showAddRecipeSheet: Bool = false
    @State private var searchText: String = ""
    @State private var showDeleteAlert: Bool = false
    @State private var recipesToDelete: IndexSet = []
    @State private var deleteFromCategory: String? = nil
    
    var body: some View {
        @Bindable var vm = vm
        
        VStack(alignment: .leading, spacing: 0) {
            if let filter = recipeFilter {
                TextField("Search all recipes...", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .onChange(of: searchText) { oldValue, newValue in
                        if !newValue.isEmpty {
                            vm.fetchRecipes(for: .search(newValue))
                        } else {
                            vm.fetchRecipes(for: filter)
                        }
                    }
                
                if vm.recipes.isEmpty {
                    Spacer()
                    Text("No recipes found.")
                        .frame(maxWidth: .infinity)
                        .bold()
                    Spacer()
                } else {
                    List(selection: $vm.selectedRecipe) {
                        ForEach(vm.recipes) { recipe in
                            NavigationLink(recipe.title, value: recipe)
                        }
                        .onDelete { offsets in
                            prepareDelete(at: offsets, filter: filter)
                        }
                    }
                }
            } else {
                ContentUnavailableView(
                    "Select a Category",
                    systemImage: "list.bullet",
                    description: Text("Choose a category from the sidebar to view recipes.")
                )
            }
        }        .toolbar {
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
            if let filter = recipeFilter {
                vm.fetchRecipes(for: filter)
            }
        }
        .onChange(of: recipeFilter) { oldValue, newValue in
            if searchText.isEmpty, let filter = newValue {
                vm.fetchRecipes(for: filter)
            }
        }
        .sheet(isPresented: $showAddRecipeSheet) {
            CreateRecipeView()
        }
        .alert(alertTitle, isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) {}
            Button(alertActionTitle, role: .destructive) {
                performDelete()
            }
        } message: {
            Text(alertMessage)
        }
    }
    
    // MARK: - Alert Properties
    
    private var alertTitle: String {
        if let categoryName = deleteFromCategory {
            return "Remove from \(categoryName)?"
        } else {
            return "Delete Recipe?"
        }
    }
    
    private var alertMessage: String {
        let count = recipesToDelete.count
        if let categoryName = deleteFromCategory {
            return count == 1
                ? "This will remove the recipe from \(categoryName). The recipe will still exist in other categories."
                : "This will remove \(count) recipes from \(categoryName). The recipes will still exist in other categories."
        } else {
            return count == 1
                ? "This will permanently delete this recipe from your catalog."
                : "This will permanently delete \(count) recipes from your catalog."
        }
    }
    
    private var alertActionTitle: String {
        deleteFromCategory != nil ? "Remove" : "Delete"
    }
    
    // MARK: - Helper Methods
    
    private func prepareDelete(at offsets: IndexSet, filter: RecipeFilter) {
        recipesToDelete = offsets
        
        switch filter {
        case .category(let categoryName):
            deleteFromCategory = categoryName
        default:
            deleteFromCategory = nil
        }
        
        showDeleteAlert = true
    }
    
    private func performDelete() {
        if let categoryName = deleteFromCategory {
            // Remove recipes from this specific category
            for index in recipesToDelete {
                let recipe = vm.recipes[index]
                vm.removeRecipeFromCategory(recipe, categoryName: categoryName)
            }
        } else {
            // Delete the recipes entirely
            vm.deleteRecipes(offsets: recipesToDelete)
        }
        
        // Reset state
        recipesToDelete = []
        deleteFromCategory = nil
    }
}

#Preview {
    RecipeListView(recipeFilter: RecipeFilter.category("Desserts"))
}
