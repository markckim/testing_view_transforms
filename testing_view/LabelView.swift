//
//  LabelView.swift
//  testing_view
//
//  Created by Mark Kim on 6/19/22.
//

import UIKit

class LabelView: UIView {
    var title: String? {
        get {
            return titleLabel?.text
        }
        set {
            titleLabel?.text = newValue
        }
    }

    private var titleLabel: UILabel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }

    func setupView() {
        self.backgroundColor = UIColor.systemTeal

        titleLabel = UILabel()
        guard let titleLabel = titleLabel else {
            return
        }
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
    }

    func setupConstraints() {
        guard let titleLabel = titleLabel else {
            return
        }

        // this is very important
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
        ])
    }
}
