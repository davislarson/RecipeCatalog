//
//  SwiftData+Recipe.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/16/25.
//

import Foundation
import SwiftData

extension Recipe {
    // MARK: - Pankcakes
    static let pancakes: Recipe = {
        let recipe = Recipe(
            title: "Fluffy Pancakes",
            creator: "Davis Larson",
            dateCreated: Date(),
            prepTime: 20,
            serves: 4,
            difficulty: .beginner,
            caloriesPerServing: 250,
            isFavorite: true,
            notes: "For extra fluffy pancakes, let the batter rest for 5 minutes before cooking.",
            categories: [],
            ingredients: [],
            instructions: []
        )
        return recipe
    }()
    // Helper method to create ingredients for pancakes
    static func createPancakeIngredients(recipe: Recipe) -> [Ingredient] {
        return [
            Ingredient(order: 1, quantity: "1", unit: "cup", name: "all-purpose flour", notes: nil, recipe: recipe),
            Ingredient(order: 2, quantity: "2", unit: "tbsp", name: "sugar", notes: nil, recipe: recipe),
            Ingredient(order: 3, quantity: "2", unit: "tsp", name: "baking powder", notes: nil, recipe: recipe),
            Ingredient(order: 4, quantity: "1", unit: "pinch", name: "salt", notes: nil, recipe: recipe),
            Ingredient(order: 5, quantity: "1", unit: "cup", name: "milk", notes: nil, recipe: recipe),
            Ingredient(order: 6, quantity: "1", unit: "whole", name: "egg", notes: "beaten", recipe: recipe),
            Ingredient(order: 7, quantity: "2", unit: "tbsp", name: "melted butter", notes: nil, recipe: recipe)
        ]
    }
    
    // Helper method to create instructions for pancakes
    static func createPancakeInstructions(recipe: Recipe) -> [Instruction] {
        return [
            Instruction(order: 1, text: "In a large bowl, whisk together flour, sugar, baking powder, and salt.", recipe: recipe),
            Instruction(order: 2, text: "In a separate bowl, whisk together milk, egg, and melted butter.", recipe: recipe),
            Instruction(order: 3, text: "Pour wet ingredients into dry ingredients and stir until just combined. Don't overmix - a few lumps are okay.", recipe: recipe),
            Instruction(order: 4, text: "Heat a non-stick pan or griddle over medium heat. Lightly grease with butter.", recipe: recipe),
            Instruction(order: 5, text: "Pour 1/4 cup batter for each pancake onto the hot griddle.", recipe: recipe),
            Instruction(order: 6, text: "Cook until bubbles form on the surface and edges look set, about 2-3 minutes.", recipe: recipe),
            Instruction(order: 7, text: "Flip and cook until golden brown on the other side, about 1-2 minutes more.", recipe: recipe),
            Instruction(order: 8, text: "Serve hot with maple syrup, butter, and your favorite toppings.", recipe: recipe)
        ]
    }
    
    // MARK: - College Chipotle Bowl
    static let collegeChipotleBowl: Recipe = {
        let recipe = Recipe(
            title: "College Chipotle Bowl",
            creator: "Davis and Owen",
            dateCreated: Date(),
            prepTime: 60,
            serves: 8,
            difficulty: .beginner,
            caloriesPerServing: 450,
            isFavorite: false,
            notes: "Quick and easy. The better the toppings the better the meal. Good toppings have been avocado, sirracha mayo, salsa, and sour cream. Some spices for the meat could be garlic powder, cumin, paprika, Tony Chacheries... whatever you're feeling.",
            categories: [],
            ingredients: [],
            instructions: []
        )
        return recipe
    }()
    // Helper method to create ingredients for college chipotle bowl
    static func createCollegeChipBowlIngredients(recipe: Recipe) -> [Ingredient] {
        return [
            Ingredient(order: 1, quantity: "3", unit: "cup", name: "rice", notes: nil, recipe: recipe),
            Ingredient(order: 2, quantity: "1", unit: "can", name: "black beans", notes: nil, recipe: recipe),
            Ingredient(order: 3, quantity: "1", unit: "can", name: "corn", notes: nil, recipe: recipe),
            Ingredient(order: 4, quantity: "2", unit: "can", name: "tomatoes", notes: "best with chilis or habeneros", recipe: recipe),
            Ingredient(order: 5, quantity: "2", unit: "can", name: "beef broth", notes: "unsalted", recipe: recipe),
            Ingredient(order: 6, quantity: "2", unit: "lbs", name: "ground beef", notes: "leaner = easier but less flavor", recipe: recipe),
            Ingredient(order: 7, quantity: "1/2", unit: "cup", name: "red onion", notes: "diced", recipe: recipe),
            Ingredient(order: 8, quantity: "1", unit: "clove", name: "garlic", notes: "minced", recipe: recipe),
            Ingredient(order: 9, quantity: "1", unit: "cup", name: "cheese", notes: nil, recipe: recipe),
            Ingredient(order: 10, quantity: "1/2", unit: "cup", name: "olive oil", notes: nil, recipe: recipe),
        ]
    }
    
