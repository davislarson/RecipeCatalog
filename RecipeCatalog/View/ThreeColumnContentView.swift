//
//  ThreeColumnContentView.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/9/25.
//

import SwiftUI

struct ThreeColumnContentView: View {
    @Environment(ViewModel.self) private var vm
    @State private var searchText: String = ""
    @State private var showTimerSheet = false
    @State private var timerMinutes = 5
    @State private var timerName = ""
    
    var body: some View {
        @Bindable var vm = vm
        NavigationSplitView(columnVisibility: $vm.columnVisibility) {
            CategoryListView()
                .navigationTitle(vm.sideBarTitle)
        } content: {
            RecipeListView(recipeFilter: vm.selectedFilter, searchText: $searchText)
                .navigationTitle(vm.contentListTitle)
        } detail: {
            RecipeDetailView(recipe: vm.selectedRecipe)
        }
        .searchable(text: $searchText, placement: .sidebar, prompt: "Search all recipes...")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showTimerSheet = true
                } label: {
                    Label("Start Timer", systemImage: "timer")
                }
            }
        }
        .sheet(isPresented: $showTimerSheet) {
            NavigationStack {
                Form {
                    Section("Time") {
                        Stepper(value: $timerMinutes, in: 1...240) {
                            Text("\(timerMinutes) minute\(timerMinutes == 1 ? "" : "s")")
                        }
                    }

                    Section("Name (Optional)") {
                        TextField("Ex: Bake Cookies", text: $timerName)
                    }

                    if vm.isTimerRunning {
                        Section {
                            Text("Starting a new timer will replace the current timer.")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .navigationTitle("Kitchen Timer")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            showTimerSheet = false
                        }
                    }

                    ToolbarItem(placement: .confirmationAction) {
                        Button("Start") {
                            vm.startTimer(minutes: timerMinutes, name: timerName)
                            showTimerSheet = false
                        }
                    }
                }
            }
            .presentationDetents([.medium])
        }
        .overlay(alignment: .bottomTrailing) {
            if vm.isTimerRunning {
                Button {
                    showTimerSheet = true
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "timer")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(vm.remainingTimeDisplay)
                                .font(.headline.monospacedDigit())

                            if let timerName = vm.activeTimerName {
                                Text(timerName)
                                    .font(.caption)
                                    .lineLimit(1)
                            }
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 14)
                    .background(.thinMaterial, in: Capsule())
                }
                .buttonStyle(.plain)
                .padding()
                .accessibilityLabel("Active timer")
                .accessibilityValue("\(vm.remainingTimeDisplay) remaining")
            }
        }
        .alert("Timer Finished", isPresented: $vm.showTimerFinishedAlert) {
            Button("Dismiss", role: .cancel) {
                vm.clearFinishedTimerAlert()
            }

            Button("Start New Timer") {
                vm.clearFinishedTimerAlert()
                showTimerSheet = true
            }
        } message: {
            if let timerName = vm.completedTimerName {
                Text("\(timerName) is done.")
            } else {
                Text("Your timer is done.")
            }
        }
    }
}

#Preview {
    ThreeColumnContentView()
}
