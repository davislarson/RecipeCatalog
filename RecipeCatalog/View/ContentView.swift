//
//  ContentView.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 10/28/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var navigationContext = NavigationContext()
    @SwiftDataViewModel private var vm: ViewModel
    
    var body: some View {
        ThreeColumnContentView()
            .environment(navigationContext)
            .environment(vm)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Recipe.self, inMemory: true)
}