    // Helper method to create instructions for college chipotle bowl
    static func createCollegeChipBowlInstructions(recipe: Recipe) -> [Instruction] {
        return [
            Instruction(order: 1, text: "Heat up the olive oil and soften the red onion slightly with the minced garlic.", recipe: recipe),
            Instruction(order: 2, text: "Add the beef and cook until 90% complete, drain excess fat as desired. Add any desired spices.", recipe: recipe),
            Instruction(order: 3, text: "Place the rice in a large pot or wide high brim pan and lightly brown it.", recipe: recipe),
            Instruction(order: 4, text: "Add the beef into the rice along with the beef broth. The broth should barely cover everything in the pot.", recipe: recipe),
            Instruction(order: 5, text: "Let the pot come to a boil than drop the heat and let rice cook for roughly 15-20 minutes.", recipe: recipe),
            Instruction(order: 6, text: "Once the rice is cooked (checking occationally), turn off the heat and add all the canned veggies.", recipe: recipe),
            Instruction(order: 7, text: "Mix together and add the cheese.", recipe: recipe),
            Instruction(order: 8, text: "Add any desired toppings", recipe: recipe),
        ]
    }
    
    // MARK: - Cookies
    static let cookies: Recipe = {
        let recipe = Recipe(
            title: "Chocolate Chip Cookies",
            creator: "Grandma Larson",
            dateCreated: Date(),
            prepTime: 45,
            serves: 48,
            difficulty: .beginner,
            caloriesPerServing: 180,
            isFavorite: true,
            notes: "For chewier cookies, slightly underbake them. They'll continue to cook on the hot pan after removing from oven.",
            categories: [],
            ingredients: [],
            instructions: []
        )
        return recipe
    }()
    
    // Helper method to create ingredients for cookies
    static func createCookieIngredients(recipe: Recipe) -> [Ingredient] {
        return [
            Ingredient(order: 1, quantity: "2", unit: "cups", name: "all-purpose flour", notes: nil, recipe: recipe),
            Ingredient(order: 2, quantity: "1", unit: "tsp", name: "baking soda", notes: nil, recipe: recipe),
            Ingredient(order: 3, quantity: "1", unit: "tsp", name: "salt", notes: nil, recipe: recipe),
            Ingredient(order: 4, quantity: "1", unit: "cup", name: "butter", notes: "softened", recipe: recipe),
            Ingredient(order: 5, quantity: "3", unit: "cups", name: "brown sugar", notes: "packed", recipe: recipe),
            Ingredient(order: 6, quantity: "1", unit: "cup", name: "granulated sugar", notes: nil, recipe: recipe),
            Ingredient(order: 7, quantity: "2", unit: "whole", name: "eggs", notes: nil, recipe: recipe),
            Ingredient(order: 8, quantity: "2", unit: "tsp", name: "vanilla extract", notes: nil, recipe: recipe),
            Ingredient(order: 9, quantity: "2", unit: "cups", name: "chocolate chips", notes: nil, recipe: recipe)
        ]
    }
    
    // Helper method to create instructions for cookies
    static func createCookieInstructions(recipe: Recipe) -> [Instruction] {
        return [
            Instruction(order: 1, text: "Preheat oven to 375°F (190°C).", recipe: recipe),
            Instruction(order: 2, text: "In a medium bowl, whisk together flour, baking soda, and salt. Set aside.", recipe: recipe),
            Instruction(order: 3, text: "In a large bowl, cream together softened butter, brown sugar, and granulated sugar until light and fluffy.", recipe: recipe),
            Instruction(order: 4, text: "Beat in eggs one at a time, then stir in vanilla extract.", recipe: recipe),
            Instruction(order: 5, text: "Gradually blend in the flour mixture until just combined.", recipe: recipe),
            Instruction(order: 6, text: "Fold in chocolate chips with a spatula or wooden spoon.", recipe: recipe),
            Instruction(order: 7, text: "Drop rounded tablespoons of dough onto ungreased cookie sheets, spacing them about 2 inches apart.", recipe: recipe),
            Instruction(order: 8, text: "Bake for 9-11 minutes, or until golden brown around the edges.", recipe: recipe),
            Instruction(order: 9, text: "Let cookies cool on the baking sheet for 2 minutes before transferring to a wire rack to cool completely.", recipe: recipe)
        ]
    }
    
