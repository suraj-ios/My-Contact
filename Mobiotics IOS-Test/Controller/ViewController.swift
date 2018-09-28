//
//  ViewController.swift
//  Mobiotics IOS-Test
//
//  Created by Suraj on 27/09/18.
//  Copyright © 2018 Suraj. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var contactDataArray = [CountryListModel]()
    
    var searchController: UISearchController!
    var shouldShowSearchResults = false
    var dataArray = [CountryListModel]()
    var filteredArray = [CountryListModel]()
    
    
    func configureSearchController() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
        
    }
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchString = searchController.searchBar.text!
        // Filter the data array and get only those countries that match the search text.
        //print(searchString)
        
        let filteredValue = self.contactDataArray.filter({($0.countryName.localizedCaseInsensitiveContains(searchString))})
        
        if filteredValue.count > 0{
            
            self.filteredArray.removeAll()
            self.filteredArray = filteredValue
            
        }
        
        // Reload the tableview.
        tableView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.register(UINib(nibName: "ContactListTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactListTableViewCell")
        
        configureSearchController()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults == true{
            return filteredArray.count
        }
        return self.contactDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListTableViewCell", for: indexPath) as! ContactListTableViewCell
        
        if shouldShowSearchResults == true{
            
            cell.contactName.text = self.filteredArray[indexPath.row].countryName
            
            if let decodedData = Data(base64Encoded: self.filteredArray[indexPath.row].image, options: .ignoreUnknownCharacters) {
                
                let image = UIImage(data: decodedData)
                
                cell.contactImage.image = image
                
            }
            
        }else{
        
        cell.contactName.text = self.contactDataArray[indexPath.row].countryName
        
        if let decodedData = Data(base64Encoded: self.contactDataArray[indexPath.row].image, options: .ignoreUnknownCharacters) {
            
            let image = UIImage(data: decodedData)
            
            cell.contactImage.image = image
            
            }
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 110
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        DispatchQueue.main.async {
            
            if let data = UserDefaults.standard.data(forKey: "countryListOffline"),
                let myPeopleList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [CountryListModel] {
                
                self.contactDataArray.removeAll()
                self.contactDataArray = myPeopleList
                
            }
            
            self.tableView.reloadData()
        }
        
    }
    
    @IBAction func addContactFunc(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: "AddContactViewController") as! AddContactViewController
        
        self.navigationController?.pushViewController(destination, animated: true)
        
    }
    
    
    
}

