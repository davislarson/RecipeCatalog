//
//  CategoryListView.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/9/25.
//

import SwiftUI

struct CategoryListView: View {
    @Environment(ViewModel.self) private var vm
    
    var body: some View {
        @Bindable var vm = vm
        
        List(selection: $vm.selectedCategoryName) {
            
            NavigationLink("All Recipes", value: "")
            
            ForEach(vm.categories) { category in
                NavigationLink(category.name, value: category.name)
            }
            .onDelete(perform: vm.deleteCategories)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: vm.addCategory) {
                    Label("Add Category", systemImage: "plus")
                }
            }
        }
        .onAppear {
            vm.fetchCategories()
        }
    }
}

#Preview {
    CategoryListView()
}
