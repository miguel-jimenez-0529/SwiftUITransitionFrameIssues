// Created by miguel_jimenez on 9/27/23.
// Copyright © 2023 Airbnb Inc. All rights reserved.

import Foundation
import Combine
import SwiftUI

final class StateStore: ObservableObject {
  @Published var presentation: Bool = false
  @Published var useRoot1: Bool = true
}
