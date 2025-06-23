//
//  BARController.swift
//  Bar and QR code scanner
//
//  Created by Atik Hasan on 8/11/24.
//

import UIKit

class BARController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
   
    @IBOutlet weak var textFeild: UITextField!
    @IBOutlet weak var imgField: UIImageView!
    @IBAction func submitAciton(_ sender: UIButton)
    {
        guard let myData = textFeild.text, !myData.isEmpty else { return }
        let data = myData.data(using: .ascii, allowLossyConversion: false)
        let barCode = CIFilter(name: "CICode128BarcodeGenerator")
        barCode?.setValue(data, forKey: "inputMessage")
        barCode?.setValue("M", forKey: "inputQuietSpace")
        
        guard let ciImage = barCode?.outputImage else { return }
        
        let scaleX = imgField.frame.size.width / ciImage.extent.size.width
        let scaleY = imgField.frame.size.height / ciImage.extent.size.height
        let scale = max(scaleX, scaleY)
        let scaledImage = ciImage.transformed(by: CGAffineTransform(scaleX: scale, y: scale))
        let uiImage = UIImage(ciImage: scaledImage)
        imgField.image = uiImage
        textFeild.text = ""
    }

}
