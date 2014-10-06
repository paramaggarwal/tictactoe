//
//  ViewController.swift
//  TicTacToe
//
//  Created by Param Aggarwal on 22/09/14.
//  Copyright (c) 2014 Assignment. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    var cellState = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
    var isOtherPlayer = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return cellState.count;
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellState[section].count;
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let row = self.cellState[indexPath.section]
        let item = row[indexPath.row]
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell-empty", forIndexPath: indexPath) as UICollectionViewCell

        if item == 1 {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell-o", forIndexPath: indexPath) as UICollectionViewCell
        } else if item == 2 {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell-x", forIndexPath: indexPath) as UICollectionViewCell
        }
        
        return cell;
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var row = self.cellState[indexPath.section]
        var cell = row[indexPath.row]
        
        // if not yet selected
        if row[indexPath.row] == 0 {
            if self.isOtherPlayer {
                row[indexPath.row] = 1
            } else {
                row[indexPath.row] = 2
            }
            self.cellState[indexPath.section] = row
            collectionView.reloadData()
            self.isOtherPlayer = !self.isOtherPlayer
            
            let winner = self.checkForWinner()
            if winner == "o" || winner == "x" {
                self.alertWinner(winner)
                NSLog("Winner %@", winner)
            }
        }
    }
    
    func checkForWinner() -> String {
        
        // check for rows
        for (var i=0; i<3; i++) {
            let row = self.cellState[i]
            
            if (row[0] == 1 && row[1] == 1 && row[2] == 1) {
                return "o"
                // o WINS
            } else if (row[0] == 2 && row[1] == 2 && row[2] == 2) {
                // x wins
                return "x"
            }
        }
        
        
        // check for columns
        let row1 = self.cellState[0];
        let row2 = self.cellState[1];
        let row3 = self.cellState[2];

        for (var i=0; i<3; i++) {
            let item1 = row1[i]
            let item2 = row2[i]
            let item3 = row3[i]
            
            if (item1 == 1 && item2 == 1 && item3 == 1) {
                // o WINS
                return "o"
            } else if (item1 == 2 && item2 == 2 && item3 == 2) {
                // x wins
                return "x"
            }
        }
        
        // check diagonals
        if (self.cellState[0][0] == 1 && self.cellState[1][1] == 1 && self.cellState[2][2] == 1) {
            // o WINS
            return "o"
        } else if (self.cellState[0][0] == 2 && self.cellState[1][1] == 2 && self.cellState[2][2] == 2) {
            // x wins
            return "x"
        }
        
        return ""
    }
    
    func alertWinner(winner : String) {
        
        var alert = UIAlertController(title: "We have a winner!", message: "...and it is: " + winner, preferredStyle: UIAlertControllerStyle.Alert)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

