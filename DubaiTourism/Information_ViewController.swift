//
//  Information_ViewController.swift
//  DubaiTourism
//
//  Created by pruthvi raj dudam on 6/9/21.
//

import UIKit

class cellClass:UITableViewCell{}
class Information_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var selectCountryButton: UIButton!
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    var dataSource = [String]()
    var getCountryTitle:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellClass.self,forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
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
    
    
    @IBAction func OnClick(_ sender: Any) {
        dataSource = ["USA","GCC","Other"]
        selectedButton =  selectCountryButton
        addTransparentView(frames: selectCountryButton.frame)
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
        self.getCountryTitle =  dataSource[indexPath.row]
    }
    
    @IBAction func next(_ sender: UIButton) {
        if(self.name.text! == "" || self.getCountryTitle == "*Select Here*"){
            self.present_alert();
        }
    }

    func present_alert(){
        let alert = UIAlertController(title: "Please fill/select in all the fields!", message: "", preferredStyle: .alert)
        if(self.name.text! == ""){
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Name Here"
        })
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                if let name = alert.textFields?.first?.text {
                    self.name.text! = name
                }
            }))}
        self.present(alert, animated: true)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? itemsReq_ViewController
        if(segue.identifier == "to_requiredItems")
        {
            vc!.name = self.name.text
            vc!.country = self.getCountryTitle!
            print(self.getCountryTitle!)
        }
    }
}
