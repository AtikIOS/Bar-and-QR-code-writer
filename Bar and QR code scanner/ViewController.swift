//
//  ViewController.swift
//  Bar and QR code scanner
//
//  Created by Atik Hasan on 8/11/24.
//

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    
    @IBAction func qrBtnAction(_ sender: UIButton)
    {
        if let qrcontroller = self.storyboard?.instantiateViewController(identifier: "QRController") as? QRController{
                   self.navigationController?.pushViewController(qrcontroller, animated: false)
               }

    }
    @IBAction func barBtnAction(_ sender: UIButton)
    {
        if let barcontroller = self.storyboard?.instantiateViewController(identifier: "BARController") as? BARController{
                   self.navigationController?.pushViewController(barcontroller, animated: false)
               }
    }
    
}

