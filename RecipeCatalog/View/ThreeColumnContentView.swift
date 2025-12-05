//
//  ThreeColumnContentView.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/9/25.
//

import SwiftUI

struct ThreeColumnContentView: View {
    @Environment(ViewModel.self) private var vm
    @State private var searchText: String = ""
    
    var body: some View {
        @Bindable var vm = vm
        NavigationSplitView(columnVisibility: $vm.columnVisibility) {
            CategoryListView()
                .navigationTitle(vm.sideBarTitle)
        } content: {
            RecipeListView(recipeFilter: vm.selectedFilter, searchText: $searchText)
                .navigationTitle(vm.contentListTitle)
        } detail: {
            NavigationStack{
                RecipeDetailView(recipe: vm.selectedRecipe)
            }
        }
        .searchable(text: $searchText, placement: .sidebar, prompt: "Search all recipes...")
    }
}

#Preview {
    ThreeColumnContentView()
}
