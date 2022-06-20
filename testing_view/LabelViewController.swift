//
//  LabelViewController.swift
//  testing_view
//
//  Created by Mark Kim on 6/19/22.
//

import UIKit

class LabelViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var labelView: LabelView?
    var pickerView: PickerView?
    var statsView: StatsView?

    // data
    var pickerData: [String]

    private var labelSize: CGSize
    private var pickerSize: CGSize
    private var statsSize: CGSize

    init(labelSize: CGSize, pickerSize: CGSize, statsSize: CGSize) {
        self.pickerData = ["hello", "world", "my", "name", "is", "mark"]
        self.labelSize = labelSize
        self.pickerSize = pickerSize
        self.statsSize = statsSize
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.clipsToBounds = true

        setupLabelView()
        setupPickerView()
        setupStatsView()
        setupConstraints()
    }

    func setupLabelView() {
        let frame = CGRectMake(0.5 * (view.bounds.width - labelSize.width), 0.0, labelSize.width, labelSize.height)
        let labelView = LabelView(frame: frame)
        labelView.title = "Testing"
        view.addSubview(labelView)

        self.labelView = labelView
    }

    func setupPickerView() {
        guard let labelView = labelView else {
            return
        }
        let frame = CGRectMake(0.5 * (view.bounds.width - pickerSize.width), labelView.frame.maxY, pickerSize.width, pickerSize.height)
        let pickerView = PickerView(frame: frame)
        pickerView.pickerView?.delegate = self
        pickerView.pickerView?.dataSource = self
        pickerView.pickerView?.selectRow(1, inComponent: 0, animated: false)
        view.addSubview(pickerView)

        self.pickerView = pickerView
    }

    func setupStatsView() {
        guard let pickerView = pickerView else {
            return
        }
        let frame = CGRectMake(0.5 * (view.bounds.width - statsSize.width), pickerView.frame.maxY, statsSize.width, statsSize.height)
        let statsView = StatsView(frame: frame)
        statsView.updateDimensions(width: 2.5, height: 3.8, length: 4.2)
        view.addSubview(statsView)

        self.statsView = statsView
    }

    func setupConstraints() {
        guard let labelView = labelView,
              let pickerView = pickerView,
              let statsView = statsView
        else {
            return
        }

        labelView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        statsView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            labelView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            labelView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            labelView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            labelView.heightAnchor.constraint(equalToConstant: labelSize.height),

            pickerView.topAnchor.constraint(equalToSystemSpacingBelow: labelView.bottomAnchor, multiplier: 1.0),
            pickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: pickerSize.height),

            statsView.topAnchor.constraint(equalToSystemSpacingBelow: pickerView.bottomAnchor, multiplier: 1.0),
            statsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            statsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            statsView.heightAnchor.constraint(equalToConstant: statsSize.height),
        ])
    }
}

// MARK: - UIPickerViewDelegate

extension LabelViewController {
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return self.view.bounds.width
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        guard let selectedObjectNode = selectedObjectNode
//        else {
//            return
//        }
//        let text = pickerData[row]
//        selectedObjectNode.updateEditingLabelText(with: text)
    }
}

// MARK: - UIPickerViewDatasource

extension LabelViewController {
    // returns the number of 'columns' to display.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
}
