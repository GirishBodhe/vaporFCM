import Vapor
import FCM
import Crypto


/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    
//    struct MessageRequest: Content {
//        var topic: String
//        var title: String
//        var body: String
//    }
//
//    router.get("/") { req in
//        return "Hello, Girish!"
//    }
//    router.get("/hello") { req in
//        return "Hello, world!"
//    }
//
    
    let userController = UserController()
    let fcmController = FCMController()
    router.post("users", use: userController.create)
    
    // Use user model to create an authentication middleware
    let password = User.basicAuthMiddleware(using: BCryptDigest())
    
    // Create a route closure wrapped by this middleware
    router.grouped(password).get("/") { req in
        ///
        
        return "Hello, Girish!"
    }
    
    router.grouped(password).post("/postNotification", use: fcmController.send)
    
//    router.post("/postNotification") { req -> Future<HTTPStatus> in
//        return try req.content.decode(MessageRequest.self).map(to: HTTPStatus.self) { messageRequest in
//           
//            let fcm = try req.make(FCM.self)
//            //        let token = "token"
//            let topic = messageRequest.topic
//            let notification = FCMNotification(title: messageRequest.title, body: "\(messageRequest.body) ❤️")
//            let message = FCMMessage(topic: topic, notification: notification)
//            //        let message = FCMMessage(token: token, notification: notification)
//            try fcm.sendMessage(req.client(), message: message)
//            
//            return .ok
//        }
//    }
//    router.get("/testfcm") { req -> Future<String> in
//        let fcm = try req.make(FCM.self)
////        let token = "token"
//        let topic = "newHotel"
//        let notification = FCMNotification(title: "Vapor is awesome!", body: "Swift one love! ❤️")
//        let message = FCMMessage(topic: topic, notification: notification)
////        let message = FCMMessage(token: token, notification: notification)
//        return try fcm.sendMessage(req.client(), message: message)
//    }
    
    // Example of configuring a controller
//    let todoController = TodoController()
//    router.get("todos", use: todoController.index)
//    router.post("todos", use: todoController.create)
//    router.delete("todos", Todo.parameter, use: todoController.delete)
}
