//
//  CreateRecipeView.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/25/25.
//

import SwiftUI
import SwiftData

struct CreateRecipeView: View {
    @Environment(ViewModel.self) private var vm
    @Environment(\.dismiss) private var dismiss
    
    // State for all recipe properties
    @State private var title: String = ""
    @State private var creator: String = ""
    @State private var dateCreated: Date = Date()
    @State private var prepTime: Int = 0
    @State private var serves: Int = 0
    @State private var difficulty: DifficultyLevel = .beginner
    @State private var caloriesPerServing: Int?
    @State private var isFavorite: Bool = false
    @State private var notes: String = ""
    @State private var selectedCategories : [Category] = []
    @State private var ingredients: [Ingredient] = []
    @State private var instructions: [Instruction] = []
    
    // Hold state for new items
    @State private var newIngredientQuantity: String = ""
    @State private var newIngredientUnit: String = ""
    @State private var newIngredientName: String = ""
    @State private var newIngredientNotes: String = ""
    @State private var newInstructionText: String = ""
    
    // Hold state for edit mode
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Basic Information") {
                    HStack {
                        Text("Title:").bold()
                        TextField(text: $title, prompt: Text("Required")) {
                            Text("")
                        }
                    }
                    HStack {
                        Text("Creator:").bold()
                        TextField(text: $creator, prompt: Text("Required")) {
                            Text("")
                        }
                    }
                    DatePicker(selection: $dateCreated, displayedComponents: .date) {
                        Text("Date Created:").bold()
                    }
                }
                Section("Recipe Details") {
                    Stepper("Prep Time: \(prepTime) min", value: $prepTime, in: 0...500, step: 5)
                    Stepper("Servings: \(serves)", value: $serves, in: 1...100, step: 1)
                    
                    Picker("Difficulty", selection: $difficulty) {
                        Text("Beginner").tag(DifficultyLevel.beginner)
                        Text("Intermediate").tag(DifficultyLevel.intermediate)
                        Text("Advanced").tag(DifficultyLevel.advanced)
                        Text("Expert").tag(DifficultyLevel.expert)
                    }
                    
                    HStack {
                        Text("Calories per Serving")
                        Spacer()
                        TextField("Optional", value: $caloriesPerServing, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 100)
                    }
                    
                    Toggle("Favorite", isOn: $isFavorite)
                }
                Section("Categories") {
                    ForEach(selectedCategories, id: \.name) { category in
                        HStack {
                            Text(category.name)
                            Spacer()
                            Button(role: .destructive) {
                                removeCategory(category)
                            } label: {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                    
                    Menu {
                        ForEach(availableCategories, id: \.name) {category in
                            Button(category.name) {
                                addCategory(category)
                            }
                        }
                    } label: {
                        Label("Add Category", systemImage: "plus.circle.fill")
                    }
                    .disabled(availableCategories.isEmpty)
                }
                Section("Ingredients") {
                    ForEach($ingredients) { $ingredient in
                        NavigationLink {
                            EditIngredientView(ingredient: ingredient)
                        } label: {
                            HStack {
                                Text("\(ingredient.order).")
                                    .foregroundStyle(.secondary)
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("\(ingredient.quantity) \(ingredient.unit) \(ingredient.name)")
                                    if let notes = ingredient.notes, !notes.isEmpty {
                                        Text(notes)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteIngredients)
                    .onMove { from, to in
                        moveIngredients(from: from, to: to)
                    }
                    
                    VStack(spacing: 8) {
                        HStack {
                            TextField("Qty", text: $newIngredientQuantity)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(.roundedBorder)
                                .frame(width: 50)
                            
                            TextField("Unit", text: $newIngredientUnit)
                                .textFieldStyle(.roundedBorder)
                                .frame(width: 70)
                                .textInputAutocapitalization(.never)
                            
                            TextField("Ingredient", text: $newIngredientName)
                                .textFieldStyle(.roundedBorder)
                        }
                        TextField("Notes (optional)", text: $newIngredientNotes)
                            .textFieldStyle(.roundedBorder)
                        
                        Button(action: addIngredient) {
                            Label("Add Ingredient", systemImage: "plus.circle.fill")
                        }
                        .disabled(newIngredientName.isEmpty || newIngredientUnit.isEmpty || newIngredientQuantity.isEmpty)
                    }
                }
                Section("Instructions") {
                    ForEach($instructions) { $instruction in
                        NavigationLink {
                            EditInstructionView(instruction: instruction)
                        } label: {
                            HStack(alignment: .top) {
                                Text("\(instruction.order).")
                                    .foregroundStyle(.secondary)
                                Text(instruction.text)
                            }
                        }
                    }
                    .onDelete(perform: deleteInstructions)
                    .onMove { from, to in
                        moveInstructions(from: from, to: to)
                    }
                    
                    VStack(spacing: 8) {
                        TextField("New instruction", text: $newInstructionText, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                            .lineLimit(3...6)
                        
                        Button(action: addInstruction) {
                            Label("Add Instruction", systemImage: "plus.circle.fill")
                        }
                        .disabled(newInstructionText.isEmpty)
                    }
                }
                Section("Notes") {
                    TextField("Recipe notes", text: $notes, axis: .vertical)
                        .lineLimit(5...10)
                }
            }
            .environment(\.editMode, $editMode)
            .navigationTitle("Create a Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    if editMode == .inactive {
                        Button("Reorder") {
                            editMode = .active
                        }
                    } else {
                        Button("Done") {
                            editMode = .inactive
                        }
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        addRecipe()
                        dismiss()
                    }
                    .disabled(title.isEmpty || creator.isEmpty || editMode == .active)
                }
            }
        }
    }
    
    // MARK: - Helper Properties
    private var availableCategories: [Category] {
        vm.getAvailableCategories(excluding: selectedCategories)
    }
    
    // MARK: - Create Recipe
    private func addRecipe() {
        vm.addRecipe(
            title: title,
            creator: creator,
            dateCreated: dateCreated,
            prepTime: prepTime,
            serves: serves,
            difficulty: difficulty,
            caloriesPerServing: caloriesPerServing,
            isFavorite: isFavorite,
            notes: notes.isEmpty ? nil : notes,
            categories: selectedCategories,
            ingredients: ingredients,
            instructions: instructions
        )
    }
    
    // MARK: - Category Methods
    private func addCategory(_ category: Category) {
        selectedCategories.append(category)
    }
    
    private func removeCategory(_ category: Category) {
        selectedCategories.removeAll { $0.name == category.name }
    }
    
    // MARK: - Ingredient Methods
    private func addIngredient() {
        let newIngredient = Ingredient(
            order: ingredients.count + 1,
            quantity: newIngredientQuantity,
            unit: newIngredientUnit,
            name: newIngredientName,
            notes: newIngredientNotes.isEmpty ? nil : newIngredientNotes
        )
        
        ingredients.append(newIngredient)
        
        // Reset form
        newIngredientQuantity = ""
        newIngredientUnit = ""
        newIngredientName = ""
        newIngredientNotes = ""
    }
    
    private func deleteIngredients(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
        reorderIngredients()
    }
    
    private func moveIngredients(from source: IndexSet, to destination: Int) {
        ingredients.move(fromOffsets: source, toOffset: destination)
        reorderIngredients()
    }
    
    private func reorderIngredients() {
        for (index, _) in ingredients.enumerated() {
            ingredients[index].order = index + 1
        }
    }
    
    // MARK: - Instruction Methods
    private func addInstruction() {
        let newInstruction = Instruction(
            order: instructions.count + 1,
            text: newInstructionText
        )
        
        instructions.append(newInstruction)
        
        // Reset form
        newInstructionText = ""
    }
    
    private func deleteInstructions(at offsets: IndexSet) {
        instructions.remove(atOffsets: offsets)
        reorderInstructions()
    }
    
    private func moveInstructions(from source: IndexSet, to destination: Int) {
        instructions.move(fromOffsets: source, toOffset: destination)
        reorderInstructions()
    }
    
    private func reorderInstructions() {
        for (index, _) in instructions.enumerated() {
            instructions[index].order = index + 1
        }
    }
}

#Preview {
    CreateRecipeView()
}
