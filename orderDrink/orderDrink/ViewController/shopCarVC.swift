//
//  shopCarVC.swift
//  orderDrink
//
//  Created by Lan Ran on 2021/11/2.
//

import UIKit

class shopCarVC: UITableViewController{
      
    var record:dataGet?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
    
    @IBAction func ResetTable(_ sender: UIBarButtonItem) {
        downloadData()
        tableView.reloadData()
        
    }
  

    func downloadData(){
            
            let url = URL(string:"https://api.airtable.com/v0/appBZkBtGa7uo2dwl/Drink?maxRecords=20&view=Grid%20view")
            var request = URLRequest(url: url!)
            request.httpMethod = "GET"
            request.setValue("Bearer keyNMHPt7q3Zjx0Ne", forHTTPHeaderField: "Authorization")
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    
                    do{
                        try self.record = decoder.decode(dataGet.self, from: data)
                    }
                    catch{
                        print(error)
                    }
                }
                
            }.resume()
        
    }
    
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        record?.records.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopCarCell", for: indexPath) as! shopCarCell
        cell.drinkName.text = record?.records[indexPath.row].fields.drinks
        cell.drinkPrice.text = record?.records[indexPath.row].fields.price
        cell.drinkSugar.text = record?.records[indexPath.row].fields.Sugar
        cell.drinkIce.text = record?.records[indexPath.row].fields.Ice
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }

    //delete
    
    override func tableView(_ tableView: UITableView, commit editingStyle:UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.deselectRow(at: indexPath, animated: true)
        }
        else if editingStyle == .insert{
            
        }
    }
    
}

//傳遞資料的製作
extension shopCarVC{
    
    //download data from airtable
    
    
    
}





