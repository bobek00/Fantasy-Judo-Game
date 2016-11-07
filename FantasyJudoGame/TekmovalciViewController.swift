//
//  TekmovalciViewController.swift
//  FantasyJudoGame
//
//  Created by Boris Rudas on 06/10/2016.
//  Copyright © 2016 Boris Rudas. All rights reserved.
//

import UIKit

class TekmovalciViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var predictedFirstPlaceLabel: UILabel!
    @IBOutlet var predictedSecondPlaceLabel: UILabel!
    @IBOutlet var predictedThirdPlaceLabel1: UILabel!
    @IBOutlet var predictedThirdPlaceLabel2: UILabel!
    
    @IBOutlet var predictedFirstImg: UIImageView!
    @IBOutlet var predictedSecondImg: UIImageView!
    @IBOutlet var predictedThird1Img: UIImageView!
    @IBOutlet var predictedThird2Img: UIImageView!
    
    @IBOutlet var firstImg: UIImageView!
    
    let defaultFirstText = "Choose Winner"
    let defaultSecondText = "Choose Second"
    let defaultThirdText = "Choose Third"
    let defaultThirdText2 = "Choose Third"

    var competitors: [Competitor]!
    var weight: String!
    var competitorsNameArray: NSMutableArray! = NSMutableArray()
    var competitorsIdArray: NSMutableArray! = NSMutableArray()
    var selectedCompetitoros: [Int: String] = [:]
    var selectedComps: [String: Int] = [:]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = weight
        print(selectedCompetitoros)
        predictedFirstPlaceLabel.text = defaultFirstText
        predictedSecondPlaceLabel.text = defaultSecondText
        predictedThirdPlaceLabel1.text = defaultThirdText
        predictedThirdPlaceLabel2.text = defaultThirdText
        
        
        
