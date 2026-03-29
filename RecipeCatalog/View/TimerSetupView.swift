//
//  TimerSetupView.swift
//  RecipeCatalog
//
//  Created by Copilot on 3/29/26.
//

import SwiftUI

struct TimerSetupView: View {
    @Environment(TimerManager.self) private var timerManager
    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""
    @State private var hours: Int = 0
    @State private var minutes: Int = 5
    @State private var seconds: Int = 0

    private var totalSeconds: TimeInterval {
        TimeInterval(hours * 3600 + minutes * 60 + seconds)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Timer Title") {
                    TextField("e.g. Cake in oven", text: $title)
                }

                Section("Duration") {
                    HStack(spacing: 0) {
                        Picker("Hours", selection: $hours) {
                            ForEach(0..<24, id: \.self) { h in
                                Text("\(h)h").tag(h)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(maxWidth: .infinity)

                        Picker("Minutes", selection: $minutes) {
                            ForEach(0..<60, id: \.self) { m in
                                Text("\(m)m").tag(m)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(maxWidth: .infinity)

                        Picker("Seconds", selection: $seconds) {
                            ForEach(0..<60, id: \.self) { s in
                                Text("\(s)s").tag(s)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(maxWidth: .infinity)
                    }
                    .frame(height: 150)
                }
            }
            .navigationTitle("New Timer")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Start") {
                        let timerTitle = title.trimmingCharacters(in: .whitespaces)
                        timerManager.addTimer(
                            title: timerTitle.isEmpty ? "Timer" : timerTitle,
                            duration: totalSeconds
                        )
                        dismiss()
                    }
                    .disabled(totalSeconds == 0)
                }
            }
        }
    }
}

#Preview {
    TimerSetupView()
        .environment(TimerManager())
}
