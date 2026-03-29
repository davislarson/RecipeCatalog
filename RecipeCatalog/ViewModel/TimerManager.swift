//
//  TimerManager.swift
//  RecipeCatalog
//
//  Created by Copilot on 3/29/26.
//

import Foundation

@Observable
@MainActor
class TimerManager {
    var activeTimers: [TimerItem] = []
    var completedTimers: [TimerItem] = []

    private var countdownTimer: Timer?

    // MARK: - Public API

    func addTimer(title: String, duration: TimeInterval) {
        let item = TimerItem(title: title, duration: duration)
        activeTimers.append(item)
        startCountdownIfNeeded()
    }

    /// Dismiss (acknowledge) the first completed timer and move to the next one.
    func dismissFirstCompleted() {
        guard !completedTimers.isEmpty else { return }
        completedTimers.removeFirst()
    }

    // MARK: - Private

    private func startCountdownIfNeeded() {
        guard countdownTimer == nil else { return }
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }

    private func stopCountdown() {
        countdownTimer?.invalidate()
        countdownTimer = nil
    }

    private func tick() {
        var justCompleted: [TimerItem] = []

        for index in activeTimers.indices {
            activeTimers[index].remainingTime -= 1
            if activeTimers[index].remainingTime <= 0 {
                activeTimers[index].remainingTime = 0
                justCompleted.append(activeTimers[index])
            }
        }

        activeTimers.removeAll { $0.remainingTime <= 0 }
        completedTimers.append(contentsOf: justCompleted)

        if activeTimers.isEmpty {
            stopCountdown()
        }
    }
}
