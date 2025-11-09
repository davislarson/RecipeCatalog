//
//  CategoryListView.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/9/25.
//

import SwiftUI

struct CategoryListView: View {
    @Environment(NavigationContext.self) private var navigationContext
    @SwiftDataViewModel private var vm: ViewModel
    
    var body: some View {
        @Bindable var navigationContext = navigationContext
        
        List(selection: $navigationContext.selectedCategoryName) {
            ForEach(vm.categories) { category in
                NavigationLink(category.name, value: category.name)
            }
            .onDelete(perform: vm.deleteRecipes)
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
    }
}

#Preview {
    CategoryListView()
}
