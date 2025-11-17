//
//  EditIngredientView.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/16/25.
//

import SwiftUI

struct EditIngredientView: View {
    @Bindable var ingredient: Ingredient
    @Environment(\.dismiss) private var dismiss
    
    @State private var quantity: String
    @State private var unit: String
    @State private var name: String
    @State private var notes: String
    
    init(ingredient: Ingredient) {
        self.ingredient = ingredient
        _quantity = State(initialValue: "\(ingredient.quantity)")
        _unit = State(initialValue: ingredient.unit)
        _name = State(initialValue: ingredient.name)
        _notes = State(initialValue: ingredient.notes ?? "")
    }
    
    var body: some View {
        Form {
            TextField("Quantity", text: $quantity)
                .keyboardType(.numberPad)
            TextField("Unit (e.g., cups, tsp, oz)", text: $unit)
            TextField("Ingredient Name", text: $name)
            TextField("Notes (optional)", text: $notes)
        }
        .navigationTitle("Edit Ingredient")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    ingredient.quantity = Int(quantity) ?? 1
                    ingredient.unit = unit
                    ingredient.name = name
                    ingredient.notes = notes.isEmpty ? nil : notes
                    dismiss()
                }
            }
        }
    }
}

#Preview {
//    EditIngredientView()
}
