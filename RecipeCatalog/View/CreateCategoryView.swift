//
//  CreateCategoryView.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/26/25.
//

import SwiftUI

struct CreateCategoryView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(ViewModel.self) private var vm
    
    @State private var categoryName: String = ""
    @State private var selectedRecipes: Set<Recipe> = []
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Category Name") {
                    TextField("Name", text: $categoryName)
                }
                
                Section("Add Recipes (Optional)") {
                    ForEach(vm.allRecipes) { recipe in
                        Toggle(recipe.title, isOn: Binding(
                            get: { selectedRecipes.contains(recipe) },
                            set: { isSelected in
                                if isSelected {
                                    selectedRecipes.insert(recipe)
                                } else {
                                    selectedRecipes.remove(recipe)
                                }
                            }
                        ))
                    }
                }
            }
            .navigationTitle("New Category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        vm.createCategory(
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


#Preview {
    CreateCategoryView()
}