    // MARK: - Chicken Noodle Soup
        static let chickenNoodleSoup: Recipe = {
            let recipe = Recipe(
                title: "Chicken Noodle Soup",
                creator: "Davis Larson",
                dateCreated: Date(),
                prepTime: 90,
                serves: 6,
                difficulty: .intermediate,
                caloriesPerServing: 220,
                isFavorite: true,
                notes: "This soup tastes even better the next day! For a richer broth, use bone-in chicken pieces and simmer longer. You can substitute egg noodles with rice or pasta if preferred.",
                categories: [],
                ingredients: [],
                instructions: []
            )
            return recipe
        }()
        
        // Helper method to create ingredients for chicken noodle soup
        static func createChickenNoodleSoupIngredients(recipe: Recipe) -> [Ingredient] {
            return [
                Ingredient(order: 1, quantity: "2", unit: "lbs", name: "chicken breast", notes: "boneless, skinless", recipe: recipe),
                Ingredient(order: 2, quantity: "8", unit: "cups", name: "chicken broth", notes: "low sodium", recipe: recipe),
                Ingredient(order: 3, quantity: "3", unit: "whole", name: "carrots", notes: "peeled and sliced", recipe: recipe),
                Ingredient(order: 4, quantity: "3", unit: "stalks", name: "celery", notes: "sliced", recipe: recipe),
                Ingredient(order: 5, quantity: "1", unit: "whole", name: "onion", notes: "diced", recipe: recipe),
                Ingredient(order: 6, quantity: "3", unit: "cloves", name: "garlic", notes: "minced", recipe: recipe),
                Ingredient(order: 7, quantity: "8", unit: "oz", name: "egg noodles", notes: nil, recipe: recipe),
                Ingredient(order: 8, quantity: "2", unit: "tbsp", name: "olive oil", notes: nil, recipe: recipe),
                Ingredient(order: 9, quantity: "2", unit: "tsp", name: "dried thyme", notes: nil, recipe: recipe),
                Ingredient(order: 10, quantity: "2", unit: "whole", name: "bay leaves", notes: nil, recipe: recipe),
                Ingredient(order: 11, quantity: "1", unit: "tsp", name: "salt", notes: "to taste", recipe: recipe),
                Ingredient(order: 12, quantity: "1/2", unit: "tsp", name: "black pepper", notes: "to taste", recipe: recipe),
                Ingredient(order: 13, quantity: "2", unit: "tbsp", name: "fresh parsley", notes: "chopped", recipe: recipe)
            ]
        }
        
        // Helper method to create instructions for chicken noodle soup
    static func createChickenNoodleSoupInstructions(recipe: Recipe) -> [Instruction] {
        return [
            Instruction(order: 1, text: "Heat olive oil in a large pot or Dutch oven over medium heat.", recipe: recipe),
            Instruction(order: 2, text: "Add diced onion, sliced carrots, and celery. Sauté for 5-7 minutes until vegetables begin to soften.", recipe: recipe),
            Instruction(order: 3, text: "Add minced garlic and cook for another minute until fragrant.", recipe: recipe),
            Instruction(order: 4, text: "Pour in chicken broth and add bay leaves and thyme. Bring to a boil.", recipe: recipe),
            Instruction(order: 5, text: "Add chicken breasts to the pot, reduce heat to medium-low, and simmer for 20-25 minutes until chicken is cooked through.", recipe: recipe),
            Instruction(order: 6, text: "Remove chicken from pot and place on a cutting board. Let cool slightly, then shred or dice into bite-sized pieces.", recipe: recipe),
            Instruction(order: 7, text: "While chicken cools, bring the soup back to a boil and add egg noodles. Cook according to package directions, usually 8-10 minutes.", recipe: recipe),
            Instruction(order: 8, text: "Return shredded chicken to the pot. Season with salt and pepper to taste.", recipe: recipe),
            Instruction(order: 9, text: "Remove bay leaves and discard. Stir in fresh parsley.", recipe: recipe),
            Instruction(order: 10, text: "Serve hot with crusty bread or crackers on the side.", recipe: recipe)
        ]
    }
    // MARK: - Grilled Cheese Sandwich
    static let grilledCheese: Recipe = {
        let recipe = Recipe(
            title: "Grilled Cheese Sandwich",
            creator: "Davis Larson",
            dateCreated: Date(),
            prepTime: 10,
            serves: 1,
            difficulty: .beginner,
            caloriesPerServing: 380,
            isFavorite: false,
            notes: "The key to a perfect grilled cheese is low and slow heat. Don't rush it! For extra flavor, add a pinch of garlic powder to the butter before spreading.",
            categories: [],
            ingredients: [],
            instructions: []
        )
        return recipe
    }()

