//
//  Main_ViewController.swift
//  DubaiTourism
//
//  Created by pruthvi raj dudam on 6/10/21.
//

import UIKit

class Main_ViewController: UIViewController {
    var name:String?
    var age:Int?
    var country:String?
    @IBOutlet weak var current_temp: UILabel!
    
    
    @IBOutlet weak var DateTime: UILabel!
    
    @IBOutlet weak var feels_temp: UILabel!
    
    @IBOutlet weak var welcome: UILabel!
    
    @IBOutlet weak var mainscroll: UIScrollView!
    @IBOutlet weak var weather: UILabel!
    
    var curr_temp:[String] = []
    var feel_temp:[String]=[]
    var dateTime:[String]=[]
    var welcome_arr:[String]=[]
    var imageArray=[UIImage]()
    var c1:Int?
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.welcome.text! = "Welcome \(self.name!)!"
        self.get_data()
        imageArray = [#imageLiteral(resourceName: "Screen Shot 2021-06-14 at 12.28.31 AM") , #imageLiteral(resourceName: "Screen Shot 2021-06-14 at 12.25.22 AM") , #imageLiteral(resourceName: "Screen Shot 2021-06-14 at 12.31.21 AM") , #imageLiteral(resourceName: "Screen Shot 2021-06-14 at 12.36.33 AM") ]
        for i in 0..<imageArray.count {
            let imageView = UIImageView()
            imageView.image = imageArray[i]
            imageView.contentMode = .scaleToFill
            let xPosition = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition,y:0,width: self.mainscroll.frame.width,height: self.mainscroll.frame.height)
            mainscroll.contentSize.width = mainscroll.frame.width*CGFloat(i+1)
            mainscroll.addSubview(imageView)

    }
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let vc = segue.destination as? ScrollViewController
            if(segue.identifier == "to_scroll")
            {
                switch (self.getScrollVal()) {
                case 0.0:
                    vc!.scrollVal = "hotels"
                    break
                case 414.0:
                    vc!.scrollVal = "attraction"
                    break
                case 828:
                    vc!.scrollVal = "history"
                    break
                case 1242.0:
                    vc!.scrollVal = "beach"
                    break
                default:
                    print("wrong value")
                }
            }
    }
    
    func getScrollVal() -> CGFloat{
        return mainscroll.contentOffset.x
    }
            
    
    func get_data(){
        let urlAsString = "http://api.weatherapi.com/v1/current.json?key=dd3781b3cc3e42ee9db212404211006&q=Dubai"
                let url = URL(string: urlAsString)!
                let urlSession = URLSession.shared
                let jsonQuery = urlSession.dataTask(with: url as URL, completionHandler: { [self] data, response, error -> Void in
                                if (error != nil) {
                                    print(error!.localizedDescription)
                                }
                                var err: NSError?
                    let jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                                if (err != nil) {
                                    print("JSON Error \(err!.localizedDescription)")
                                }
                    
                   //print(jsonResult)
                   let p = (jsonResult.count) as Int
                   if let dictionary = jsonResult as? [String: Any]{
                    
                    for i in 0..<p{
                    for (key,value) in dictionary{
                        if key == "current"{
                            let dict = value as?[String: Any]
                            let p1 = (dict!.count) as Int
                            for j in 0..<p1{
                            for (key,value) in dict!{
                                if key == "condition"{
                                    let dict2 = value as?[String: Any]
 //                                   let p3 = (dict2!.count) as Int
//                                    for k in 0..<p3{
                                    for (key,value) in dict2!{
                                       if key == "text"{
                                        self.welcome_arr.append(String(describing:value))
                                        }
                                    }
                                }
                                if key == "temp_c"{self.curr_temp.append(String(describing:value))
                                }
                                if key == "temp_f"{self.curr_temp.append(String(describing:value))}
                                if key == "feelslike_c"{self.feel_temp.append(String(describing:value))}
                                if key == "feelslike_f"{self.feel_temp.append(String(describing:value))}
                            }
                        }
                        }
                        if key == "location"{
                            let dict1 = value as?[String: Any]
                            
                            //for k in 0..<p2{
                            for (key,value) in dict1!{
                                
                                if key == "localtime"{self.dateTime.append(String(describing:value))}
                             }
                            //}
                        }
                            }
                       
                        }
                    DispatchQueue.main.async {
                        
                        self.current_temp.text! = "\(self.toInt(str: curr_temp[0]))°C / \(self.toInt(str: curr_temp[1]))°F"
                        self.feels_temp.text! = "Feels \(self.toInt(str: feel_temp[0]))°C / \(self.toInt(str: feel_temp[1]))°F"
                        self.DateTime.text! = "\(dateTime[0])"
                        self.weather.text! = "\(welcome_arr[0])"
                    }
                    }
            })
                jsonQuery.resume()
    }
    
    func toInt(str:String)-> String{
        return str[0..<2]
    }

}
extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }

    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
         return String(self[start...])
    }
}
