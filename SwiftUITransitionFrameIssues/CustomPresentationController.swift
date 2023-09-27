// Created by miguel_jimenez on 9/27/23.
// Copyright © 2023 Airbnb Inc. All rights reserved.

import UIKit

final class CustomPresentationController: UIPresentationController {

  private lazy var dimmingView: UIView = {
    let dimmingView = UIView()
    dimmingView.translatesAutoresizingMaskIntoConstraints = false
    dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
    dimmingView.alpha = 0.0

    let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
    dimmingView.addGestureRecognizer(recognizer)
    return dimmingView
  }()

  override var frameOfPresentedViewInContainerView: CGRect {
    var frame: CGRect = .zero
    frame.size = size(
      forChildContentContainer: presentedViewController,
      withParentContainerSize: containerView!.bounds.size)

    frame.origin.y = containerView!.frame.height * (1.0/3.0)
    return frame
  }

  override func presentationTransitionWillBegin() {
    guard let containerView = containerView else {
      return
    }
    containerView.insertSubview(dimmingView, at: 0)

    NSLayoutConstraint.activate([
      dimmingView.topAnchor.constraint(equalTo: containerView.topAnchor),
      dimmingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      dimmingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      dimmingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
    ])

    guard let coordinator = presentedViewController.transitionCoordinator else {
      dimmingView.alpha = 1.0
      return
    }

    coordinator.animate(alongsideTransition: { _ in
      self.dimmingView.alpha = 1.0

      let scale = 0.9
      let yTranslation = 40.0
      let transform = CGAffineTransform(translationX: 0, y: yTranslation).scaledBy(x: scale, y: scale)
//      let transform3D = CATransform3DScale(CATransform3DMakeTranslation(0, yTranslation, 0), scale, scale, scale)
      self.presentingViewController.view.transform = transform
//      self.presentingViewController.view.transform3D = transform3D
    })
  }

  override func dismissalTransitionWillBegin() {
    guard let coordinator = presentedViewController.transitionCoordinator else {
      dimmingView.alpha = 0.0
      return
    }

    coordinator.animate(alongsideTransition: { _ in
      self.dimmingView.alpha = 0.0
      self.presentingViewController.view.transform = .identity
//      self.presentingViewController.view.transform3D = CATransform3DIdentity
    })
  }

  override func containerViewWillLayoutSubviews() {
    presentedView?.frame = frameOfPresentedViewInContainerView
  }

  override func size(
    forChildContentContainer container: UIContentContainer,
    withParentContainerSize parentSize: CGSize) -> CGSize
  {
    CGSize(width: parentSize.width, height: parentSize.height * (2.0/3.0))
  }
}

// MARK: - Private
private extension CustomPresentationController {

  @objc func handleTap(recognizer: UITapGestureRecognizer) {
    presentingViewController.dismiss(animated: true)
  }
}
