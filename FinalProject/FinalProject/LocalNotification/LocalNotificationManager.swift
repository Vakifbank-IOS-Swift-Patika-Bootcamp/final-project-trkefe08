//
//  LocalNotificationManager.swift
//  FinalProject
//
//  Created by Tarik Efe on 16.12.2022.
//

import UIKit
//MARK: - Protocols
protocol LocalNotificationProtocol {
    func requestNotificationAuthorization()
    func sendNotification()
}


final class LocalNotificationManager: LocalNotificationProtocol {
    
    private let userNotificationCenter = UNUserNotificationCenter.current()
    //MARK: - Methods
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        userNotificationCenter.requestAuthorization(options: authOptions) { _, error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func sendNotification() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "RAWG"
        notificationContent.body = "Heyy you've been gone for a long time it's nice to see you!".localized()
        notificationContent.userInfo = ["id": 3]
        notificationContent.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: "LintNotification", content: notificationContent, trigger: trigger)
        
        userNotificationCenter.add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }
}
