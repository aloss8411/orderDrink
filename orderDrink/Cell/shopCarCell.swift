//
//  shopCarCell.swift
//  orderDrink
//
//  Created by Lan Ran on 2021/11/2.
//

import UIKit

class shopCarCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var drinkName: UILabel!
    @IBOutlet weak var drinkIce: UILabel!
    @IBOutlet weak var drinkSugar: UILabel!
    @IBOutlet weak var drinkPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
