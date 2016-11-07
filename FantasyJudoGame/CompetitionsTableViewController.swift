//
//  CompetitionsTableViewController.swift
//  FantasyJudoGame
//
//  Created by Boris Rudas on 02/10/2016.
//  Copyright © 2016 Boris Rudas. All rights reserved.


// reuse identifier CompetitionsCell

import UIKit
import FirebaseDatabase

class CompetitionsTableViewController: UITableViewController {
    
    var databaseRef = FIRDatabase.database().reference()
    var competitionsDict = NSDictionary?()

    var competition = String()
    var competitor = String()
    var competitions = [Competition]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseFirebaseData()
        navigationItem.title = "Competitions"
        
    }
    internal func parseFirebaseData () {
        self.databaseRef.child("Competitions").observeEventType(.Value, withBlock: {
            (snapshot) in
            
            self.competitionsDict = snapshot.value as? NSDictionary
            
            for(competiton, details) in self.competitionsDict! {
                
                let date = details.objectForKey("comp_date") as! String
                let compName = details.objectForKey("name") as! String
                let compImgId = details.objectForKey("comp_type") as! String
                let country = details.objectForKey("comp_country") as! String
                let location = details.objectForKey("comp_location") as! String
                let type = details.objectForKey("comp_type") as! String
                let webLink = details.objectForKey("web_link") as! String

                var competition = Competition(name: compName, country: country, date: date, location: location, idNumber: compImgId, type: type, categories: [Category](), webLink: webLink)
                let categories = details.objectForKey("competitors") as? [String: [AnyObject]]
                
                categories?.forEach({ (category) in
                    
                    let weight = category.0
                    var categoryModel = Category(competitors: [Competitor](), weight: weight)

                    for competitor in category.1 {
                        
                        let competitorName = competitor.objectForKey("ime in priimek") as! String
                        let country = competitor.objectForKey("country") as! String
                        let person_id = competitor.objectForKey("id_person") as! Int
                        let placement = competitor.objectForKey("placement") as? Int
                        
                        let competitor = Competitor(competitorName: competitorName, country: country, person_id: person_id, placement: placement)
                        categoryModel.competitors.append(competitor)
                    }
                    competition.categories.append(categoryModel)
                    
                })
                self.competitions.append(competition)
                
            }
            self.tableView?.reloadData()

        })

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        // MARK: - Table view data source
    
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return competitions.count
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CompetitionsCell", forIndexPath: indexPath) as! CompetitionsTableViewCell
        
        cell.competitonNameLabel.text = competitions[indexPath.row].name
        cell.competitonDateLabel.text = competitions[indexPath.row].date
        cell.competitionTypeImg.image = UIImage(named: "\(competitions[indexPath.row].type)")
        
        return cell
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Tekmovanje" {
            if let tekmovanjeVC = segue.destinationViewController as? TekmovanjeViewController {
                if let path = self.tableView.indexPathForSelectedRow {
                    tekmovanjeVC.competition = self.competitions[path.row]
                    
                }
            }
        }
    }
}