    // Helper method to create ingredients for grilled cheese
    static func createGrilledCheeseIngredients(recipe: Recipe) -> [Ingredient] {
        return [
            Ingredient(order: 1, quantity: "2", unit: "slices", name: "bread", notes: "sourdough or white bread", recipe: recipe),
            Ingredient(order: 2, quantity: "2", unit: "slices", name: "cheddar cheese", notes: "or cheese of choice", recipe: recipe),
            Ingredient(order: 3, quantity: "1", unit: "tbsp", name: "butter", notes: "softened", recipe: recipe)
        ]
    }

    // Helper method to create instructions for grilled cheese
    static func createGrilledCheeseInstructions(recipe: Recipe) -> [Instruction] {
        return [
            Instruction(order: 1, text: "Spread softened butter on one side of each bread slice.", recipe: recipe),
            Instruction(order: 2, text: "Place one slice of bread butter-side down in a cold skillet.", recipe: recipe),
            Instruction(order: 3, text: "Layer the cheese slices on top of the bread in the pan.", recipe: recipe),
            Instruction(order: 4, text: "Place the second slice of bread on top, butter-side up.", recipe: recipe),
            Instruction(order: 5, text: "Turn heat to medium-low and cook for 3-4 minutes until the bottom is golden brown.", recipe: recipe),
            Instruction(order: 6, text: "Carefully flip the sandwich using a spatula.", recipe: recipe),
            Instruction(order: 7, text: "Cook for another 2-3 minutes until the second side is golden brown and cheese is melted.", recipe: recipe),
            Instruction(order: 8, text: "Remove from heat, let cool for 1 minute, then slice diagonally and serve hot.", recipe: recipe)
        ]
    }
    // MARK: - Chicken Piccata
    static let chickenPiccata: Recipe = {
        let recipe = Recipe(
            title: "Chicken Piccata",
            creator: "Davis Larson",
            dateCreated: Date(),
            prepTime: 30,
            serves: 4,
            difficulty: .advanced,
            caloriesPerServing: 320,
            isFavorite: true,
            notes: "The sauce should be tangy and buttery. If it's too acidic, add a bit more butter. If too thick, add a splash of chicken broth. Serve over pasta, rice, or with crusty bread to soak up the delicious sauce.",
            categories: [],
            ingredients: [],
            instructions: []
        )
        return recipe
    }()

    // Helper method to create ingredients for chicken piccata
    static func createChickenPiccataIngredients(recipe: Recipe) -> [Ingredient] {
        return [
            Ingredient(order: 1, quantity: "4", unit: "whole", name: "chicken breasts", notes: "boneless, skinless, pounded thin", recipe: recipe),
            Ingredient(order: 2, quantity: "1/2", unit: "cup", name: "all-purpose flour", notes: "for dredging", recipe: recipe),
            Ingredient(order: 3, quantity: "1", unit: "tsp", name: "salt", notes: nil, recipe: recipe),
            Ingredient(order: 4, quantity: "1/2", unit: "tsp", name: "black pepper", notes: nil, recipe: recipe),
            Ingredient(order: 5, quantity: "3", unit: "tbsp", name: "olive oil", notes: nil, recipe: recipe),
            Ingredient(order: 6, quantity: "4", unit: "tbsp", name: "butter", notes: "divided", recipe: recipe),
            Ingredient(order: 7, quantity: "3", unit: "cloves", name: "garlic", notes: "minced", recipe: recipe),
            Ingredient(order: 8, quantity: "1", unit: "cup", name: "chicken broth", notes: "low sodium", recipe: recipe),
            Ingredient(order: 9, quantity: "1/3", unit: "cup", name: "fresh lemon juice", notes: "about 2 lemons", recipe: recipe),
            Ingredient(order: 10, quantity: "1/4", unit: "cup", name: "capers", notes: "drained", recipe: recipe),
            Ingredient(order: 11, quantity: "1/4", unit: "cup", name: "fresh parsley", notes: "chopped", recipe: recipe),
            Ingredient(order: 12, quantity: "1", unit: "whole", name: "lemon", notes: "sliced thin for garnish", recipe: recipe)
        ]
    }

