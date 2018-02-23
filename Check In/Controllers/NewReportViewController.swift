//
//  NewReportViewController.swift
//  Check In
//
//  Created by Saundra Castaneda on 2/22/18.
//  Copyright © 2018 DePaul University. All rights reserved.
//

import UIKit
import Firebase

class NewReportViewController: UIViewController {
    var user: User!
    var newReport: Report!
    let currentUser = Auth.auth().currentUser!
    let ref = Database.database().reference()
//    var rootRef = Database.database().reference()
    
    @IBOutlet weak var moodLevel: UISlider!
    @IBOutlet weak var descriptionField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if Auth.auth().currentUser != nil {
            user = User(uid: currentUser.uid, email: currentUser.email!)
        } else { return }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let fixed = roundf(sender.value);
        sender.setValue(fixed, animated: true)
    }
    
    @IBAction func saveButtonDidTouch(_ sender: Any) {
        newReport = Report(mood: Int(moodLevel.value), addedByUser: currentUser.email!, description: descriptionField.text)
        print(moodLevel.value.rounded())
        print(currentUser.email!)
        print(descriptionField.text)
        print(newReport)
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
