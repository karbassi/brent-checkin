//
//  Report.swift
//  Check In
//
//  Created by Saundra Castaneda on 2/22/18.
//  Copyright © 2018 DePaul University. All rights reserved.
//

import Foundation
import Firebase

struct Report {
    
    let key: String
    let mood: String
    let addedByUser: String
    let ref: DatabaseReference?
    let description: String
    let created_at: String
    
    init(mood: String, addedByUser: String, description: String, key: String = "") {
        self.key = key
        self.mood = mood
        self.addedByUser = addedByUser
        self.description = description
        
        // set date string
        let timeInterval = NSDate().timeIntervalSince1970
        let date = NSDate(timeIntervalSince1970: TimeInterval(timeInterval))
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        
        self.created_at = formatter.string(from: date as Date)
        
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        mood = snapshotValue["mood"] as! String
        addedByUser = snapshotValue["addedByUser"] as! String
        description = snapshotValue["description"] as! String
        created_at = snapshotValue["created_at"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "mood": mood,
            "addedByUser": addedByUser,
            "description": description,
            "created_at": created_at
        ]
    }

}
