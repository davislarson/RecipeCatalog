//
//  ThreeColumnContentView.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/9/25.
//

import SwiftUI

struct ThreeColumnContentView: View {
    @Environment(ViewModel.self) private var vm
    
    var body: some View {
        @Bindable var vm = vm
        NavigationSplitView(columnVisibility: $vm.columnVisibility) {
            CategoryListView()
                .navigationTitle(vm.sideBarTitle)
        } content: {
            RecipeListView(recipeFilter: vm.selectedFilter)
                .navigationTitle(vm.contentListTitle)
        } detail: {
            NavigationStack{
                RecipeDetailView(recipe: vm.selectedRecipe)
            }
        }
    }
}

#Preview {
    ThreeColumnContentView()
}
