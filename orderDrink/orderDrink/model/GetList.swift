//
//  GetList.swift
//  orderDrink
//
//  Created by Lan Ran on 2021/12/15.
//

import Foundation


struct dataGet:Codable{
    
    var records:[recordsList]
    
    struct recordsList:Codable{
       
        var fields:fields
       
        struct fields:Codable{
            
            var name:String
            var drinks:String
            var price:String
            var Sugar:String
            var Ice:String
        }
    }
}

