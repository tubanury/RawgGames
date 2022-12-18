//
//  LocalNotificationManager.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 18.12.2022.
//

import Foundation
import UserNotifications

protocol LocalNotificationManagerProtocol {
    func requestNotificationAuthorization()
    func sendNotification(title: String, body: String)
}

final class LocalNotificationManager: LocalNotificationManagerProtocol {
    static let shared = LocalNotificationManager()
    private let userNotificationCenter = UNUserNotificationCenter.current()

    
    func requestNotificationAuthorization(){
       let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
       userNotificationCenter.requestAuthorization(options: authOptions) { _, error in
           if let _ = error {
               //todo: handle error
           }
       }
   }
    
    func sendNotification(title: String, body: String){
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "FavoritesNotification", content: notificationContent, trigger: trigger)
        
        self.userNotificationCenter.add(request){ error in
            if let _ = error {
                //todo: handle error
            }
        }
    }
    
}
