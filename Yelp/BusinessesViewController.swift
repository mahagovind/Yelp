//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

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
        let navController = segue.destinationViewController as! UINavigationController
        let filtersViewController = navController.topViewController as! FiltersViewController
        filtersViewController.delegate = self
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
    
    Business.searchWithTerm(searchBar.text!, completion: { (businesses: [Business]!, error: NSError!) -> Void in
    self.businesses = businesses
    self.filteredBusinesses = businesses
    self.tableView.reloadData()
    for business in businesses {
    print(business.name!)
    print(business.address!)
    }
    })

        }
    
    }
    
    func filtersViewContoller(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        var categories = filters["categories"] as? [String]
        var deals = filters["deals"] as? Bool
        Business.searchWithTerm("Restaurants", sort: nil, categories: categories, deals: deals) { (businesses: [Business]!, error) -> Void in
            self.businesses = businesses
            self.filteredBusinesses = businesses
            self.tableView.reloadData()

        }
        }
}