//        where should i put this? :)
        for competitor in competitors {
            competitorsNameArray.addObject(competitor.competitorName)
            competitorsIdArray.addObject(competitor.person_id)
        }

    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return competitors.count

    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("Competitors", forIndexPath: indexPath) as? TekmovalciTableViewCell {
        

        cell.configureCell(competitors[indexPath.row].competitorName, text2: competitors[indexPath.row].country)
            
            
            cell.setFirstBtn.tag = indexPath.row
            cell.setFirstBtn.addTarget(TekmovalciViewController(), action: #selector(TekmovalciViewController.setFirstBtnPressed), forControlEvents: .TouchUpInside)
            cell.setSecondBtn.tag = indexPath.row
            cell.setSecondBtn.addTarget(TekmovalciViewController(), action: #selector(TekmovalciViewController.setSecondBtnPressed), forControlEvents: .TouchUpInside)
            cell.setThird1Btn.tag = indexPath.row
            cell.setThird1Btn.addTarget(TekmovalciViewController(), action: #selector(TekmovalciViewController.setThird1BtnPressed), forControlEvents: .TouchUpInside)
            
            

            return cell
            
        } else {
            
            return TekmovalciTableViewCell()
        }
        
    }
    
    func selectCompetitor(competitor: String, forPlace: Int) {
        
        selectedComps[competitor] = forPlace
        selectedCompetitoros[forPlace] = competitor
        
        switch forPlace {
        case 1:
            predictedFirstPlaceLabel.text = competitor
            predictedFirstImg.image = UIImage(named: "first-full")

        case 2:
            predictedSecondPlaceLabel.text = competitor
            predictedSecondImg.image = UIImage(named: "second-full")

        case 3:
            predictedThirdPlaceLabel1.text = competitor
            predictedThird1Img.image = UIImage(named: "third-full")

        case 4:
            predictedThirdPlaceLabel2.text = competitor
            predictedThird2Img.image = UIImage(named: "third-full")

        default:
            return
        }
    }
    
    func deselectCompetitor(competitor: String, forPlace: Int) {
        
        selectedComps[competitor] = nil
        selectedCompetitoros[forPlace] = nil
        switch forPlace {
        case 1:
            predictedFirstPlaceLabel.text = defaultFirstText
            predictedFirstImg.image = UIImage(named: "first-empty")

        case 2:
            predictedSecondPlaceLabel.text = defaultSecondText
            predictedSecondImg.image = UIImage(named: "second-empty")

        case 3:
            predictedThirdPlaceLabel1.text = defaultThirdText
            predictedThird1Img.image = UIImage(named: "third-empty")

        case 4:
            predictedThirdPlaceLabel2.text = defaultThirdText2
            predictedThird2Img.image = UIImage(named: "third-empty")

        default:
            return
        }
    }
    
    func buttonSelected(buttonTag: Int, forPlace: Int) {

        if let selectedCompetitor = competitorsNameArray.objectAtIndex(buttonTag) as? String {
            if let selectedPlace = selectedComps[selectedCompetitor] {
                // the competitor is already selected
                
                if selectedPlace == forPlace || (forPlace == 3 && selectedPlace > 2) {
                    // already in the correct spot, deselect
                    deselectCompetitor(selectedCompetitor, forPlace: selectedPlace)
                } else {
                    // trying to move to different spot
                    deselectCompetitor(selectedCompetitor, forPlace: selectedPlace)
                    selectCompetitor(selectedCompetitor, forPlace: selectedPlace)
                }
                
//          if selectedPlace != forPlace {
//              // in the wrong spot
//              deselectCompetitor(selectedCompetitor, forPlace: selectedPlace)
//              selectCompetitor(selectedCompetitor, forPlace: selectedPlace)
//          } else {
//          }
            } else {
                // competitor is not selected
                if forPlace == 3 {
                    if selectedCompetitoros[3] == nil {
                        selectCompetitor(selectedCompetitor, forPlace: 3)
                    } else {
                        selectCompetitor(selectedCompetitor, forPlace: 4)
                    }
                } else {
                    selectCompetitor(selectedCompetitor, forPlace: forPlace)
                }
            }
        }
    }
    
    
//    func buttonSelected(buttonTag: Int, forPlace: Int) {
//        
//        if let selectedCompetitor = competitorsNameArray.objectAtIndex(buttonTag) as? String {
//            if let selectedPlace = selectedComps[selectedCompetitor] {
//                if selectedPlace != forPlace {
//                    // in the wrong spot
//                    deselectCompetitor(selectedCompetitor, forPlace: selectedPlace)
//                    selectCompetitor(selectedCompetitor, forPlace: selectedPlace)
//                } else {
//                    deselectCompetitor(selectedCompetitor, forPlace: selectedPlace)
//                }
//            } else {
//                if forPlace == 3 {
//                    if selectedCompetitoros[3] != nil {
//                        selectCompetitor(selectedCompetitor, forPlace: 4)
//                    } else {
//                        selectCompetitor(selectedCompetitor, forPlace: 3)
//                    }
//                } else {
//                    selectCompetitor(selectedCompetitor, forPlace: forPlace)
//                }
//            }
//        }
//    }
    
    func setFirstBtnPressed(sender: UIButton) {
        
        let buttonTag = sender.tag
        buttonSelected(buttonTag, forPlace: 1)
        
        
//        
//        if selectedCompetitoros[1] == competitorsNameArray.objectAtIndex(buttonTag) as? String {
//            selectedCompetitoros[1] = "Choose Winner"
//        
//        } else if selectedCompetitoros[2] == competitorsNameArray.objectAtIndex(buttonTag) as? String {
//            
//            selectedCompetitoros[2] = "Choose Silver"
//
//            selectedCompetitoros[1] = competitorsNameArray.objectAtIndex(buttonTag) as? String
//            
//            
////            firstImg.image = UIImage(named: #imageLiteral(resourceName: "first-full"))
//            
//        } else if selectedCompetitoros[3] == competitorsNameArray.objectAtIndex(buttonTag) as? String {
//            selectedCompetitoros[3] = "Choose Bronze"
//
//            selectedCompetitoros[1] = competitorsNameArray.objectAtIndex(buttonTag) as? String
//            
//        
//        } else if selectedCompetitoros[4] == competitorsNameArray.objectAtIndex(buttonTag) as? String {
//            selectedCompetitoros[4] = "Choose Bronze"
//
//            selectedCompetitoros[1] = competitorsNameArray.objectAtIndex(buttonTag) as? String
//            
//        } else {
//            
//            selectedCompetitoros[1] = competitorsNameArray.objectAtIndex(buttonTag) as? String
//            
//            
//        }
//            print(selectedCompetitoros)
//        predictedFirstPlaceLabel.text = selectedCompetitoros[1]
//        predictedSecondPlaceLabel.text = selectedCompetitoros[2]
//        predictedThirdPlaceLabel1.text = selectedCompetitoros[3]
//        predictedThirdPlaceLabel2.text = selectedCompetitoros[4]
//        
//        self.predictedFirstImg.layer.masksToBounds = true
//        self.predictedFirstImg.layer.cornerRadius = self.predictedFirstImg.frame.size.width / 2
//        
//        if selectedCompetitoros[1] != "Choose Winner" {
//            predictedFirstImg.image = UIImage(named: "first-full")
//            
//        } else {
//            predictedFirstImg.image = UIImage(named: "first-empty")
//        }
        
        //To je samo za test... Ta text bo prišel iz firebase!!!
        // Now set the prediction on firebase ->> competition-category-selected person for selected place!!

    }
    func setSecondBtnPressed(sender: UIButton) {
        
        
        let buttonTag = sender.tag
        
        buttonSelected(buttonTag, forPlace: 2)
//        let buttonTag = sender.tag
//        
//        if selectedCompetitoros[2] == competitorsNameArray.objectAtIndex(buttonTag) as? String {
//            selectedCompetitoros[2] = "Choose Silver"
//            
//        } else if selectedCompetitoros[1] == competitorsNameArray.objectAtIndex(buttonTag) as? String {
//            
//            selectedCompetitoros[1] = "Choose Winner"
//
//            selectedCompetitoros[2] = competitorsNameArray.objectAtIndex(buttonTag) as? String
//            
//        } else if selectedCompetitoros[3] == competitorsNameArray.objectAtIndex(buttonTag) as? String {
//            selectedCompetitoros[3] = "Choose Bronze"
//
//            selectedCompetitoros[2] = competitorsNameArray.objectAtIndex(buttonTag) as? String
//            
//        } else if selectedCompetitoros[4] == competitorsNameArray.objectAtIndex(buttonTag) as? String {
//            selectedCompetitoros[4] = "Choose Bronze"
//
//            selectedCompetitoros[2] = competitorsNameArray.objectAtIndex(buttonTag) as? String
//            
//        } else {
//            
//            selectedCompetitoros[2] = competitorsNameArray.objectAtIndex(buttonTag) as? String
//
//        }
//        print(selectedCompetitoros)
//        predictedFirstPlaceLabel.text = selectedCompetitoros[1]
//        predictedSecondPlaceLabel.text = selectedCompetitoros[2]
//        predictedThirdPlaceLabel1.text = selectedCompetitoros[3]
//        predictedThirdPlaceLabel2.text = selectedCompetitoros[4]
//        
//        self.predictedSecondImg.layer.masksToBounds = true
//        self.predictedSecondImg.layer.cornerRadius = self.predictedSecondImg.frame.size.width / 2
//        
//        if selectedCompetitoros[2] != "Choose Silver" {
//            predictedSecondImg.image = UIImage(named: "second-full")
//            
//        } else {
//            predictedSecondImg.image = UIImage(named: "second-empty")
//        }
        
    }
    func setThird1BtnPressed(sender: UIButton) {
        
        buttonSelected(sender.tag, forPlace: 3)
        
//        let buttonTag = sender.tag
//        
//        if selectedCompetitoros[1] == competitorsNameArray.objectAtIndex(buttonTag) as? String {
//            
//            selectedCompetitoros[1] = "Choose Winner"
//
//            selectedCompetitoros[3] = competitorsNameArray.objectAtIndex(buttonTag) as? String
//            
//        } else if selectedCompetitoros[2] == competitorsNameArray.objectAtIndex(buttonTag) as? String {
//            
//            selectedCompetitoros[2] = "Choose Silver"
//
//            selectedCompetitoros[3] = competitorsNameArray.objectAtIndex(buttonTag) as? String
//            
//        } else if selectedCompetitoros[3] == competitorsNameArray.objectAtIndex(buttonTag) as? String {
//            selectedCompetitoros[3] = "Choose Bronze"
//        
//        } else if selectedCompetitoros[4] == competitorsNameArray.objectAtIndex(buttonTag) as? String {
//            selectedCompetitoros[4] = "Choose Bronze"
//            
//        } else if selectedCompetitoros[3] != "Choose Bronze" && selectedCompetitoros[3] != competitorsNameArray.objectAtIndex(buttonTag) as? String {
//            
//            selectedCompetitoros[4] = competitorsNameArray.objectAtIndex(buttonTag) as? String
//
//        } else {
//            
//            selectedCompetitoros[3] = competitorsNameArray.objectAtIndex(buttonTag) as? String
//            
//        }
//        print(selectedCompetitoros)
//        predictedFirstPlaceLabel.text = selectedCompetitoros[1]
//        predictedSecondPlaceLabel.text = selectedCompetitoros[2]
//        predictedThirdPlaceLabel1.text = selectedCompetitoros[3]
//        predictedThirdPlaceLabel2.text = selectedCompetitoros[4]
//        
//        self.predictedThird1Img.layer.masksToBounds = true
//        self.predictedThird1Img.layer.cornerRadius = self.predictedThird1Img.frame.size.width / 2
//        
//        if selectedCompetitoros[3] != "Choose Bronze" {
//            predictedThird1Img.image = UIImage(named: "third-full")
//            
//        } else {
//            predictedThird1Img.image = UIImage(named: "third-empty")
//        }
//        
//        self.predictedThird2Img.layer.masksToBounds = true
//        self.predictedThird2Img.layer.cornerRadius = self.predictedThird2Img.frame.size.width / 2
//        
//        if selectedCompetitoros[4] != "Choose Bronze" {
//            predictedThird2Img.image = UIImage(named: "third-full")
//            
//        } else {
//            predictedThird2Img.image = UIImage(named: "third-empty")
//        }
    }
    
}
