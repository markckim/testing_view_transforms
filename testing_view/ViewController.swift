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
        createAndSetupTestView()
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

    @IBAction func didTapTestButton(_ sender: Any) {
        guard let testView = testView else {
            return
        }

        // position
        let initialTranslation = CGAffineTransform(translationX: 100, y: -200)
        let initialScale = CGAffineTransform(scaleX: 0.1, y: 0.1)
        let combinedInitialTransform = initialScale.concatenating(initialTranslation)

        testView.transform = combinedInitialTransform

        UIView.animate(withDuration: 0.5) {
            testView.transform = CGAffineTransform(scaleX: 1, y: 1)
        } completion: { success in
            // do stuff
        }
    }
}
