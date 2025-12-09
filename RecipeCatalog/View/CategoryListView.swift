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
    @State private var showDeleteAlert: Bool = false
    @State private var categoriesToDelete: IndexSet = []
    @State private var categoryToDeleteName: String?
    
    var body: some View {
        @Bindable var vm = vm
        
        List(selection: $vm.selectedFilter) {
            // All recipes section
            Section {
                NavigationLink("All Recipes", value: RecipeFilter.all)
                NavigationLink("Favorites", value: RecipeFilter.favorites)
            }
            
            // Categories section
            Section("Categories") {
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
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                if let index = vm.categories.firstIndex(where: { $0.id == category.id }) {
                                    categoryToDeleteName = category.name
                                    prepareDelete(at: IndexSet(integer: index))
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
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
        .alert(alertTitle, isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                performDelete()
            }
        } message: {
            Text(alertMessage)
        }
    }
    
    // MARK: - Alert Properties
    private var alertTitle: String {
        return "Delete \(categoryToDeleteName ?? "this category")?"
    }
    
    private var alertMessage = "All recipes will no longer be associated with this category."
    
    private func prepareDelete(at offsets: IndexSet) {
        categoriesToDelete = offsets
        
        showDeleteAlert = true
    }
    
    private func performDelete() {
        showDeleteAlert = false
        vm.deleteCategories(offsets: categoriesToDelete)
    }
}
#Preview {
    CategoryListView()
}
