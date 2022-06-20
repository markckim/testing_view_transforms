//
//  ViewController.swift
//  testing_view
//
//  Created by Mark Kim on 6/19/22.
//

import UIKit

class ViewController: UIViewController {

    var testView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
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

    func showBottomSheet() {
        let vc = UIViewController()

        vc.view.backgroundColor = UIColor.systemGray6

        let nav = UINavigationController(rootViewController: vc)
        nav.isModalInPresentation = true
        nav.modalPresentationStyle = .pageSheet
        if let sheetPresentationController = nav.sheetPresentationController {
            sheetPresentationController.detents = [.medium()]
        }

        self.present(nav, animated: false, completion: nil)
    }

    @IBAction func didTapTestButton(_ sender: Any) {
        showBottomSheet()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // animate scale down
            if let presentedViewController = self.presentedViewController, let presentedView = presentedViewController.view {
                UIView.animate(withDuration: 1.0) {
                    let x0 = 0.5 * self.view.bounds.width
                    let y0 = self.view.bounds.height - 0.5 * presentedView.bounds.height
                    let x1 = 0.5 * self.view.bounds.width
                    let y1 = 0.5 * self.view.bounds.height
                    let dx = x1 - x0
                    let dy = y1 - y0
                    let translation = CGAffineTransform(translationX: dx, y: dy)

                    let scale = CGAffineTransform(scaleX: 0.1, y: 0.1)

                    let combinedTransform = scale.concatenating(translation)
                    presentedView.transform = combinedTransform
                } completion: { success in
                    self.dismiss(animated: false)
                }
            }
        }
    }
}
