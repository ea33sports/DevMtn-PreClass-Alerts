//
//  Notifications Manager.swift
//  Notifications Test
//
//  Created by Eric Andersen on 8/27/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationManager: NSObject {
    
    override init() {
        super.init()
        
        requestPermission()
    }
    
    func requestPermission() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("We have permission to send notifications")
                UNUserNotificationCenter.current().delegate = self
            } else if let e = error {
                print(e)
            }
        }
    }
    
    func fireNotification() {
        
        let action = UNNotificationAction(identifier: "feedMe", title: "Feed Me", options: [])
        let category = UNNotificationCategory(identifier: "eatingCategory", actions: [action], intentIdentifiers: [], options: [.customDismissAction])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        let noteContent = UNMutableNotificationContent()
        noteContent.title = "Time to eat"
        noteContent.body = "The wait is over"
        noteContent.categoryIdentifier = "eatingCategory"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let requestIdentifier = "testRequest"
        
        let noteRequest = UNNotificationRequest(identifier: requestIdentifier, content: noteContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(noteRequest) { (error) in
            print(error)
        }
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let message = notification.request.content.title
        NotificationCenter.default.post(name: NSNotification.Name("localNotificationFired"), object: nil, userInfo: ["message" : message])
        
        completionHandler(.alert)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case "feedMe":
            print("I am eating")
        default:
            break
        }
        
        completionHandler()
    }
}






















