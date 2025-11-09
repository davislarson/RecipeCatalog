//
//  SwiftDataViewModel.swift
//  Sample SwiftData App
//
//  Created by Davis Larson on 10/30/25.
//

import SwiftUI
import SwiftData

protocol ContextReferencing {
    init(modelContext: ModelContext)
    func update()
}

// This file create a custom property wrapper, has a generic type and conforms to dynamicproperty to allow it to update the state
// This was developed by a guy that believes that swiftdata is compatable with MVVM
@propertyWrapper struct SwiftDataViewModel<VM: ContextReferencing>: DynamicProperty {
    @State var viewModel: VM?
    
    // This is supplied by the model container when initializing the app
    @Environment(\.modelContext) private var modelContext
    
    var wrappedValue: VM {
        guard let viewModel else {
            fatalError("Attempt to access nil viewmodel as wrappedValue")
        }
        return viewModel
    }
    
    var projectedValue: Binding<VM> {
        Binding(
            get:{
                guard let viewModel else {
                    fatalError()
            }
                return viewModel
        }, set:
            { newValue in
                viewModel = newValue
            }
        )
    }
    
    mutating func update() {
        if viewModel == nil {
            _viewModel = State(initialValue: VM(modelContext: modelContext))
        }
        viewModel?.update()
    }
}