    // Helper method to create instructions for chicken piccata
    static func createChickenPiccataInstructions(recipe: Recipe) -> [Instruction] {
        return [
            Instruction(order: 1, text: "Place chicken breasts between plastic wrap and pound to about 1/2 inch thickness using a meat mallet.", recipe: recipe),
            Instruction(order: 2, text: "In a shallow dish, combine flour, salt, and pepper. Dredge each chicken breast in the flour mixture, shaking off excess.", recipe: recipe),
            Instruction(order: 3, text: "Heat olive oil and 2 tablespoons of butter in a large skillet over medium-high heat.", recipe: recipe),
            Instruction(order: 4, text: "Once hot, add chicken breasts and cook for 3-4 minutes per side until golden brown and cooked through. Remove chicken and set aside on a plate.", recipe: recipe),
            Instruction(order: 5, text: "In the same skillet, add minced garlic and sauté for about 30 seconds until fragrant.", recipe: recipe),
            Instruction(order: 6, text: "Pour in chicken broth and lemon juice, scraping up any browned bits from the bottom of the pan.", recipe: recipe),
            Instruction(order: 7, text: "Bring the sauce to a boil, then reduce heat and simmer for 5 minutes until slightly reduced.", recipe: recipe),
            Instruction(order: 8, text: "Stir in capers and the remaining 2 tablespoons of butter (with a splash of the brine of the capers) until butter is melted and sauce is smooth.", recipe: recipe),
            Instruction(order: 9, text: "Return chicken to the skillet and spoon sauce over the top. Cook for 2-3 minutes to heat through.", recipe: recipe),
            Instruction(order: 10, text: "Garnish with fresh parsley and lemon slices. Serve immediately.", recipe: recipe)
        ]
    }
    
    // MARK: - Philly Cheesesteak
    static let phillyCheesesteak: Recipe = {
        let recipe = Recipe(
            title: "Philly Cheesesteak",
            creator: "Davis Larson",
            dateCreated: Date(),
            prepTime: 25,
            serves: 4,
            difficulty: .intermediate,
            caloriesPerServing: 520,
            isFavorite: false,
            notes: "For the most authentic experience, use thinly sliced ribeye and Cheez Whiz, though provolone is a great alternative. Freezing the beef for 30 minutes before slicing makes it easier to cut thin. Some people like to add peppers, but traditional Philly cheesesteaks are just meat, onions, and cheese.",
            categories: [],
            ingredients: [],
            instructions: []
        )
        return recipe
    }()

    // Helper method to create ingredients for philly cheesesteak
    static func createPhillycheesesteakIngredients(recipe: Recipe) -> [Ingredient] {
        return [
            Ingredient(order: 1, quantity: "1.5", unit: "lbs", name: "ribeye steak", notes: "thinly sliced", recipe: recipe),
            Ingredient(order: 2, quantity: "2", unit: "whole", name: "onions", notes: "thinly sliced", recipe: recipe),
            Ingredient(order: 3, quantity: "1", unit: "whole", name: "green bell pepper", notes: "thinly sliced (optional)", recipe: recipe),
            Ingredient(order: 4, quantity: "8", unit: "slices", name: "provolone cheese", notes: "or Cheez Whiz", recipe: recipe),
            Ingredient(order: 5, quantity: "4", unit: "whole", name: "hoagie rolls", notes: "or sub rolls", recipe: recipe),
            Ingredient(order: 6, quantity: "3", unit: "tbsp", name: "vegetable oil", notes: "divided", recipe: recipe),
            Ingredient(order: 7, quantity: "2", unit: "tbsp", name: "butter", notes: nil, recipe: recipe),
            Ingredient(order: 8, quantity: "1", unit: "tsp", name: "salt", notes: "to taste", recipe: recipe),
            Ingredient(order: 9, quantity: "1/2", unit: "tsp", name: "black pepper", notes: "to taste", recipe: recipe),
            Ingredient(order: 10, quantity: "1/2", unit: "tsp", name: "garlic powder", notes: "optional", recipe: recipe)
        ]
    }

