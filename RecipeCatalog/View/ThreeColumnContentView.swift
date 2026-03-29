//
//  ThreeColumnContentView.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/9/25.
//

import SwiftUI

struct ThreeColumnContentView: View {
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(TimerManager.self) private var timerManager

    @State private var showTimerSetup = false

    var body: some View {
        @Bindable var navigationConext = navigationContext

        NavigationSplitView(columnVisibility: $navigationConext.columnVisibility) {
            CategoryListView()
                .navigationTitle(navigationContext.sideBarTitle)
        } content: {
            RecipeListView(recipeCategoryName: navigationConext.selectedCategoryName)
                .navigationTitle(navigationConext.contentListTitle)
        } detail: {
            NavigationStack {
                RecipeDetailView(recipe: navigationConext.selectedRecipe)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showTimerSetup = true
                } label: {
                    Label("Timer", systemImage: "timer")
                }
            }
        }
        .overlay(alignment: .bottom) {
            if !timerManager.activeTimers.isEmpty {
                TimerStatusView()
                    .padding(.bottom, 8)
            }
        }
        .sheet(isPresented: $showTimerSetup) {
            TimerSetupView()
                .environment(timerManager)
        }
        .sheet(isPresented: Binding(
            get: { timerManager.completedTimers.first != nil },
            set: { if !$0 { timerManager.dismissFirstCompleted() } }
        )) {
            if let completed = timerManager.completedTimers.first {
                TimerCompletionView(completedTimer: completed) {
                    showTimerSetup = true
                }
                .environment(timerManager)
            }
        }
    }
}

#Preview {
    ThreeColumnContentView()
        .environment(NavigationContext())
        .environment(TimerManager())
}
