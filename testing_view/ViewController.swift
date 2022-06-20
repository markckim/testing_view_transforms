//
//  ViewController.swift
//  testing_view
//
//  Created by Mark Kim on 6/19/22.
//

import UIKit

class ViewController: UIViewController {

    var testView: UIView?
    var originalFrame: CGRect = .zero
    var originalCenter: CGPoint = .zero

    var infoView: InfoView?

    override func viewDidLoad() {
        super.viewDidLoad()
        createAndSetupInfoView()
        //createAndSetupLabelVC()
    }

    func createAndSetupTestView() {
        let width = CGFloat(300)
        let height = CGFloat(200)
        let frame = CGRectMake(0.5 * (view.bounds.width - width), 0.5 * (view.bounds.height - height), width, height)

        let testView = LabelView(frame: frame)
        testView.title = "Testing"
        view.addSubview(testView)

        self.testView = testView
    }

    func animateTestView() {
        guard let testView = testView else {
            print("missing testView")
            return
        }

        // position and scale testView
        let initialTranslation = CGAffineTransform(translationX: 100, y: -200)
        let initialScale = CGAffineTransform(scaleX: 0.1, y: 0.1)
        let combinedInitialTransform = initialScale.concatenating(initialTranslation)
        testView.transform = combinedInitialTransform

        UIView.animate(withDuration: 2.0) {
            let translation = CGAffineTransform(translationX: 0, y: 0)
            let scale = CGAffineTransform(scaleX: 1, y: 1)
            let combinedTransform = scale.concatenating(translation)
            testView.transform = combinedTransform

        } completion: { success in
            // do stuff
        }
    }

    override func viewSafeAreaInsetsDidChange() {
        guard let infoView = infoView else {
            return
        }
        var proposedViewSize = infoView.bounds.size
        proposedViewSize.height += view.safeAreaInsets.bottom
        infoView.frame = CGRectMake(0.0, 0.5 * (view.bounds.height - proposedViewSize.height), proposedViewSize.width, proposedViewSize.height)
    }

    func createAndSetupInfoView() {
        let labelSize = CGSizeMake(view.bounds.width, 60)
        let pickerSize = CGSizeMake(view.bounds.width, 160)
        let statsSize = CGSizeMake(view.bounds.width, 80)
        let infoView = InfoView(labelSize: labelSize, pickerSize: pickerSize, statsSize: statsSize)
        infoView.backgroundColor = UIColor.systemGray6
        infoView.sizeToFit()

        var proposedViewSize = infoView.bounds.size
        proposedViewSize.height += view.safeAreaInsets.top + view.safeAreaInsets.bottom
        infoView.frame = CGRectMake(0.0, 0.5 * (view.bounds.height - proposedViewSize.height), proposedViewSize.width, proposedViewSize.height)
        infoView.layer.cornerRadius = 12

        originalFrame = infoView.frame
        originalCenter = infoView.center
        self.infoView = infoView

        view.addSubview(infoView)
    }

    @IBAction func didTapTestButton(_ sender: Any) {
        guard let infoView = infoView else {
            return
        }

        let animationOptions: UIView.AnimationOptions = .curveEaseInOut
        let keyframeAnimationOptions = UIView.KeyframeAnimationOptions(rawValue: animationOptions.rawValue)

        UIView.animateKeyframes(withDuration: 0.75, delay: 0.0, options: keyframeAnimationOptions) {
            let translation = CGAffineTransform(translationX: 0, y: 0)
            let scale = CGAffineTransform(scaleX: 0.1, y: 0.1)
            let combinedTransform = scale.concatenating(translation)
            infoView.transform = combinedTransform
        } completion: { success in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                UIView.animateKeyframes(withDuration: 0.75, delay: 0.0, options: keyframeAnimationOptions) {
                    let x0 = self.originalCenter.x
                    let y0 = self.originalCenter.y
                    let x1 = 0.5 * self.view.bounds.width
                    let y1 = self.view.bounds.height - 0.5 * self.originalFrame.height
                    let dx = x1 - x0
                    let dy = y1 - y0

                    let translation = CGAffineTransform(translationX: dx, y: dy)
                    let scale = CGAffineTransform(scaleX: 1, y: 1)
                    let combinedTransform = scale.concatenating(translation)

                    infoView.transform = combinedTransform
                } completion: { success in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                        UIView.animateKeyframes(withDuration: 0.75, delay: 0.0, options: keyframeAnimationOptions) {
                            let translation = CGAffineTransform(translationX: 0, y: 0)
                            let scale = CGAffineTransform(scaleX: 0.1, y: 0.1)
                            let combinedTransform = scale.concatenating(translation)
                            infoView.transform = combinedTransform
                        } completion: { success in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                                UIView.animateKeyframes(withDuration: 0.75, delay: 0.0, options: keyframeAnimationOptions) {
                                    let translation = CGAffineTransform(translationX: 0, y: 0)
                                    let scale = CGAffineTransform(scaleX: 1, y: 1)
                                    let combinedTransform = scale.concatenating(translation)
                                    infoView.transform = combinedTransform
                                } completion: { success in
                                    // do stuff
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