    // Helper method to create instructions for philly cheesesteak
    static func createPhillycheesesteakInstructions(recipe: Recipe) -> [Instruction] {
        return [
            Instruction(order: 1, text: "If your steak isn't pre-sliced, place it in the freezer for 20-30 minutes to firm up, then slice as thinly as possible against the grain.", recipe: recipe),
            Instruction(order: 2, text: "Heat 1 tablespoon of oil in a large skillet or griddle over medium-high heat.", recipe: recipe),
            Instruction(order: 3, text: "Add sliced onions (and peppers if using) and cook for 5-7 minutes until softened and lightly caramelized. Season with a pinch of salt. Remove from pan and set aside.", recipe: recipe),
            Instruction(order: 4, text: "Add remaining 2 tablespoons of oil to the same skillet and increase heat to high.", recipe: recipe),
            Instruction(order: 5, text: "Add the thinly sliced steak in a single layer. Season with salt, pepper, and garlic powder if using.", recipe: recipe),
            Instruction(order: 6, text: "Cook without stirring for 1-2 minutes to get a good sear, then flip and cook for another 1-2 minutes. Break up any large pieces with your spatula.", recipe: recipe),
            Instruction(order: 7, text: "Return the cooked onions (and peppers) to the pan and mix with the meat.", recipe: recipe),
            Instruction(order: 8, text: "Divide the meat mixture into 4 portions in the pan. Place 2 slices of provolone cheese on each portion and let melt, about 1 minute.", recipe: recipe),
            Instruction(order: 9, text: "While cheese melts, split the hoagie rolls and butter the insides. Toast them in a separate pan or under the broiler until lightly golden.", recipe: recipe),
            Instruction(order: 10, text: "Scoop each cheesy meat portion into a toasted roll. Serve immediately with hot peppers or ketchup if desired.", recipe: recipe)
        ]
    }
    // MARK: - Soft Pretzels
    static let softPretzels: Recipe = {
        let recipe = Recipe(
            title: "Soft Pretzels",
            creator: "Davis Larson",
            dateCreated: Date(),
            prepTime: 90,
            serves: 8,
            difficulty: .intermediate,
            caloriesPerServing: 280,
            isFavorite: false,
            notes: "The baking soda bath is what gives pretzels their distinctive brown color and chewy texture - don't skip it! Work quickly when boiling as you don't want them to get soggy. These are best eaten fresh and warm, but can be reheated in the oven the next day.",
            categories: [],
            ingredients: [],
            instructions: []
        )
        return recipe
    }()

    // Helper method to create ingredients for soft pretzels
    static func createSoftPretzelsIngredients(recipe: Recipe) -> [Ingredient] {
        return [
            Ingredient(order: 1, quantity: "1.5", unit: "cups", name: "warm water", notes: "110°F", recipe: recipe),
            Ingredient(order: 2, quantity: "1", unit: "tbsp", name: "sugar", notes: nil, recipe: recipe),
            Ingredient(order: 3, quantity: "2", unit: "tsp", name: "active dry yeast", notes: "one packet", recipe: recipe),
            Ingredient(order: 4, quantity: "4.5", unit: "cups", name: "all-purpose flour", notes: "plus more for dusting", recipe: recipe),
            Ingredient(order: 5, quantity: "2", unit: "tsp", name: "salt", notes: nil, recipe: recipe),
            Ingredient(order: 6, quantity: "4", unit: "tbsp", name: "butter", notes: "melted", recipe: recipe),
            Ingredient(order: 7, quantity: "10", unit: "cups", name: "water", notes: "for boiling", recipe: recipe),
            Ingredient(order: 8, quantity: "2/3", unit: "cup", name: "baking soda", notes: nil, recipe: recipe),
            Ingredient(order: 9, quantity: "1", unit: "whole", name: "egg", notes: "beaten", recipe: recipe),
            Ingredient(order: 10, quantity: "3", unit: "tbsp", name: "coarse sea salt", notes: "for topping", recipe: recipe)
        ]
    }

    // Helper method to create instructions for soft pretzels
    static func createSoftPretzelsInstructions(recipe: Recipe) -> [Instruction] {
        return [
            Instruction(order: 1, text: "In a large bowl, combine warm water and sugar. Sprinkle yeast on top and let sit for 5 minutes until foamy.", recipe: recipe),
            Instruction(order: 2, text: "Add flour, salt, and melted butter to the yeast mixture. Mix until a dough forms.", recipe: recipe),
            Instruction(order: 3, text: "Knead the dough on a floured surface for 5-7 minutes until smooth and elastic. You can also use a stand mixer with a dough hook for 4-5 minutes.", recipe: recipe),
            Instruction(order: 4, text: "Place dough in a greased bowl, cover with a damp towel, and let rise in a warm place for 45-60 minutes until doubled in size.", recipe: recipe),
            Instruction(order: 5, text: "Preheat oven to 450°F (230°C). Line two baking sheets with parchment paper and grease lightly.", recipe: recipe),
            Instruction(order: 6, text: "Bring 10 cups of water and baking soda to a boil in a large pot.", recipe: recipe),
            Instruction(order: 7, text: "Punch down the dough and divide into 8 equal pieces. Roll each piece into a 20-24 inch rope.", recipe: recipe),
            Instruction(order: 8, text: "Form each rope into a pretzel shape: Make a U-shape, cross the ends over each other twice, then bring the ends down and press onto the bottom of the U.", recipe: recipe),
            Instruction(order: 9, text: "Working one or two at a time, carefully place pretzels into the boiling water for 30 seconds, flipping halfway through. Remove with a slotted spoon and place on prepared baking sheets.", recipe: recipe),
            Instruction(order: 10, text: "Brush each pretzel with beaten egg and sprinkle generously with coarse sea salt.", recipe: recipe),
            Instruction(order: 11, text: "Bake for 12-15 minutes until deep golden brown.", recipe: recipe),
            Instruction(order: 12, text: "Remove from oven and brush with melted butter if desired. Serve warm with mustard or cheese dip.", recipe: recipe)
        ]
    }
    // MARK: - Key Lime Pie
    static let keyLimePie: Recipe = {
        let recipe = Recipe(
            title: "Key Lime Pie",
            creator: "Davis Larson",
            dateCreated: Date(),
            prepTime: 30,
            serves: 8,
            difficulty: .intermediate,
            caloriesPerServing: 410,
            isFavorite: true,
            notes: "Traditional key limes are smaller and more tart than regular Persian limes, but regular limes work great too. The pie needs at least 3 hours to chill properly - overnight is even better. For best results, use fresh lime juice rather than bottled.",
            categories: [],
            ingredients: [],
            instructions: []
        )
        return recipe
    }()

