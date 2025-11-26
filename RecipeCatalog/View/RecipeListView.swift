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
    
    var body: some View {
        @Bindable var vm = vm
        
        Group {
            if let filter = recipeFilter {
                TextField("Search recipes...", text: $searchText)
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
                    Text("No recipes found.")
                } else {
                    VStack {
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
                    description: Text("Choose a category from the sidebar to view recipes.")
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
    }
}

#Preview {
    RecipeListView(recipeFilter: RecipeFilter.category("Desserts"))
}
