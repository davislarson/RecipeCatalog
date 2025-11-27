//
//  EditCategoryView.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/26/25.
//

import SwiftUI

struct EditCategoryView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(ViewModel.self) private var vm
    
    let category: Category
    @State private var categoryName: String
    @State private var selectedRecipes: Set<Recipe>
    
    init(category: Category) {
        self.category = category
        _categoryName = State(initialValue: category.name)
        _selectedRecipes = State(initialValue: Set(category.recipes))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Category Name") {
                    TextField("Name", text: $categoryName)
                }
                
                Section("Recipes in this Category") {
                    ForEach(vm.allRecipes) { recipe in
                        Toggle(recipe.title, isOn: Binding(
                            get: { selectedRecipes.contains(recipe) },
                            set: { isSelected in
                                if isSelected {
                                    selectedRecipes.insert(recipe)
                                    print(selectedRecipes)
                                } else {
                                    selectedRecipes.remove(recipe)
                                    print(selectedRecipes)
                                }
                            }
                        ))
                    }
                }
            }
            .navigationTitle("Edit Category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        vm.updateCategory(
                            category,
                            name: categoryName.trimmingCharacters(in: .whitespaces),
                            recipes: Array(selectedRecipes)
                        )
                        dismiss()
                    }
                    .disabled(categoryName.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}

//#Preview {
//    EditCategoryView(category: )
//}
