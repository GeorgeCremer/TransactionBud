//
//  DeleteButtonBottomTB.swift
//  TransactionBud
//
//  Created by George Cremer on 18/04/2021.
//

import UIKit

class DeleteButtonBottomTB: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        // This would handle init via storyboard, which we aren't using.
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)

        let safeArea = UIApplication.bottomSafeAreaHeight
        if safeArea > 0 {
            titleEdgeInsets = UIEdgeInsets(top: 16, left: 10.0, bottom: UIApplication.bottomSafeAreaHeight, right: 0.0)
        }
    }

    private func configure() {
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
