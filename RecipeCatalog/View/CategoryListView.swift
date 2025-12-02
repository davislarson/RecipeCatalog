//
//  CategoryListView.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/9/25.
//

import SwiftUI

struct CategoryListView: View {
    @Environment(ViewModel.self) private var vm
    @State private var categoryToEdit: Category?
    @State private var showingAddCategory = false
    
    var body: some View {
        @Bindable var vm = vm
        
        List(selection: $vm.selectedFilter) {
            // All recipes section
            Section {
                NavigationLink("All Recipes", value: RecipeFilter.all)
                NavigationLink("Favorites", value: RecipeFilter.favorites)
            }
            
            // Categories section
            Section("Categories (swipe for actions)") {
                ForEach(vm.categories) { category in
                    NavigationLink(category.name, value: RecipeFilter.category(category.name))
                        .swipeActions(edge: .leading) {
                            Button {
                                categoryToEdit = category
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.blue)
                        }
                }
                .onDelete(perform: vm.deleteCategories)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showingAddCategory = true }) {
                    Label("Add Category", systemImage: "plus")
                }
            }
        }
        .sheet(item: $categoryToEdit) { category in
            EditCategoryView(category: category)
        }
        .sheet(isPresented: $showingAddCategory) {
            CreateCategoryView()
        }
        .onAppear {
            vm.fetchCategories()
        }
    }
}
#Preview {
    CategoryListView()
}
