//
//  MapViewController.swift
//  DubaiTourism
//
//  Created by pruthvi raj dudam on 6/14/21.
//

import UIKit
import CoreLocation
import MapKit

class CellClass:UITableViewCell{}
class MapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate  {
    
    @IBOutlet weak var selectHotel: UIButton!
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    var dataSource = [String]()
    var getHotelTitle:String?
    var getDestTitle:String?
    var getData:CGFloat?
    var manager:CLLocationManager!
    var sourcename:String?
    var SourceLat:Double?
    var Sourcelon:Double?
    var Destlat:Double?
    var Destlon:Double?
    var destname:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self,forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func addTransparentView(frames:CGRect){
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y+frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action:
        #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha=0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y+frames.height+5, width: frames.width, height: CGFloat(self.dataSource.count*50))
            
        }, completion: nil)
    }
    
    @objc func removeTransparentView(){
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha=0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y+frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    @IBAction func onClickHotel(_ sender: Any) {
        dataSource = ["Atlantis,The Palm","FIVE Palm Jumeirah","Burj Al Arab","Jumeirah Zabeel","The Meydan","Grand Hyatt","Waldorf Astoria","Rixos","Sofitel","Studio One Hotel"]
        selectedButton =  selectHotel
        addTransparentView(frames: selectHotel.frame)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView:UITableView,heightForRowAt indexPath:IndexPath) -> CGFloat{
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
        removeTransparentView()
        self.getHotelTitle =  dataSource[indexPath.row]
        self.getdir()
    }
    
    class func isLocationServiceEnabled() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            default:
                print("Something wrong with Location services")
                return false
            }
        } else {
            print("Location services are not enabled")
            return false
        }
    }
    
    func getdir(){
        self.getSourceLocation(str: self.getHotelTitle!)
        self.getDestLocation(str: self.getDestTitle!, data: getData!)
        var lat = self.SourceLat!
        var lon = self.Sourcelon!
        var rentalLat = self.Destlat!
        var rentalLon = self.Destlon!
        var i = self.destname!
        var j = self.sourcename!
        //let rental = Int.random(in: 0..<get_rental())
        
        let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon)))
        source.name = j
                
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: rentalLat, longitude: rentalLon)))
        destination.name = i
                
        MKMapItem.openMaps(
          with: [source, destination],
          launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        )
    }
    
    func getSourceLocation(str:String){
        switch (str) {
        case dataSource[0]:
            self.Sourcelon = 25.1304
            self.SourceLat = 55.1171
            self.sourcename = dataSource[0]
            break
        case dataSource[1]:
            self.Sourcelon = 25.1043
            self.SourceLat = 55.1488
            self.sourcename = dataSource[1]
            break
        case dataSource[2]:
            self.Sourcelon = 25.1412
            self.SourceLat = 55.1852
            self.sourcename = dataSource[2]
            break
        case dataSource[3]:
            self.Sourcelon = 25.0984
            self.SourceLat = 55.1235
            self.sourcename = dataSource[3]
            break
        case dataSource[4]:
            self.Sourcelon = 25.1557
            self.SourceLat = 55.3003
            self.sourcename = dataSource[4]
            break
        case dataSource[5]:
            self.Sourcelon = 25.2282
            self.SourceLat = 55.3279
            self.sourcename = dataSource[5]
            break
        case dataSource[6]:
            self.Sourcelon = 25.1346
            self.SourceLat = 55.1511
            self.sourcename = dataSource[6]
            break
        case dataSource[7]:
            self.Sourcelon = 25.1212
            self.SourceLat = 55.1538
            self.sourcename = dataSource[7]
            break
        case dataSource[8]:
            self.Sourcelon = 25.2000
            self.SourceLat = 55.2692
            self.sourcename = dataSource[8]
            break
        case dataSource[9]:
            self.Sourcelon = 25.0438
            self.SourceLat = 55.2506
            self.sourcename = dataSource[9]
            break
        default:
            print("null")
        }
    }
    
    func getDestLocation(str:String , data:CGFloat){
        switch(str){
        case "attraction":
            switch (data) {
            case 0.0:
                self.Destlon = 25.1972
                self.Destlat = 55.2744
                self.destname = "Burj Khalifa"
                break
            case 414.0:
                self.Destlon = 25.1412
                self.Destlat = 55.1852
                self.destname = "Burj Al Arab"
                break
            case 828.0:
                self.Destlon = 25.1988
                self.Destlat = 55.2796
                self.destname = "Jumeirah Beach"
                break
            case 1242.0:
                self.Destlon = 25.1988
                self.Destlat = 55.2796
                self.destname = "Dubai Mall"
                break
            case 1656.0:
                self.Destlon = 25.2682
                self.Destlat = 55.2901
                self.destname = "Sheikh Saeed Al"
                break
            case 2070.0:
                self.Destlon = 25.1394
                self.Destlat = 55.1888
                self.destname = "Wild Wadi"
                break
            case 2484.0:
                self.Destlon = 25.2535
                self.Destlat = 55.3167
                self.destname = "Dubai Creek"
                break
            case 2898.0:
                self.Destlon = 25.1975
                self.Destlat = 55.2785
                self.destname = "Dubai Aquarium"
                break
            case 3312.0:
                self.Destlon = 25.2021
                self.Destlat = 55.2728
                self.destname = "Desert Safari"
                break
            case 3726.0:
                self.Destlon = 25.0805
                self.Destlat = 55.1403
                self.destname = "Dubai Marina"
                break
            default:
                print("null")
            }
            
        case "history":
            switch (data) {
            case 0.0:
                self.Destlon = 25.1895
                self.Destlat = 55.2766
                self.destname = "Old Town"
                break
            case 414.0:
                self.Destlon = 25.2638
                self.Destlat = 55.3004
                self.destname = "Al Fahidi Historical"
                break
            case 828.0:
                self.Destlon = 25.2588
                self.Destlat = 55.3107
                self.destname = "Al Seef"
                break
            case 1242.0:
                self.Destlon = 25.2686
                self.Destlat = 55.2974
                self.destname = "Dubai Gold souk"
                break
            case 1656.0:
                self.Destlon = 25.2635
                self.Destlat = 55.2972
                self.destname = "Dubai Museum"
                break
            case 2070.0:
                self.Destlon = 30.132641475347352
                self.Destlat = 57.64545406349808
                self.destname = "souk Al hadid museum"
                break
            case 2484.0:
                self.Destlon = 25.2748
                self.Destlat = 55.3160
                self.destname = "burj nahar"
                break
            case 2898.0:
                self.Destlon = 25.186894130266936
                self.Destlat = 55.230767571164805
                self.destname = "Majlis Ghorfat Umm Al Sheif"
                break
            case 3312.0:
                self.Destlon = 25.26492990260015
                self.Destlat = 55.30002324232961
                self.destname = "Philately House"
                break
            default:
                print("null")
            }
        case "beach":
            switch (data) {
            case 0.0:
                self.Destlon = 25.0730
                self.Destlat = 55.1343
                self.destname = "JBR Open Beach"
                break
            case 414.0:
                self.Destlon = 25.1489
                self.Destlat = 55.1956
                self.destname = "Jumeirah Beach Park"
                break
            case 828.0:
                self.Destlon = 25.1483
                self.Destlat = 55.1945
                self.destname = "Umm Suqeim Beach"
                break
            case 1242.0:
                self.Destlon = 25.1650
                self.Destlat = 55.2085
                self.destname = "Kite Beach"
                break
            case 1656.0:
                self.Destlon = 25.3098
                self.Destlat = 55.3513
                self.destname = "Al Mamzar Beach"
                break
            case 2070.0:
                self.Destlon = 25.1124
                self.Destlat = 55.1390
                self.destname = "Palm Jumeirah"
                break
            case 2484.0:
                self.Destlon = 25.0779
                self.Destlat = 55.1317
                self.destname = "Marina Beach"
                break
            case 2898.0:
                self.Destlon = 25.2535
                self.Destlat = 55.3167
                self.destname = "Dubai Creek"
                break
            case 3312.0:
                self.Destlon = 24.9861
                self.Destlat = 55.0179
                self.destname = "Jebal Ali Beach"
                break
            case 3726.0:
                self.Destlon = 25.2327
                self.Destlat = 55.2638
                self.destname = "La Mer"
                break
            default:
                print("null")
            }
        default:
            print("null")
        }
        
    }
    
    
    
    
    
    
}



