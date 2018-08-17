//
//  FCMController.swift
//  App
//
//  Created by Girish Bodhe on 16/08/18.
//

import Foundation
import Vapor
import FluentSQLite
import FCM


/// Simple todo-list controller.
final class FCMController {
    
    /// Returns a list of all todos for the auth'd user.
    func send(_ req: Request) throws -> Future<String> {
        
        
//        _ = try req.requireAuthenticated(User.self)
        
        
        // decode request content
        return try req.content.decode(MessageRequest.self).flatMap { fmassage in
            // save new todo
//
//            try FCMData(topic:fmassage.topic, title: fmassage.title, body: fmassage.body, userID: user.requireID()).save(on: req)
        
        let fcm = try req.make(FCM.self)
        //        let token = "token"
        let topic = fmassage.topic
        let notification = FCMNotification(title: fmassage.title, body: "\(fmassage.body) ❤️")
        let message = FCMMessage(topic: topic, notification: notification)
        //        let message = FCMMessage(token: token, notification: notification)
            return try fcm.sendMessage(req.client(), message: message)
        
        }
    }
    
}

// MARK: Content

struct MessageRequest: Content {
    var topic: String
    var title: String
    var body: String
}
