//
//  TransactionCell.swift
//  TransactionBud
//
//  Created by George Cremer on 17/04/2021.
//

import UIKit

class TransactionCell: UITableViewCell {
    @IBOutlet var icon: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var category: UILabel!
    @IBOutlet var amount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        // Remove cell highlight on selection
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        selectedBackgroundView = backgroundView

        // Add tint to colour the checkmarks
        tintColor = .systemRed
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
