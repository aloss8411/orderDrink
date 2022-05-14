//
//  orderCell.swift
//  orderDrink
//
//  Created by Lan Ran on 2021/11/2.
//

import UIKit
import CollectionViewPagingLayout

class orderCell: UICollectionViewCell {
    
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var drinkPrice: UILabel!
    @IBOutlet weak var drinkName: UILabel!
    @IBOutlet weak var pics: UIImageView!
}


extension orderCell:ScaleTransformView{
   
    var scaleOptions: ScaleTransformViewOptions {
            .layout(.linear)
        }

}
