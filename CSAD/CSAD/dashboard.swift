//
//  dashboard.swift
//  CSAD
//
//  Created by Sarthak Mangla on 12/17/18.
//  Copyright © 2018 Sarthak Mangla. All rights reserved.
//

import UIKit

class dashboard: UIViewController {
    @IBOutlet weak var witnessbutton: UIButton!
    @objc func wit(){
        performSegue(withIdentifier: "witnessedaccident",sender: (Any).self)
    }
    
    @IBAction func witness(_ sender: Any) {
        witnessbutton.setImage(UIImage(named :"ButtonPressed"), for: .normal)
        _ = Timer.scheduledTimer(timeInterval: 0.5 , target:self, selector: #selector((back)), userInfo: nil, repeats: false)
        _ = Timer.scheduledTimer(timeInterval: 1 , target:self, selector: #selector((wit)), userInfo: nil, repeats: false)
    }
    
    @objc func back(){
        witnessbutton.setImage(UIImage(named :"ButtonNormal"), for: .normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        witnessbutton.setImage(UIImage(named :"ButtonNormal"), for: .normal)
        // Do any additional setup after loading the view.
    }
    
    

}
