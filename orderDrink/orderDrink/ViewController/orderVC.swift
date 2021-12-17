//
//  orderVC.swift
//  orderDrink
//
//  Created by Lan Ran on 2021/11/2.
//

import UIKit




class orderVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
   
    var menus:[menu]?
 
    var iceDegree:String?
    var sugarDegree:String?
    var selectPrice:Int?
    var selectName:String?
    
    
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var ice: UISegmentedControl!
    @IBOutlet weak var sugar:UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPlistData()
    }
   
    
    @IBAction func sendList(_ sender: Any) {
        checkIceAndSugar()
        orderDidSendAlert()
        
        uploadData()
    }
    
   
    
    func uploadData(){
        
        let url = URL(string:"https://api.airtable.com/v0/appBZkBtGa7uo2dwl/Drink")
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.setValue("Bearer keyNMHPt7q3Zjx0Ne", forHTTPHeaderField: "Authorization")
        
        let encoder = JSONEncoder()
        let date = DateComponents(calendar: .current, year: 2021, month: 12, day: 21, hour: 10).date!
        let datas = PostData(records:[.init(fields: .init(name:nameTextfield.text!,drinks: selectName!, Ice: iceDegree!, Sugar: sugarDegree!, date: date, price: String(selectPrice!)))])
        
        //設定格式
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.string(from: Date())
        encoder.dateEncodingStrategy = .formatted(formatter)
        
        request.httpBody = try? encoder.encode(datas)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let content = String(data: data, encoding: .utf8)
                let decoder = JSONDecoder()
                let PostDataList = try? decoder.decode(PostDataResponse.self, from: data)
                print(PostDataList)
            }
            
        }.resume()
        
        
    }
    
    
    
    
    
    //訂單內容
    func getPlistData(){
    
        let url = Bundle.main.url(forResource: "drinkList", withExtension: "plist")
        if let data = try? Data(contentsOf: url!),let drinks = try? PropertyListDecoder().decode([menu].self, from: data) {
            menus = drinks
        }
    }
   
    func orderDidSendAlert(){
        let controller = UIAlertController(title: "已加入訂單", message:"若要修改請至訂單頁" , preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(action)
        present(controller, animated: true, completion: nil)
    }
    func checkIceAndSugar(){
        switch ice.selectedSegmentIndex{
        case 0:
            iceDegree = "去冰"
        case 1:
            iceDegree = "微冰"
        case 2:
            iceDegree = "少冰"
        default :
            iceDegree = "正常"
        }
        
        switch sugar.selectedSegmentIndex{
        case 0 :
            sugarDegree = "無糖"
        case 1 :
            sugarDegree = "微糖"
        case 2 :
            sugarDegree = "少糖"
        default:
            sugarDegree = "全糖"
        }
    }
}



extension orderVC{
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "orderCell", for: indexPath) as! orderCell
        
        
        cell.pics.image = UIImage(named: "image\(indexPath.row)")
        cell.drinkName.text = menus?[indexPath.row].name
        cell.drinkPrice.text = "\(String(describing: menus?[indexPath.row].price))"
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectName = menus?[indexPath.row].name
        selectPrice = menus?[indexPath.row].price
        
        //儲存所選擇的變數
        
    }
    /*

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        <#code#>
    }
     */
    
    
}


