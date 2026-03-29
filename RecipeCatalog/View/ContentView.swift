//
//  ContentView.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 10/28/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @SwiftDataViewModel private var vm: ViewModel
    @State private var navigationContext = NavigationContext()
    @State private var timerManager = TimerManager()

    var body: some View {
        ThreeColumnContentView()
            .environment(navigationContext)
            .environment(timerManager)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Recipe.self, inMemory: true)
}
