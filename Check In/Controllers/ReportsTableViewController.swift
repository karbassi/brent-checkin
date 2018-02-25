//
//  ReportsTableViewController.swift
//  Check In
//
//  Created by Saundra Castaneda on 2/22/18.
//  Copyright © 2018 DePaul University. All rights reserved.
//

import UIKit
import Firebase

class ReportsTableViewController: UITableViewController {
    var ref: DatabaseReference!
    var reportList: [Report] = []
    var uid: String!
    var email: String!
    let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if user != nil {
            uid = self.user!.uid
            email = self.user!.email!
            ref = Database.database().reference().child("reports").child(uid)
        } else { return }
        
        ref.observe(DataEventType.value, with: { (snapshot) in
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //clearing the list
                self.reportList.removeAll()
                
                //iterating through all the values
                for reports in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let reportObject = reports.value as? [String: AnyObject]
                    let reportMood  = reportObject?["mood"]
                    let reportDescription = reportObject?["description"]
                    let reportAddedByUser = reportObject?["addedByUser"]
                    let reportCreatedAt = reportObject?["created_at"]
                    
                    let report = Report(mood: reportMood as! String, addedByUser: reportAddedByUser as! String, description: reportDescription as! String, created_at: reportCreatedAt as! TimeInterval)
                    
                    //appending it to list
                    self.reportList.append(report)
                }
                self.reportList = self.reportList.reversed()
                //reloading the tableview
                self.tableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reportList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportCell", for: indexPath)
        let report = reportList[indexPath.row]
        
        cell.imageView?.image = UIImage(named: "mood\(report.mood)")
        cell.textLabel?.text = String(report.description.prefix(50))
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let detailViewController = segue.destination as? DetailReportViewController {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                detailViewController.report = reportList[indexPath.row]
            }
        }
    }

}
