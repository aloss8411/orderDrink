//
//  GetList.swift
//  orderDrink
//
//  Created by Lan Ran on 2021/12/15.
//

import Foundation


struct getData:Codable{
    
    var records:[recordsList]
    
    struct recordsList:Codable{
       
        var fields:fields
        var id:String
        struct fields:Codable{
            
            var name:String? = nil
            var drinks:String
            var price:String
            var Sugar:String
            var Ice:String
        }
    }
}


struct dataDelete:Codable{
    
    
        var id:String
        var deleted:Bool
    
}
