import UIKit

class QRController: UIViewController {
    
    @IBOutlet weak var textFeild: UITextField!
    @IBOutlet weak var imgField: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func submitAciton(_ sender: UIButton)
    {
        guard let myData = textFeild.text, !myData.isEmpty else { return }
        //        let data = myData.data(using: .ascii, allowLossyConversion: false)
        //        let barCode = CIFilter(name: "CIQRCodeGenerator")
        //        barCode?.setValue(data, forKey: "inputMessage")
        //        barCode?.setValue("Q", forKey: "inputCorrectionLevel")
        //
        //        guard let ciImage = barCode?.outputImage else { return }
        //
        //        let scaleX = imgField.frame.size.width / ciImage.extent.size.width
        //        let scaleY = imgField.frame.size.height / ciImage.extent.size.height
        //        let scaledImage = ciImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        //        let uiImage = UIImage(ciImage: scaledImage)
        //        imgField.image = uiImage
        //        textFeild.text = ""
        let data = myData.data(using: String.Encoding.ascii)
        
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                let QRcodeImage = UIImage(ciImage: output)
                self.imgField.image = QRcodeImage
                self.forPdf(image: QRcodeImage)
            }
        }
    }
    
    func forPdf(image : UIImage?) {
        if let image = image {
            let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent("output.pdf")
            print(fileURL)
            convertImageToPDF(image: image, outputURL: fileURL)
        }

    }

    func convertImageToPDF(image: UIImage, outputURL: URL) {
        // A4 সাইজের পেজ (595 x 842 পিক্সেল) অনুযায়ী পিডিএফ পেজ তৈরি করুন
        let pageWidth: CGFloat = 595.0
        let pageHeight: CGFloat = 842.0
        
        // Create a PDF renderer format
        let pdfRendererFormat = UIGraphicsPDFRendererFormat()
        pdfRendererFormat.documentInfo = ["Title": "Converted Image"]

        // Define the PDF renderer's bounds (A4 সাইজে)
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight), format: pdfRendererFormat)
        
        // Create the PDF data with error handling
        do {
            try pdfRenderer.writePDF(to: outputURL, withActions: { (context) in
                // Start a new page
                context.beginPage()

                // Calculate the X and Y positions to center the image on the A4 page
                let imageWidth = image.size.width
                let imageHeight = image.size.height

                // Calculate the position to center the image
                let xPos = (pageWidth - imageWidth) / 2
                let yPos = (pageHeight - imageHeight) / 2

                // Draw the image at the center of the page
                image.draw(in: CGRect(x: xPos, y: yPos, width: imageWidth, height: imageHeight))
            })
            
            print("PDF saved to: \(outputURL)")
        } catch {
            print("Error generating PDF: \(error.localizedDescription)")
        }
    }


}


