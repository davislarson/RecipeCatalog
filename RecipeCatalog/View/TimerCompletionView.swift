//
//  TimerCompletionView.swift
//  RecipeCatalog
//
//  Created by Copilot on 3/29/26.
//

import SwiftUI

/// Sheet presented when a timer finishes.  Lets the user dismiss or start a new timer.
struct TimerCompletionView: View {
    @Environment(TimerManager.self) private var timerManager
    @Environment(\.dismiss) private var dismiss

    let completedTimer: TimerItem
    /// Called after dismissal when the user wants to add a new timer.
    var onAddTimer: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "bell.ring.fill")
                .font(.system(size: 60))
                .foregroundStyle(.orange)
                .symbolEffect(.bounce, options: .repeating)

            VStack(spacing: 6) {
                Text("Timer Complete!")
                    .font(.title.bold())
                Text(completedTimer.title)
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 16) {
                Button("Dismiss") {
                    timerManager.dismissFirstCompleted()
                    dismiss()
                }
                .buttonStyle(.bordered)
                .controlSize(.large)

                Button("Add Timer") {
                    timerManager.dismissFirstCompleted()
                    dismiss()
                    // Delay slightly so the dismiss animation finishes before
                    // the parent presents the new timer setup sheet.
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        onAddTimer?()
                    }
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }

            Spacer()
        }
        .padding()
        .presentationDetents([.medium])
    }
}

#Preview {
    TimerCompletionView(completedTimer: TimerItem(title: "Pasta", duration: 480))
        .environment(TimerManager())
}

