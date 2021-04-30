//
//  ViewController.swift
//  pdfExample
//
//  Created by K, Senthil Kumar EX1 on 27/04/21.
//

import UIKit
import PDFKit

class ViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var webview: UIWebView!
    
    @IBAction func showPdfAction(_ sender: Any) {
        loadPDF(filename: "file")
    }
    @IBAction func createPdf(_ sender: Any) {
        
        createPDF()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "PDF"
        
//        let someString = "%PDF-1.7%"
//        let version = Data(someString.utf8)
//        print(data)
//
//        let str = String(decoding: data, as: UTF8.self)
//        print(str)

    }
    
    func loadPDF(filename: String) {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let url = URL(fileURLWithPath: documentsPath, isDirectory: true).appendingPathComponent(filename).appendingPathExtension("pdf")
        let urlRequest = URLRequest(url: url)
        self.webview.loadRequest(urlRequest)
    }
    
    func createPDF() {
        let html = "<b>Hello <i>Lorem Ipsum!</i></b> <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum</p>"
        
        let fmt = UIMarkupTextPrintFormatter(markupText: html)

        // 2. Assign print formatter to UIPrintPageRenderer

        let render = UIPrintPageRenderer()
        render.addPrintFormatter(fmt, startingAtPageAt: 0)

        // 3. Assign paperRect and printableRect

        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
        let printable = page.insetBy(dx: 0, dy: 0)

        render.setValue(NSValue(cgRect: page), forKey: "paperRect")
        render.setValue(NSValue(cgRect: printable), forKey: "printableRect")

        // 4. Create PDF context and draw
        let someString = "%PDF-1.7"
        let version = Data(someString.utf8)

        let pdfData = NSMutableData()
        pdfData.append(version)
        UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)

        for i in 1...render.numberOfPages {
            UIGraphicsBeginPDFPage();
            let bounds = UIGraphicsGetPDFContextBounds()
            render.drawPage(at: i - 1, in: bounds)
        }

        UIGraphicsEndPDFContext();

        // 5. Save PDF file

        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

        pdfData.write(toFile: "\(documentsPath)/file.pdf", atomically: true)
    }


    func sam(){
        
        var pdf = createPDF().m
    }
  
}

