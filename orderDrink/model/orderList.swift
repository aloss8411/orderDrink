//
//  orderList.swift
//  orderDrink
//
//  Created by Lan Ran on 2021/11/29.
//

import Foundation

//download



//upload
struct PostData:Encodable{
    var records:[postrecords]
    
    struct postrecords:Encodable{
       
        
        var fields:postfields
        
        struct postfields:Encodable{
           
            var name:String
            var drinks:String
            var Ice:String
            var Sugar:String
            var date:Date
            var price:String
            
            enum CodingKeys:String,CodingKey{
                case date = "release date"
                case name = "name"
                case drinks = "drinks"
                case Ice = "Ice"
                case Sugar = "Sugar"
                case price = "price"
            }
        }
    }
}

struct PostDataResponse:Codable{
    var records:[postrecords]
    
    struct postrecords:Codable{
       
        var id:String
        }
    }



struct menu:Codable{
    
    var name:String
    var price:Int
    
}


