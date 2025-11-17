//
//  RecipeDetailView.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/9/25.
//

import SwiftUI

struct RecipeDetailView: View {
//    @Environment(ViewModel.self) private var vm
    @Environment(\.editMode) private var editMode
    
    var recipe: Recipe?
    
    var body: some View {
        if recipe == nil {
            ContentUnavailableView(
                "No recipe chosen",
                systemImage: "fork.knife",
                description: Text("Select a recipe.")
            )
        } else if let recipe = recipe {
            if editMode?.wrappedValue.isEditing == true {
                EditRecipeView()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // MARK: - Header
                        VStack(alignment: .leading, spacing: 8) {
                            Text(recipe.title)
                                .font(.largeTitle)
                                .bold()
                            
                            Text("By \(recipe.creator)")
                                .font(.title3)
                                .foregroundStyle(.secondary)
                            
                            Text("Date created: \(recipe.dateCreated.formatted(date: .abbreviated, time: .omitted))")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        
                        Divider()
                        
                        // MARK: - Quick Info Grid
                        VStack(spacing: 12) {
                            HStack {
                                InfoCard(icon: "clock", label: "Prep Time", value: "\(recipe.prepTime) min")
                                InfoCard(icon: "person.2", label: "Serves", value: "\(recipe.serves)")
                            }
                            
                            HStack {
                                InfoCard(icon: "chart.bar", label: "Difficulty", value: recipe.difficulty.rawValue)
                                if let calories = recipe.caloriesPerServing {
                                    InfoCard(icon: "flame", label: "Calories Per Serving", value: "\(calories)")
                                } else {
                                    InfoCard(icon: "flame", label: "Calories Per Serving", value: "N/A")
                                }
                            }
                        }
                        
                        Divider()
                        
                        // MARK: - Categories
                        if !recipe.categories.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Categories")
                                    .font(.headline)
                                
                                HStack {
                                    ForEach(recipe.categories, id: \.name) { category in
                                        Text(category.name)
                                            .font(.subheadline)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(Color.blue.opacity(0.1))
                                            .foregroundStyle(.blue)
                                            .cornerRadius(8)
                                    }
                                }
                            }
                            
                            Divider()
                        }
                        
                        // MARK: - Ingredients
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Ingredients")
                                .font(.title2)
                                .bold()
                            
                            VStack(alignment: .leading, spacing: 8) {
                                ForEach(recipe.ingredients.sorted(by: { $0.order < $1.order }), id: \.order) { ingredient in
                                    HStack(alignment: .top, spacing: 8) {
                                        Text("•")
                                            .font(.headline)
                                            .foregroundStyle(.blue)
                                        
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text("\(ingredient.quantity) \(ingredient.unit) \(ingredient.name)")
                                                .font(.body)
                                            
                                            if let notes = ingredient.notes, !notes.isEmpty {
                                                Text(notes)
                                                    .font(.caption)
                                                    .italic()
                                                    .foregroundStyle(.secondary)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                        Divider()
                        
                        // MARK: - Instructions
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Instructions")
                                .font(.title2)
                                .bold()
                            
                            VStack(alignment: .leading, spacing: 16) {
                                ForEach(recipe.instructions.sorted(by: { $0.order < $1.order }), id: \.order) { instruction in
                                    HStack(alignment: .top, spacing: 12) {
                                        ZStack {
                                            Circle()
                                                .fill(Color.blue.opacity(0.1))
                                                .frame(width: 32, height: 32)
                                            
                                            Text("\(instruction.order)")
                                                .font(.headline)
                                                .foregroundStyle(.blue)
                                        }
                                        
                                        Text(instruction.text)
                                            .font(.body)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                }
                            }
                        }
                        
                        // MARK: - Notes
                        if let notes = recipe.notes, !notes.isEmpty {
                            Divider()
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Notes")
                                    .font(.title2)
                                    .bold()
                                
                                Text(notes)
                                    .font(.body)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.yellow.opacity(0.1))
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle(recipe.title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            recipe.toggleFavorite()
                        } label: {
                            Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                                .foregroundStyle(recipe.isFavorite ? .red : .primary)
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        EditButton()
                    }
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    // Create sample data for preview
    let category1 = Category(name: "Desserts", recipes: [])
    let category2 = Category(name: "Quick", recipes: [])
    
    let ingredient1 = Ingredient(order: 1, quantity: 2, unit: "cups", name: "all-purpose flour", notes: nil)
    let ingredient2 = Ingredient(order: 2, quantity: 1, unit: "cup", name: "sugar", notes: nil)
    let ingredient3 = Ingredient(order: 3, quantity: 3, unit: "large", name: "eggs", notes: "room temperature")
    
    let instruction1 = Instruction(order: 1, text: "Preheat oven to 350°F (175°C). Grease and flour a 9-inch round cake pan.")
    let instruction2 = Instruction(order: 2, text: "In a large bowl, cream together butter and sugar until light and fluffy.")
    let instruction3 = Instruction(order: 3, text: "Beat in eggs one at a time, mixing well after each addition.")
    let instruction4 = Instruction(order: 4, text: "Gradually add flour mixture, alternating with milk, beginning and ending with flour.")
    
    let sampleRecipe = Recipe(
        title: "Classic Vanilla Cake",
        creator: "Chef Johnson",
        dateCreated: Date(),
        prepTime: 45,
        serves: 8,
        difficulty: .intermidiate,
        caloriesPerServing: 320,
        isFavorite: true,
        notes: "This cake pairs wonderfully with buttercream frosting. For best results, ensure all ingredients are at room temperature.",
        categories: [category1, category2],
        ingredients: [ingredient1, ingredient2, ingredient3],
        instructions: [instruction1, instruction2, instruction3, instruction4]
    )
    
    // Set up bidirectional relationships
    ingredient1.recipe = sampleRecipe
    ingredient2.recipe = sampleRecipe
    ingredient3.recipe = sampleRecipe
    instruction1.recipe = sampleRecipe
    instruction2.recipe = sampleRecipe
    instruction3.recipe = sampleRecipe
    instruction4.recipe = sampleRecipe
    category1.recipes = [sampleRecipe]
    category2.recipes = [sampleRecipe]
    
    return NavigationStack {
        RecipeDetailView(recipe: sampleRecipe)
    }
}
