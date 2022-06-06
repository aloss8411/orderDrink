//
//  shopCarVC.swift
//  orderDrink
//
//  Created by Lan Ran on 2021/11/2.
//

import UIKit

class shopCarVC: UITableViewController{
      
    var record:getData? = nil{
        didSet{
            //值被更新後開始此段程式
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                self.tableView.reloadData()
            }
          
        }
        willSet{
            //值被更新前就開始此段程式
            DispatchQueue.main.async {
                self.indicator.startAnimating()
                self.indicator.isHidden = false
            }
            
        }
        
    }
    var deleteRecords:dataDelete?
    var IdRecords:[String]?
    let indicator = UIActivityIndicatorView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadData()
        tableView.addSubview(indicator)
        indicator.center = view.center
        indicatorSwitch(indicator: indicator, status: false)
        
        
    }
    
   
    
    
    
    @IBAction func ResetTable(_ sender: UIBarButtonItem) {
        if record?.records.count != 0{
            indicatorSwitch(indicator: indicator, status: true)
            
        }
        
        downloadData()
        tableView.reloadData()
      
    }
  
    
    //利用Property observer檢查indicator是否該出現
    
    

    
    //開啟與關閉
    func indicatorSwitch(indicator:UIActivityIndicatorView,status:Bool){
      
        if status == true{
            indicator.stopAnimating()
            indicator.isHidden = true
        }
        else {
            indicator.startAnimating()
            indicator.isHidden = false
        }
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
                        try self.record = decoder.decode(getData.self, from: data)
                
                    }
                    catch{
                        print(error)
                    }
                }
                
            }.resume()
    }
    
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
        cell.userName.text = record?.records[indexPath.row].fields.name
        cell.drinkName.text = record?.records[indexPath.row].fields.drinks
        cell.drinkPrice.text = record?.records[indexPath.row].fields.price
        cell.drinkSugar.text = record?.records[indexPath.row].fields.Sugar
        cell.drinkIce.text = record?.records[indexPath.row].fields.Ice
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        cell.date.text = record?.records[indexPath.row].createdTime
        cell.BGViews.backgroundColor = .orange
        cell.BGViews.layer.cornerRadius = 20
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

        
   
    
    
    
}






