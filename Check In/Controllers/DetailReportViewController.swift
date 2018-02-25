//
//  DetailReportViewController.swift
//  Check In
//
//  Created by Saundra Castaneda on 2/22/18.
//  Copyright © 2018 DePaul University. All rights reserved.
//

import UIKit
import Firebase

class DetailReportViewController: UIViewController {
    var report: Report?
    
    @IBOutlet weak var moodLevelImage: UIImageView!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let r = report {
            moodLevelImage.image = UIImage(named: "mood\(r.mood)")
            createdAtLabel.text = getDateString(timeInterval: r.created_at)
            descriptionText.text = r.description
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getDateString(timeInterval: TimeInterval) -> String{
        let date = NSDate(timeIntervalSince1970: TimeInterval(timeInterval))
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        return formatter.string(from: date as Date)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
