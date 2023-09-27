// Created by miguel_jimenez on 9/27/23.
// Copyright © 2023 Airbnb Inc. All rights reserved.

import UIKit
import SwiftUI
import Combine

class ViewController: UINavigationController {

  let store = StateStore()
  var subscriptions: [AnyCancellable] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    subscriptions.append(store.$presentation
      .dropFirst()
      .sink(receiveValue: { [weak self] value in
        self?.handlePresentation(presentation: value)
      }))

    subscriptions.append(store.$useRoot1
      .dropFirst()
      .sink(receiveValue: { [weak self] _ in
        self?.setRootView()
      }))

    setRootView()
  }

  func setRootView() {
    let rootViewId = store.useRoot1 ? "1" : "2"
    let view = NavRootView(store: store, name: rootViewId)
    let rootViewController = UIHostingController(rootView: view)
    self.viewControllers = [rootViewController]
  }

  func handlePresentation(presentation: Bool) {
    if presentation, presentedViewController == nil {
      // Build viewController
      let presentedView = PresentedView(store: store)
      let viewController = UIHostingController(rootView: presentedView)
      // Configure custom transition
      viewController.modalPresentationStyle = .custom
      viewController.transitioningDelegate = self
      // Perform presentation
      present(viewController, animated: true)
    } else if !presentation, presentedViewController != nil {
      presentedViewController?.dismiss(animated: true)
    }
  }
}

extension ViewController: UIViewControllerTransitioningDelegate {
  func presentationController(
    forPresented presented: UIViewController,
    presenting: UIViewController?,
    source: UIViewController) -> UIPresentationController? {
      CustomPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
