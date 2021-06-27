//
//  ScrollViewController.swift
//  DubaiTourism
//
//  Created by pruthvi raj dudam on 6/13/21.
//

import UIKit

class ScrollViewController: UIViewController {
    @IBOutlet weak var mainscroll: UIScrollView!
    var imageArray=[UIImage]()
    var scrollVal: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.printScroll(str: scrollVal!)
    }
    
    func printScroll(str:String){
        
        switch(str) {
        case "hotels":
            imageArray = [#imageLiteral(resourceName: "Screen Shot 2021-06-13 at 2.07.39 AM") , #imageLiteral(resourceName: "Screen Shot 2021-06-13 at 2.08.31 AM") , #imageLiteral(resourceName: "Screen Shot 2021-06-13 at 2.09.00 AM") , #imageLiteral(resourceName: "Screen Shot 2021-06-13 at 2.09.23 AM") ,  #imageLiteral(resourceName: "Screen Shot 2021-06-13 at 2.09.43 AM") , #imageLiteral(resourceName: "Screen Shot 2021-06-13 at 2.10.18 AM") , #imageLiteral(resourceName: "Screen Shot 2021-06-13 at 2.10.32 AM") , #imageLiteral(resourceName: "Screen Shot 2021-06-13 at 2.11.14 AM") , #imageLiteral(resourceName: "Screen Shot 2021-06-13 at 2.11.30 AM") , #imageLiteral(resourceName: "Screen Shot 2021-06-13 at 2.11.52 AM") ]
            for i in 0..<imageArray.count {
                let imageView = UIImageView()
                imageView.image = imageArray[i]
                imageView.contentMode = .scaleAspectFit
                let xPosition = self.view.frame.width * CGFloat(i)
                imageView.frame = CGRect(x: xPosition,y:0,width: self.mainscroll.frame.width,height: self.mainscroll.frame.height)
                mainscroll.contentSize.width = mainscroll.frame.width*CGFloat(i+1)
                mainscroll.addSubview(imageView)

            // Do any additional setup after loading the view.
        }
            break
        case "attraction":
            imageArray = [UIImage(named: "a-1.png")! , UIImage(named: "a-2.png")! , UIImage(named: "a-3.png")!, UIImage(named: "a-4.png")!,  UIImage(named: "a-5.png")! , UIImage(named: "a-6.png")! , UIImage(named: "a-7.png")! , UIImage(named: "a-8.png")!, UIImage(named: "a-9.png")! , UIImage(named: "a-10.png")!]
            for i in 0..<imageArray.count {
                let imageView = UIImageView()
                imageView.image = imageArray[i]
                imageView.contentMode = .scaleToFill
                let xPosition = self.view.frame.width * CGFloat(i)
                imageView.frame = CGRect(x: xPosition,y:0,width: self.mainscroll.frame.width,height: self.mainscroll.frame.height)
                mainscroll.contentSize.width = mainscroll.frame.width*CGFloat(i+1)
                mainscroll.addSubview(imageView)
        }
            break
        case "history":
            imageArray = [UIImage(named: "h-1.png")! , UIImage(named: "h-2.png")! , UIImage(named: "h-3.png")!, UIImage(named: "h-4.png")!,  UIImage(named: "h-5.png")! , UIImage(named: "h-6.png")! , UIImage(named: "h-7.png")! , UIImage(named: "h-8.png")!, UIImage(named: "h-9.png")!]
            for i in 0..<imageArray.count {
                let imageView = UIImageView()
                imageView.image = imageArray[i]
                imageView.contentMode = .scaleToFill
                let xPosition = self.view.frame.width * CGFloat(i)
                imageView.frame = CGRect(x: xPosition,y:0,width: self.mainscroll.frame.width,height: self.mainscroll.frame.height)
                mainscroll.contentSize.width = mainscroll.frame.width*CGFloat(i+1)
                mainscroll.addSubview(imageView)
        }
            break
        case "beach":
            imageArray = [UIImage(named: "b-1.png")! , UIImage(named: "b-2.png")! , UIImage(named: "b-3.png")!, UIImage(named: "b-4.png")!,  UIImage(named: "b-5.png")! , UIImage(named: "b-6.png")! , UIImage(named: "b-7.png")! , UIImage(named: "b-8.png")!, UIImage(named: "b-9.png")! , UIImage(named: "b-10.png")!]
            for i in 0..<imageArray.count {
                let imageView = UIImageView()
                imageView.image = imageArray[i]
                imageView.contentMode = .scaleToFill
                let xPosition = self.view.frame.width * CGFloat(i)
                imageView.frame = CGRect(x: xPosition,y:0,width: self.mainscroll.frame.width,height: self.mainscroll.frame.height)
                mainscroll.contentSize.width = mainscroll.frame.width*CGFloat(i+1)
                mainscroll.addSubview(imageView)
        }
            break
        default:
            print("hello")
        }
    }
    
    @IBAction func go_there(_ sender: Any) {
        print(mainscroll.contentOffset.x)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? MapViewController
        if(segue.identifier == "to_map")
        {
            vc!.getData = mainscroll.contentOffset.x
            vc!.getDestTitle = scrollVal!
        }
    }
  
}

