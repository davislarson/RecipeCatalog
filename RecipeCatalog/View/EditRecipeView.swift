import SwiftUI
import SwiftData

// This view was highly inspired through my conversation with claude AI

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
    @State private var editableIngredients: [IngredientData]
    @State private var editableInstructions: [InstructionData]
    
    // New item forms
    @State private var newIngredientQuantity: String = "1"
    @State private var newIngredientUnit: String = ""
    @State private var newIngredientName: String = ""
    @State private var newIngredientNotes: String = ""
    @State private var newInstructionText: String = ""
    
    // Temporary data structures for editing
    struct IngredientData: Identifiable {
        let id = UUID()
        var order: Int
        var quantity: String
        var unit: String
        var name: String
        var notes: String?
    }
    
    struct InstructionData: Identifiable {
        let id = UUID()
        var order: Int
        var text: String
    }
    
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
            IngredientData(
                order: ingredient.order,
                quantity: ingredient.quantity,
                unit: ingredient.unit,
                name: ingredient.name,
                notes: ingredient.notes
            )
        })
        
        // Convert instructions to editable data (THIS WAS MISSING!)
        _editableInstructions = State(initialValue: recipe.instructions.sorted(by: { $0.order < $1.order }).map { instruction in
            InstructionData(
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
                        Text("Intermediate").tag(DifficultyLevel.intermidiate)
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
                    ForEach(editableIngredients) { ingredient in
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
                            
                            Spacer()
                            
                            Button(role: .destructive) {
                                removeIngredient(ingredient)
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                    .onMove { from, to in
                        moveIngredients(from: from, to: to)
                    }
                    
                    // Add new ingredient
                    VStack(spacing: 8) {
                        HStack {
                            TextField("Qty", text: $newIngredientQuantity)
                                .textFieldStyle(.roundedBorder)
                                .frame(width: 50)
                            
                            TextField("Unit", text: $newIngredientUnit)
                                .textFieldStyle(.roundedBorder)
                                .frame(width: 70)
                            
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
                    ForEach(editableInstructions) { instruction in
                        HStack(alignment: .top) {
                            Text("\(instruction.order).")
                                .foregroundStyle(.secondary)
                            Text(instruction.text)
                            Spacer()
                            Button(role: .destructive) {
                                removeInstruction(instruction)
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundStyle(.red)
                            }
                        }
                    }
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
        vm.allCategories.filter { category in
            !selectedCategories.contains(where: { $0.name == category.name })
        }
    }
    
    // MARK: - Save Changes
    private func saveChanges() {
        // Update basic properties
        recipe.title = title
        recipe.creator = creator
        recipe.dateCreated = dateCreated
        recipe.prepTime = prepTime
        recipe.serves = serves
        recipe.difficulty = difficulty
        recipe.caloriesPerServing = caloriesPerServing
        recipe.isFavorite = isFavorite
        recipe.notes = notes.isEmpty ? nil : notes
        
        // Update categories
        recipe.categories = selectedCategories
        
        // Delete all old ingredients using ViewModel
        vm.deleteAllIngredients(from: recipe)
        
        // Create new ingredients from editable data
        for ingredientData in editableIngredients {
            let newIngredient = Ingredient(
                order: ingredientData.order,
                quantity: ingredientData.quantity,
                unit: ingredientData.unit,
                name: ingredientData.name,
                notes: ingredientData.notes,
                recipe: recipe
            )
            recipe.ingredients.append(newIngredient)
            vm.insertIngredient(newIngredient)
        }
        
        // Delete all old instructions using ViewModel
        vm.deleteAllInstructions(from: recipe)
        
        // Create new instructions from editable data
        for instructionData in editableInstructions {
            let newInstruction = Instruction(
                order: instructionData.order,
                text: instructionData.text,
                recipe: recipe
            )
            recipe.instructions.append(newInstruction)
            vm.insertInstruction(newInstruction)
        }
        
        // Save all changes through ViewModel
        vm.saveChanges()
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
        let newIngredient = IngredientData(
            order: editableIngredients.count,
            quantity: newIngredientQuantity,
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
    
    private func removeIngredient(_ ingredient: IngredientData) {
        editableIngredients.removeAll { $0.id == ingredient.id }
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
        let newInstruction = InstructionData(
            order: editableInstructions.count + 1,
            text: newInstructionText
        )
        
        editableInstructions.append(newInstruction)
        
        // Reset form
        newInstructionText = ""
    }
    
    private func removeInstruction(_ instruction: InstructionData) {
        editableInstructions.removeAll { $0.id == instruction.id }
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
