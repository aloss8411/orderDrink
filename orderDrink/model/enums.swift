//
//  enums.swift
//  orderDrink
//
//  Created by Lan Ran on 2021/12/14.
//

import Foundation



enum Ice: String, CaseIterable {
    case regularIce = "正常冰"
    case lessIce = "少冰"
    case halfIce = "微冰"
    case noIce = "去冰"
    case roomTemp = "常溫"
    case hot = "熱"
}
enum Sugar: String, CaseIterable {
    case regularSugar = "全糖"
    case lessSugar = "少糖"
    case halfSugar = "半糖"
    case lightSugar = "微糖"
    case noSugar = "無糖"
}
