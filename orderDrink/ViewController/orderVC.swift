//
//  orderVC.swift
//  orderDrink
//
//  Created by Lan Ran on 2021/11/2.
//

import UIKit


class orderVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
   
    var menuList:[menu]?
 
    var selectIce:String?
    var selectSugar:String?
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
        if nameTextfield.text == ""{
            orderDidNotSendAlert()
        }
        else{
        
            checkIceAndSugar()
            orderDidSendAlert()
            uploadData()
        }
        
    }
    
   
    
    func uploadData(){
        
        let url = URL(string:"https://api.airtable.com/v0/appBZkBtGa7uo2dwl/Drink")
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.setValue("Bearer keyNMHPt7q3Zjx0Ne", forHTTPHeaderField: "Authorization")
        let encoder = JSONEncoder()
        let date  = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let currentDatString = formatter.string(from: date)
        let currentDay = formatter.date(from: currentDatString)
       
        let datas = PostData(records:[.init(fields: .init(name:nameTextfield.text!,drinks: selectName!, Ice: selectIce!, Sugar: selectSugar!, date:currentDay! , price: String(selectPrice!)))])
        
        //設定格式
        encoder.dateEncodingStrategy = .formatted(formatter)
        request.httpBody = try? encoder.encode(datas)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let content = String(data: data, encoding: .utf8)
                let decoder = JSONDecoder()
                let PostDataList = try? decoder.decode(PostDataResponse.self, from: data)
                
            }
        }.resume()
    }
    
    
    
    
    
    //訂單內容
    func getPlistData(){
    
        let url = Bundle.main.url(forResource: "drinkList", withExtension: "plist")
        if let data = try? Data(contentsOf: url!),let drinks = try? PropertyListDecoder().decode([menu].self, from: data) {
            menuList = drinks
        }
    }
   
    func orderDidSendAlert(){
        let controller = UIAlertController(title: "已加入訂單", message:"若要修改請至訂單頁" , preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {_ in
            controller.dismiss(animated: true, completion: nil)
        })
        controller.addAction(action)
        
        
        present(controller, animated: true, completion: nil)
    }
    func orderDidNotSendAlert(){
        let controller = UIAlertController(title: "有資料未填寫", message:"請填寫後再次送出" , preferredStyle: .alert)
        let action = UIAlertAction(title: "確認", style: .default, handler: {_ in
            controller.dismiss(animated: true, completion: nil)
        })
        controller.addAction(action)
        
        
        present(controller, animated: true, completion: nil)
    }
  
    
    func checkIceAndSugar(){
        switch ice.selectedSegmentIndex{
        case 0:
            selectIce = "去冰"
        case 1:
            selectIce = "微冰"
        case 2:
            selectIce = "少冰"
        default :
            selectIce = "正常"
        }
        
        switch sugar.selectedSegmentIndex{
        case 0 :
            selectSugar = "無糖"
        case 1 :
            selectSugar = "微糖"
        case 2 :
            selectSugar = "少糖"
        default:
            selectSugar = "全糖"
        }
    }
}



extension orderVC{
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        menuList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "orderCell", for: indexPath) as! orderCell
        
        
        cell.pics.image = UIImage(named: "image\(indexPath.row)")
        cell.drinkName.text = menuList?[indexPath.row].name
        cell.drinkPrice.text = "\(String(describing: menuList?[indexPath.row].price))"
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectName = menuList?[indexPath.row].name
        selectPrice = menuList?[indexPath.row].price
        
        //儲存所選擇的變數
        
    }
    /*

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        <#code#>
    }
     */
    
    
}