    // Helper method to create ingredients for key lime pie
    static func createKeyLimePieIngredients(recipe: Recipe) -> [Ingredient] {
        return [
            Ingredient(order: 1, quantity: "1.5", unit: "cups", name: "graham cracker crumbs", notes: "about 10-12 crackers", recipe: recipe),
            Ingredient(order: 2, quantity: "1/3", unit: "cup", name: "sugar", notes: "for crust", recipe: recipe),
            Ingredient(order: 3, quantity: "6", unit: "tbsp", name: "butter", notes: "melted", recipe: recipe),
            Ingredient(order: 4, quantity: "4", unit: "whole", name: "egg yolks", notes: "large eggs", recipe: recipe),
            Ingredient(order: 5, quantity: "2", unit: "cans", name: "sweetened condensed milk", notes: "14 oz each", recipe: recipe),
            Ingredient(order: 6, quantity: "2/3", unit: "cup", name: "fresh key lime juice", notes: "or regular lime juice, about 8-10 limes", recipe: recipe),
            Ingredient(order: 7, quantity: "1", unit: "tbsp", name: "lime zest", notes: "finely grated", recipe: recipe),
            Ingredient(order: 8, quantity: "1", unit: "cup", name: "heavy whipping cream", notes: "for topping", recipe: recipe),
            Ingredient(order: 9, quantity: "2", unit: "tbsp", name: "powdered sugar", notes: "for whipped cream", recipe: recipe),
            Ingredient(order: 10, quantity: "1", unit: "whole", name: "lime", notes: "sliced thin for garnish", recipe: recipe)
        ]
    }

    // Helper method to create instructions for key lime pie
    static func createKeyLimePieInstructions(recipe: Recipe) -> [Instruction] {
        return [
            Instruction(order: 1, text: "Preheat oven to 350°F (175°C).", recipe: recipe),
            Instruction(order: 2, text: "In a medium bowl, combine graham cracker crumbs, sugar, and melted butter. Mix until the texture resembles wet sand.", recipe: recipe),
            Instruction(order: 3, text: "Press the crumb mixture firmly into the bottom and up the sides of a 9-inch pie pan. Use the bottom of a measuring cup to pack it down evenly.", recipe: recipe),
            Instruction(order: 4, text: "Bake the crust for 10 minutes until lightly golden. Remove from oven and let cool slightly.", recipe: recipe),
            Instruction(order: 5, text: "In a large bowl, whisk together egg yolks and lime zest until tinted light green, about 2 minutes.", recipe: recipe),
            Instruction(order: 6, text: "Add sweetened condensed milk and whisk until smooth and fully combined.", recipe: recipe),
            Instruction(order: 7, text: "Add the lime juice and whisk until well blended. The mixture will thicken slightly.", recipe: recipe),
            Instruction(order: 8, text: "Pour the filling into the pre-baked graham cracker crust.", recipe: recipe),
            Instruction(order: 9, text: "Bake for 15-17 minutes until the filling is set but still has a slight jiggle in the center.", recipe: recipe),
            Instruction(order: 10, text: "Remove from oven and cool to room temperature on a wire rack, about 30 minutes.", recipe: recipe),
            Instruction(order: 11, text: "Cover with plastic wrap and refrigerate for at least 3 hours or overnight until fully chilled and set.", recipe: recipe),
            Instruction(order: 12, text: "Before serving, whip the heavy cream with powdered sugar until stiff peaks form. Spread or pipe whipped cream over the pie.", recipe: recipe),
            Instruction(order: 13, text: "Garnish with lime slices and additional lime zest if desired. Slice and serve cold.", recipe: recipe)
        ]
    }
    
