//
//  CountryListingViewController.swift
//  Mobiotics IOS-Test
//
//  Created by Suraj on 27/09/18.
//  Copyright © 2018 Suraj. All rights reserved.
//

import UIKit
import Alamofire
import MobileCoreServices


class CountryListingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    var activityIndicatorView: ActivityIndicatorView!
    var CountryListModelArray = [CountryCodeModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.register(UINib(nibName: "CountryListTableViewCell", bundle: nil), forCellReuseIdentifier: "CountryListTableViewCell")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.CountryListModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListTableViewCell", for: indexPath) as! CountryListTableViewCell
        
        cell.countryName.text = self.CountryListModelArray[indexPath.row].countryName
        cell.countryShortCode.text = self.CountryListModelArray[indexPath.row].countryShortCode
        cell.countryCode.text = self.CountryListModelArray[indexPath.row].countryCode
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.dismiss(animated: false, completion: {
            
            //notification send from here
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "counryShortCode"), object: self.CountryListModelArray[indexPath.row].countryShortCode)
            
            })
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 55
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if Reachability.isConnectedToNetwork() == true{
            self.countryCodeFunc()
        }
        else{
            let alert = UIAlertController(title: "Alert!", message: "No internet connection. Please try again!", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: self.finishAlert))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    func finishAlert(alert: UIAlertAction!)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func countryCodeFunc()
    {
        
        self.activityIndicatorView = ActivityIndicatorView(title: "", center: self.view.center, width: 75, height: 75)
        self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
        
        self.activityIndicatorView.startAnimating()
        self.view.isUserInteractionEnabled = false
        
        
        let params:[String:Any] = [:]
        
        Alamofire.request("https://restcountries.eu/rest/v1/all", method: .get, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                switch(response.result) {
                case .success(_):
                    
                    if response.result.value != nil
                    {
                        
                        let responseArray = response.result.value as! NSArray
                        
                        var cName:String = ""
                        var CShortCode:String = ""
                        var cCode:String = ""
                        
                        for index:Int in 0 ..< responseArray.count{
                            
                            let dict = responseArray[index] as! NSDictionary
                            
                            if (dict["name"] as? String) != nil{
                                cName = dict["name"] as! String
                            }
                            
                            if (dict["alpha2Code"] as? String) != nil{
                                CShortCode = dict["alpha2Code"] as! String
                            }
                            
                            if (dict["callingCodes"] as? NSArray) != nil{
                                
                                let dictCodeArray = dict["callingCodes"] as! NSArray
                                
                                for index:Int in 0 ..< dictCodeArray.count{
                                    
                                    cCode = dictCodeArray[0] as! String
                                }
                                
                            }
                            
                            
                            let obj = CountryCodeModel(countryName: cName, countryShortCode: CShortCode, countryCode: cCode)
                            
                            self.CountryListModelArray.append(obj)
                            
                        }
                        
                    }
                    
                    //print(self.CountryListModelArray.count)
                    
                    self.tableView.reloadData()
                    self.activityIndicatorView.stopAnimating()
                    self.view.isUserInteractionEnabled = true
                    
                case .failure(_):
                    
                    print("Error message:\(String(describing: response.result.error))")
                    
                    self.activityIndicatorView.stopAnimating()
                    self.view.isUserInteractionEnabled = true
                    break
                    
                }
        }
    }

    
    
}
