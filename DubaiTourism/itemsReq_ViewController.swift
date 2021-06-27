//
//  itemsReq_ViewController.swift
//  DubaiTourism
//
//  Created by pruthvi raj dudam on 6/9/21.
//

import UIKit

class itemsReq_ViewController: UIViewController {
    
    var name:String?
    var country:String?
    
    @IBOutlet weak var mainscroll: UIScrollView!
    var imageArray=[UIImage]()
    var scrollVal: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.information(str: self.country!)
        }
    
    func information(str:String){
        switch (str) {
        case "USA":
            imageArray = [UIImage(named: "US1.png")!,UIImage(named: "extra.png")!]
            for i in 0..<imageArray.count {
                let imageView = UIImageView()
                imageView.image = imageArray[i]
                imageView.contentMode = .scaleAspectFit
                let yPosition = self.view.frame.height * CGFloat(i)
                imageView.frame = CGRect(x: 0,y:yPosition,width: self.mainscroll.frame.width,height: self.mainscroll.frame.height)
                mainscroll.contentSize.height = self.view.frame.height*CGFloat(i+1)+250
                mainscroll.addSubview(imageView)
        }
        case "GCC":
            imageArray = [UIImage(named: "GCC.png")!,UIImage(named: "extra.png")!]
            for i in 0..<imageArray.count {
                let imageView = UIImageView()
                imageView.image = imageArray[i]
                imageView.contentMode = .scaleAspectFit
                let yPosition = self.view.frame.height * CGFloat(i)
                imageView.frame = CGRect(x: 0,y:yPosition,width: self.mainscroll.frame.width,height: self.mainscroll.frame.height)
                mainscroll.contentSize.height = self.view.frame.height*CGFloat(i+1)+250
                mainscroll.addSubview(imageView)
        }
        default:
            imageArray = [UIImage(named: "Non-US.png")!,UIImage(named: "extra.png")!]
            for i in 0..<imageArray.count {
                let imageView = UIImageView()
                imageView.image = imageArray[i]
                imageView.contentMode = .scaleAspectFit
                let yPosition = self.view.frame.height * CGFloat(i)
                imageView.frame = CGRect(x: 0,y:yPosition,width: self.mainscroll.frame.width,height: self.mainscroll.frame.height)
                mainscroll.contentSize.height = self.view.frame.height*CGFloat(i+1)+250
                mainscroll.addSubview(imageView)
        }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? Main_ViewController
        if(segue.identifier == "to_main")
        {
            vc!.name = self.name!
            vc!.country = self.country!
        }
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
