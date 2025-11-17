//
//  EditCategoryView.swift
//  RecipeCatalog
//
//  Created by Davis Larson on 11/16/25.
//

import SwiftUI

struct EditInstructionView: View {
    @Bindable var instruction: Instruction
    @Environment(\.dismiss) private var dismiss
    
    @State private var text: String
    
    init(instruction: Instruction) {
        self.instruction = instruction
        _text = State(initialValue: instruction.text)
    }
    
    var body: some View {
        Form {
            Section("Step \(instruction.order)") {
                TextEditor(text: $text)
                    .frame(minHeight: 150)
            }
        }
        .navigationTitle("Edit Instruction")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    instruction.text = text
                    dismiss()
                }
            }
        }
    }
}

#Preview {
//    EditInstructionView()
}
