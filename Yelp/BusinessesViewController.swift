//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MBProgressHUD;

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FiltersViewControllerDelegate {

    @IBOutlet var tableView: UITableView!
    var businesses: [Business]!
  
    var filteredBusinesses : [Business]!
      let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        searchBar.sizeToFit()
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120 //for scroll height

        Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.filteredBusinesses = businesses
            self.tableView.reloadData()
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        })

/* Example of Yelp search with more search options specified
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        }
*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        
        cell.business = filteredBusinesses[indexPath.row]
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredBusinesses != nil {
            return filteredBusinesses.count
        } else {
            return 0
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "filters") {
        let navController = segue.destinationViewController as! UINavigationController
        let filtersViewController = navController.topViewController as! FiltersViewController
        filtersViewController.delegate = self
        } else {
            let navController = segue.destinationViewController as! UINavigationController
            let mapViewController = navController.topViewController as! MapViewController
            mapViewController.businesses = businesses
            
        }
           }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if searchBar.text!.isEmpty {
            filteredBusinesses = businesses
             tableView.reloadData()
        } else {
            // The user has entered text into the search box
            // Use the filter method to iterate over all items in the data array
            // For each item, return true if the item should be included and false if the
            // item should NOT be includ
//            filteredBusinesses = businesses.filter{
//                return $0.name!.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
    showLoadingHUD()
    Business.searchWithTerm(searchBar.text!, completion: { (businesses: [Business]!, error: NSError!) -> Void in
    self.businesses = businesses
    self.filteredBusinesses = businesses
        self.hideLoadingHUD()
    self.tableView.reloadData()
    for business in businesses {
    print(business.name!)
    print(business.address!)
    }
    })

        }
    
    }
    private func showLoadingHUD() {
        let hud = MBProgressHUD.showHUDAddedTo(tableView, animated: true)
        hud.labelText = "Loading..."
    }
    
    private func hideLoadingHUD() {
        MBProgressHUD.hideAllHUDsForView(tableView, animated: true)
    }
    
    func filtersViewContoller(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
       
        let categories = filters["categories"] as? [String]
        let deals = filters["deals"] as? Bool
        let dist = filters["distance"] as? String
        let distArr = dist!.componentsSeparatedByString(" ")
        var distValue = Int(distArr[0])

        let sortlabel = filters["sort"] as? String
        
                var sortvalue :YelpSortMode
        switch (sortlabel!) {
        case "Best Match":sortvalue = .BestMatched
        case "Distance":sortvalue = .Distance
        case "Rating": sortvalue = .HighestRated
        default: sortvalue = .BestMatched
            
        }

        self.showLoadingHUD()
        Business.searchWithTerm("Restaurants", sort: sortvalue, categories: categories, deals: deals) { (businesses: [Business]!, error) -> Void in
            self.businesses = businesses
            for(var i = 0; i < businesses.count; i++)
            {
               let distArr2 = businesses[i].distance!.componentsSeparatedByString(" ")
                var distValue2 = Int(distArr2[0])
                if (distArr[0] != "Best" ) {
                    if distValue2 <= distValue
                    {
                        self.filteredBusinesses.append(businesses[i])
                    }
                } else {
                    self.filteredBusinesses = businesses
                }

                
            }
          //  self.filteredBusinesses = businesses
            self.hideLoadingHUD()
            self.tableView.reloadData()

        }
        }
}

