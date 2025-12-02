//  EditRecipeView.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/9/25.
//

import SwiftUI
import SwiftData

// This view was highly inspired through my conversation with claude AI
// https://claude.ai/share/17b86691-0458-44a3-90eb-bf2766f3623d

struct RecipeEditView: View {
    let recipe: Recipe
    @Environment(\.dismiss) private var dismiss
    @Environment(ViewModel.self) private var vm
    
    // State copies of all recipe properties
    @State private var title: String
    @State private var creator: String
    @State private var dateCreated: Date
    @State private var prepTime: Int
    @State private var serves: Int
    @State private var difficulty: DifficultyLevel
    @State private var caloriesPerServing: Int?
    @State private var isFavorite: Bool
    @State private var notes: String
    @State private var selectedCategories: [Category]
    @State private var editableIngredients: [Ingredient]
    @State private var editableInstructions: [Instruction]
    
    // New item forms
    @State private var newIngredientQuantity: String = ""
    @State private var newIngredientUnit: String = ""
    @State private var newIngredientName: String = ""
    @State private var newIngredientNotes: String = ""
    @State private var newInstructionText: String = ""
    
    
    init(recipe: Recipe) {
        self.recipe = recipe
        
        // Initialize all @State properties from recipe
        _title = State(initialValue: recipe.title)
        _creator = State(initialValue: recipe.creator)
        _dateCreated = State(initialValue: recipe.dateCreated)
        _prepTime = State(initialValue: recipe.prepTime)
        _serves = State(initialValue: recipe.serves)
        _difficulty = State(initialValue: recipe.difficulty)
        _caloriesPerServing = State(initialValue: recipe.caloriesPerServing)
        _isFavorite = State(initialValue: recipe.isFavorite)
        _notes = State(initialValue: recipe.notes ?? "")
        _selectedCategories = State(initialValue: recipe.categories)
        
        // Convert ingredients to editable data
        _editableIngredients = State(initialValue: recipe.ingredients.sorted(by: { $0.order < $1.order }).map { ingredient in
            Ingredient(
                order: ingredient.order,
                quantity: ingredient.quantity,
                unit: ingredient.unit,
                name: ingredient.name,
                notes: ingredient.notes
            )
        })
        
        // Convert instructions to editable data
        _editableInstructions = State(initialValue: recipe.instructions.sorted(by: { $0.order < $1.order }).map { instruction in
            Instruction(
                order: instruction.order,
                text: instruction.text
            )
        })
    }
        
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationStack {
            Form {
                // MARK: - Basic Information
                Section("Basic Information") {
                    TextField("Title", text: $title)
                    TextField("Creator", text: $creator)
                    DatePicker("Date Created", selection: $dateCreated, displayedComponents: .date)
                }
                
                // MARK: - Recipe Details
                Section("Recipe Details") {
                    Stepper("Prep Time: \(prepTime) min", value: $prepTime, in: 0...500, step: 5)
                    Stepper("Servings: \(serves)", value: $serves, in: 1...100)
                    
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
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 100)
                    }
                    
                    Toggle("Favorite", isOn: $isFavorite)
                }
                
                // MARK: - Categories
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
                        ForEach(availableCategories, id: \.name) { category in
                            Button(category.name) {
                                addCategory(category)
                            }
                        }
                    } label: {
                        Label("Add Category", systemImage: "plus.circle.fill")
                    }
                    .disabled(availableCategories.isEmpty)
                }
                
                // MARK: - Ingredients
                Section("Ingredients") {
                    ForEach($editableIngredients) { $ingredient in
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
                    // Add new ingredient
                    VStack(spacing: 8) {
                        HStack {
                            TextField("Qty", text: $newIngredientQuantity)
                                .keyboardType(.numberPad)
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
                        .disabled(newIngredientName.isEmpty || newIngredientUnit.isEmpty)
                    }
                }
                
                // MARK: - Instructions
                Section("Instructions") {
                    ForEach($editableInstructions) { $instruction in
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
                    
                    // Add new instruction
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
                
                // MARK: - Notes
                Section("Notes") {
                    TextField("Recipe notes", text: $notes, axis: .vertical)
                        .lineLimit(5...10)
                }
            }
            .environment(\.editMode, $editMode)
            .navigationTitle("Edit Recipe")
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
                    Button("Save") {
                        saveChanges()
                        dismiss()
                    }
                    .disabled(editMode == .active)
                }
            }
        }
    }
    
    // MARK: - Helper Properties
    private var availableCategories: [Category] {
        vm.getAvailableCategories(excluding: selectedCategories)
    }
    
    // NOTE: All the following properties are so that you can make editing choices but not make them permanent until it is confirmed by pressing "done".
    
    // MARK: - Save Changes
    private func saveChanges() {
        vm.updateRecipe(
            recipe,
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
            ingredients: editableIngredients,
            instructions: editableInstructions
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
            order: editableIngredients.count + 1,
            quantity: String(newIngredientQuantity),
            unit: newIngredientUnit,
            name: newIngredientName,
            notes: newIngredientNotes.isEmpty ? nil : newIngredientNotes
        )
        
        editableIngredients.append(newIngredient)
        
        // Reset form
        newIngredientQuantity = "1"
        newIngredientUnit = ""
        newIngredientName = ""
        newIngredientNotes = ""
    }
    
    private func deleteIngredients(at offsets: IndexSet) {
        editableIngredients.remove(atOffsets: offsets)
        reorderIngredients()
    }
    
    private func moveIngredients(from source: IndexSet, to destination: Int) {
        editableIngredients.move(fromOffsets: source, toOffset: destination)
        reorderIngredients()
    }
    
    private func reorderIngredients() {
        for (index, _) in editableIngredients.enumerated() {
            editableIngredients[index].order = index + 1
        }
    }
    
    // MARK: - Instruction Methods
    private func addInstruction() {
        let newInstruction = Instruction(
            order: editableInstructions.count + 1,
            text: newInstructionText
        )
        
        editableInstructions.append(newInstruction)
        
        // Reset form
        newInstructionText = ""
    }
    
    private func deleteInstructions(at offsets: IndexSet) {
        editableInstructions.remove(atOffsets: offsets)
        reorderInstructions()
    }
    
    private func moveInstructions(from source: IndexSet, to destination: Int) {
        editableInstructions.move(fromOffsets: source, toOffset: destination)
        reorderInstructions()
    }
    
    private func reorderInstructions() {
        for (index, _) in editableInstructions.enumerated() {
            editableInstructions[index].order = index + 1
        }
    }
}
