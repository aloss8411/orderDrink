//
//  orderVC.swift
//  orderDrink
//
//  Created by Lan Ran on 2021/11/2.
//

import UIKit
import CollectionViewPagingLayout


class orderVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
   
    var menuList:[menu]?
 
    var selectIce:String?
    var selectSugar:String?
    var selectPrice:Int?
    var selectName:String?
    
    let layout = CollectionViewPagingLayout()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var ice: UISegmentedControl!
    @IBOutlet weak var sugar:UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPlistData()
        setupCollectionView()
        collectionView.collectionViewLayout = layout
    }
  
    private func setupCollectionView() {
          
            collectionView.isPagingEnabled = true
            collectionView.dataSource = self
            view.addSubview(collectionView)
        }
    
    @IBAction func sendList(_ sender: Any) {
        if nameTextfield.text?.isEmpty == true || nameTextfield.text == "" || selectName == nil{
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
        request.setValue("Bearer keyNMHPt7q3Zjx0Ne", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        let date  = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let currentDatString = formatter.string(from: date)
        let currentDay = formatter.date(from: currentDatString)
       
        let datas = PostData(records:[.init(fields: .init(name:nameTextfield.text!,drinks: selectName!, Ice: selectIce!, Sugar: selectSugar!, date:currentDay! , price: String(selectPrice!)))])
        
        //????????????
        encoder.dateEncodingStrategy = .formatted(formatter)
        request.httpBody = try? encoder.encode(datas)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                
                let decoder = JSONDecoder()
                let _ = try? decoder.decode(PostDataResponse.self, from: data)
                
            }
        }.resume()
    }
    
    
    
    
    
    //????????????
    func getPlistData(){
    
        let url = Bundle.main.url(forResource: "drinkList", withExtension: "plist")
        if let data = try? Data(contentsOf: url!),let drinks = try? PropertyListDecoder().decode([menu].self, from: data) {
            menuList = drinks
        }
    }
   
    func orderDidSendAlert(){
        let controller = UIAlertController(title: "???????????????", message:"???????????????????????????" , preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {_ in
            controller.dismiss(animated: true, completion: nil)
        })
        controller.addAction(action)
        
        
        present(controller, animated: true, completion: nil)
    }
    func orderDidNotSendAlert(){
        let controller = UIAlertController(title: "??????????????????", message:"????????????????????????" , preferredStyle: .alert)
        let action = UIAlertAction(title: "??????", style: .default, handler: {_ in
            controller.dismiss(animated: true, completion: nil)
        })
        controller.addAction(action)
        
        
        present(controller, animated: true, completion: nil)
    }
  
    
    func checkIceAndSugar(){
        switch ice.selectedSegmentIndex{
        case 0:
            selectIce = "??????"
        case 1:
            selectIce = "??????"
        case 2:
            selectIce = "??????"
        default :
            selectIce = "??????"
        }
        
        switch sugar.selectedSegmentIndex{
        case 0 :
            selectSugar = "??????"
        case 1 :
            selectSugar = "??????"
        case 2 :
            selectSugar = "??????"
        default:
            selectSugar = "??????"
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
        if let list = menuList?[indexPath.row]{
            cell.drinkPrice.text = String(list.price) + "???"
        }
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        selectName = menuList?[indexPath.row].name ?? "???????????????"
        selectPrice = menuList?[indexPath.row].price ?? 0
        
      
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "orderCell", for: indexPath) as! orderCell
        cell.BGView.backgroundColor = .clear
    }
   
    
    
}


