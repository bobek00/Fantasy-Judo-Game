//
//  TekmovanjeViewController.swift
//  FantasyJudoGame
//
//  Created by Boris Rudas on 05/10/2016.
//  Copyright © 2016 Boris Rudas. All rights reserved.
//

import UIKit


class TekmovanjeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   

    var competition: Competition!
    
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = competition.name
        
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
         return 1
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CompCategoriesCollectionViewCell
        cell.catLabel.text = competition.categories[indexPath.row].weight
        return cell
    }
    

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return competition.categories.count
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TekmovalciSegue" {
            if let tekmovalciVC = segue.destinationViewController as? TekmovalciViewController {
                if let cell = sender as? CompCategoriesCollectionViewCell {
                    let path = self.collectionView.indexPathForCell(cell)
                    tekmovalciVC.competitors = competition.categories[path!.row].competitors
                    tekmovalciVC.weight = competition.categories[path!.row].weight
                }
            }
        }
    }
}
