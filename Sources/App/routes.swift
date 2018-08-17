import Vapor
import FCM
import Crypto


/// Register your application's routes here.


public func routes(_ router: Router) throws {
//    let fcm = FCM.init(pathToServiceAccountKey: "SERVER_KEY")
//
////    # Simple fcm push
//
//    fcm.push(text: "poutou poutou poutooooouuuuuu", to: "token") //
//
//
    // public routes
    let userController = UserController()
    let fcmController = FCMController()
    router.post("users", use: userController.create)
    
    // basic / password auth protected routes
    let basic = router.grouped(User.basicAuthMiddleware(using: BCryptDigest()))
    basic.post("login", use: userController.login)
    basic.post("/postNotification", use: fcmController.send)
    
//    // bearer / token auth protected routes
//    let bearer = router.grouped(User.tokenAuthMiddleware())
//    let todoController = TodoController()
//    bearer.get("todos", use: todoController.index)
//    bearer.post("todos", use: todoController.create)
//    bearer.delete("todos", Todo.parameter, use: todoController.delete)
//    
    
//    struct MessageRequest: Content {
//        var topic: String
//        var title: String
//        var body: String
//    }
//    
    router.get("/") { req in
        
        return "Hello, Girish!"
        
        
    }
    
    router.get("/hello") { req in
        return "Hello, world!"
    }
    
    
    
//    basic.post("/postNotification") { req -> Future<HTTPStatus> in
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
    
}
