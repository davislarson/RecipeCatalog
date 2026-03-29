//
//  TimerStatusView.swift
//  RecipeCatalog
//
//  Created by Copilot on 3/29/26.
//

import SwiftUI

/// A horizontal row of compact chips, one per active timer.
struct TimerStatusView: View {
    @Environment(TimerManager.self) private var timerManager

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(timerManager.activeTimers) { timer in
                    TimerChipView(timer: timer)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }
}

/// Single compact chip showing timer icon, truncated title, and remaining time.
struct TimerChipView: View {
    let timer: TimerItem

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "timer")
                .font(.caption2)
            Text(timer.title)
                .font(.caption2)
                .lineLimit(1)
                .truncationMode(.tail)
                .frame(maxWidth: 80)
            Text(formattedTime(timer.remainingTime))
                .font(.caption2.monospacedDigit())
                .foregroundStyle(.orange)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(.thinMaterial, in: Capsule())
    }

    private func formattedTime(_ totalSeconds: TimeInterval) -> String {
        let secs = Int(totalSeconds)
        let h = secs / 3600
        let m = (secs % 3600) / 60
        let s = secs % 60
        if h > 0 {
            return String(format: "%d:%02d:%02d", h, m, s)
        } else {
            return String(format: "%d:%02d", m, s)
        }
    }
}

#Preview {
    let manager = TimerManager()
    manager.addTimer(title: "Cake in oven", duration: 3723)
    manager.addTimer(title: "Pasta", duration: 480)
    return TimerStatusView()
        .environment(manager)
}