    // MARK: - Spaghetti with Meat Sauce
    static let spaghetti: Recipe = {
        let recipe = Recipe(
            title: "Spaghetti with Meat Sauce",
            creator: "Davis Larson",
            dateCreated: Date(),
            prepTime: 45,
            serves: 6,
            difficulty: .beginner,
            caloriesPerServing: 480,
            isFavorite: false,
            notes: "The sauce tastes even better if you let it simmer longer - up to 2 hours for a richer flavor. You can also make a big batch and freeze leftovers for easy weeknight dinners. Add a pinch of sugar if the sauce tastes too acidic.",
            categories: [],
            ingredients: [],
            instructions: []
        )
        return recipe
    }()

    // Helper method to create ingredients for spaghetti
    static func createSpaghettiIngredients(recipe: Recipe) -> [Ingredient] {
        return [
            Ingredient(order: 1, quantity: "1", unit: "lb", name: "spaghetti pasta", notes: nil, recipe: recipe),
            Ingredient(order: 2, quantity: "1", unit: "lb", name: "ground beef", notes: "or ground Italian sausage", recipe: recipe),
            Ingredient(order: 3, quantity: "1", unit: "whole", name: "onion", notes: "diced", recipe: recipe),
            Ingredient(order: 4, quantity: "4", unit: "cloves", name: "garlic", notes: "minced", recipe: recipe),
            Ingredient(order: 5, quantity: "1", unit: "can", name: "crushed tomatoes", notes: "28 oz", recipe: recipe),
            Ingredient(order: 6, quantity: "1", unit: "can", name: "tomato sauce", notes: "15 oz", recipe: recipe),
            Ingredient(order: 7, quantity: "2", unit: "tbsp", name: "tomato paste", notes: nil, recipe: recipe),
            Ingredient(order: 8, quantity: "1", unit: "tsp", name: "dried basil", notes: nil, recipe: recipe),
            Ingredient(order: 9, quantity: "1", unit: "tsp", name: "dried oregano", notes: nil, recipe: recipe),
            Ingredient(order: 10, quantity: "1/2", unit: "tsp", name: "red pepper flakes", notes: "optional", recipe: recipe),
            Ingredient(order: 11, quantity: "1", unit: "tsp", name: "salt", notes: "to taste", recipe: recipe),
            Ingredient(order: 12, quantity: "1/2", unit: "tsp", name: "black pepper", notes: "to taste", recipe: recipe),
            Ingredient(order: 13, quantity: "2", unit: "tbsp", name: "olive oil", notes: nil, recipe: recipe),
            Ingredient(order: 14, quantity: "1/4", unit: "cup", name: "fresh basil", notes: "chopped, for garnish", recipe: recipe),
            Ingredient(order: 15, quantity: "1/2", unit: "cup", name: "parmesan cheese", notes: "grated, for serving", recipe: recipe)
        ]
    }

    // Helper method to create instructions for spaghetti
    static func createSpaghettiInstructions(recipe: Recipe) -> [Instruction] {
        return [
            Instruction(order: 1, text: "Heat olive oil in a large pot or deep skillet over medium-high heat.", recipe: recipe),
            Instruction(order: 2, text: "Add diced onion and cook for 5 minutes until softened and translucent.", recipe: recipe),
            Instruction(order: 3, text: "Add minced garlic and cook for 1 minute until fragrant.", recipe: recipe),
            Instruction(order: 4, text: "Add ground beef, breaking it up with a wooden spoon. Cook for 7-10 minutes until browned. Drain excess fat if needed.", recipe: recipe),
            Instruction(order: 5, text: "Stir in tomato paste and cook for 1-2 minutes to deepen the flavor.", recipe: recipe),
            Instruction(order: 6, text: "Add crushed tomatoes, tomato sauce, basil, oregano, red pepper flakes (if using), salt, and black pepper. Stir to combine.", recipe: recipe),
            Instruction(order: 7, text: "Bring the sauce to a boil, then reduce heat to low and simmer for 20-30 minutes, stirring occasionally. The sauce should thicken and the flavors will meld.", recipe: recipe),
            Instruction(order: 8, text: "While the sauce simmers, bring a large pot of salted water to a boil.", recipe: recipe),
            Instruction(order: 9, text: "Cook spaghetti according to package directions until al dente, usually 8-10 minutes. Reserve 1/2 cup of pasta water before draining.", recipe: recipe),
            Instruction(order: 10, text: "Drain the pasta and add it to the sauce, tossing to coat. If the sauce is too thick, add a splash of reserved pasta water.", recipe: recipe),
            Instruction(order: 11, text: "Taste and adjust seasoning with more salt and pepper if needed.", recipe: recipe),
            Instruction(order: 12, text: "Serve hot, garnished with fresh basil and grated parmesan cheese. Serve with garlic bread on the side.", recipe: recipe)
        ]
    }
}
