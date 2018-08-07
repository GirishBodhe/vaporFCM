import Vapor
import FCM


/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    router.get("testfcm") { req -> Future<String> in
        let fcm = try req.make(FCM.self)
        let token = "token"
        let notification = FCMNotification(title: "Vapor is awesome!", body: "Swift one love! ❤️")
        let message = FCMMessage(token: token, notification: notification)
        return try fcm.sendMessage(req.client(), message: message)
    }
    
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}
