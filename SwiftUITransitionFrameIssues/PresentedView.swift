// Created by miguel_jimenez on 9/27/23.
// Copyright © 2023 Airbnb Inc. All rights reserved.

import SwiftUI

struct PresentedView: View {

  @ObservedObject var store: StateStore

  var body: some View {
    VStack(spacing: 20) {
      Text("Presented Screen")
        .font(.largeTitle)

      Button("Dismiss presentation Screen") {
        store.presentation = false
      }
      
      Button("Swap Root") {
        store.useRoot1.toggle()
      }
    }
  }
}
