// Created by miguel_jimenez on 9/27/23.
// Copyright © 2023 Airbnb Inc. All rights reserved.

import SwiftUI

struct NavRootView: View {

  @ObservedObject var store: StateStore
  let name: String

  var body: some View {
    ScrollView {
      VStack(spacing: 20) {
        Text("Root Screen Id \(name)")
          .font(.largeTitle)

        Button("Present Screen") {
          store.presentation = true
        }

        Button("Swap Root") {
          store.useRoot1.toggle()
        }
      }
    }
  }
}
