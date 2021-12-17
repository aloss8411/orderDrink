//
//  loadingVC.swift
//  orderDrink
//
//  Created by Lan Ran on 2021/11/2.
//

import UIKit

class loadingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: {_ in
            
            let intro = self.storyboard?.instantiateViewController(withIdentifier: "intro")
            intro?.modalPresentationStyle = .fullScreen
            self.present(intro!, animated: true, completion: nil)
        })
            
        
        
    }
    

}
