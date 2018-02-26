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
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var moodLevel: UISlider!
    @IBOutlet weak var descriptionField: UITextView!
    
    var newReport: Report!
    var uid: String!
    var email: String!
    var ref: DatabaseReference!
    
    let user = Auth.auth().currentUser

    override func viewDidLoad() {
        super.viewDidLoad()

        if user != nil {
            uid = self.user!.uid
            email = self.user!.email!
            ref = Database.database().reference().child("reports").child(uid)
        } else { return }
        
        descriptionField.text = ""
        descriptionField.placeholder = "Explain your mood..."
        addDoneToolbar()
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
        let key = ref.childByAutoId().key
        newReport = Report(mood: String(Int(moodLevel.value)), addedByUser: email, description: descriptionField.text, created_at:NSDate().timeIntervalSince1970, key: key)
        ref.child(key).setValue(newReport.toAnyObject())
        self.dismiss(animated: true, completion: nil)
    }
    
    func addDoneToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.donePressed))
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        
        descriptionTextView.inputAccessoryView = toolbar
    }
    
    @objc func donePressed() {
        self.view.endEditing(true)
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
