import FluentSQLite
import Vapor
import FCM

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    
//    let headers = [
//        "Cache-Control": "no-cache",
//        "Postman-Token": "119684ab-4cee-4ab9-85bc-b8992bb33dce"
//    ]
//
//    let request = NSMutableURLRequest(url: NSURL(string: "https://firebasestorage.googleapis.com/v0/b/mhi-test-58b3b.appspot.com/o/serviceAccountKey.json?alt=media&token=4dcea859-90f1-4967-9295-06dc68ee77f3")! as URL,
//                                      cachePolicy: .useProtocolCachePolicy,
//                                      timeoutInterval: 10.0)
//    request.httpMethod = "GET"
//    request.allHTTPHeaderFields = headers
//
//    let session = URLSession.shared
//    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//        if (error != nil) {
//            print(error as Any)
//        } else {
//            let httpResponse = response as? HTTPURLResponse
////            print(httpResponse)
//
//
//                // Get the url of Persons.json in document directory
//                guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
//                let fileUrl = documentDirectoryUrl.appendingPathComponent("serviceAccountKey.json")
//
//
//                // Create a write-only stream
//                guard let stream = OutputStream(toFileAtPath: fileUrl.path, append: false) else { return }
//                stream.open()
//                defer {
//                    stream.close()
//                }
//
//                // Transform array into data and save it into file
//                var error: NSError?
//            JSONSerialization.writeJSONObject(data as Any , to: stream, options: [], error: &error)
//
//                // Handle error
//                if let error = error {
//                    print(error)
//                }else{
//
//
//            }
//
//        }
//    })
    let key = "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDiWFbHuYfN7atb\nzTnWAmDEcFImQxVnpZDiEP+vurzZlNkIRyZOEqFJTFsnoH93lvM7QZjrr8LpDJPN\n1FJV3S2Z59GKMTJkAoRiaUjxfu99sR7u2xxRDsyUT68cYbGNcnUzKSJjSVT0XTG3\nhxHGxkZOdS5/0z+dp8Vq/bZGG9yt2MDydWXObliSYPJPDzhFx/zZaqzn94oy5XxK\nEpgtP0iJuvOAn1YYmJJMmhHey2ll7TBXnyiz5+G9Lh/yD1w99+C2rwDWdGVzQ2Rp\nR7mhTo/YmTMGKhM2Xx4o3rj8VX5R/yjXKPu+Q0sVlsnOiGtGEE+m2PIih7aiR5Vg\nU6gqGEO5AgMBAAECggEAMR8ASExylUWO0ne1pUTzWLZSkbStzMZQ7MrJHos9aE/m\nEOaWAMwIviZIww8RErRK+ZFpHT8R4u9ElV8Odk1vk87MOfwmxi8IqW3Vc3l7gpDh\nmG8rVEkMq2Qmqddmx75vAmkbKiZ0PisKetyghj2p7OV/76Q6El4iWS+R8uGhkQWI\nkFaR3shITVp17wALSyscbhBi9Nru+nO5LPVdgOzczdpddcCJxiP2qIVZJvnz3n87\n9V1SSViFhck4ycP5seIf0SK5rcaVOdHZ6R2h8UAizvdoM6esbsKsS281t13ZsDZO\n0DvwHpYcbBToAr4Y8fmYavAvO6do1HHlgKVtoV60HQKBgQDyR9ql4z6nqQaZgK1w\neDqUAABSllLUt9mi5obm5Ipqqunoha9Cn8EjxMtNL7uqGVe4EwRqEcTQOI3R5vdi\nJ8HeC+Ag/HQwoR5efDcSfw5efdz8CavckU4YxWHFxn9A5sYtFE0bNZ/0Z1K2cn5k\nEIkNaFPUul+Qinlicb22yfWp/QKBgQDvKXq4eoe83qEscWpyRVJXziWLpW/P1pZW\nlsQ7zThSF7o39oO16tO38OkA8uGQUmHd09MaM7JQYTQff05c0xu0je+4162+C4eU\nLzGeGs+letL7HWqB0ffqXX1ezMhWxQ/T16cQr57ViDR1pGdOausLZAGZg+HaSprA\n2NEXuzJfbQKBgQCVJVacOEAhxhOh+2zJh7nH0hhgvtlOyb7YYUE6cgYjlANaeLFj\nOiUTd9oPMgs8s00kq9BT24xlAeuMA7rWWdMmdfkLVV3Rcd3YHG9qm3yk/qZDIVEC\n/xAsf5WowoEj2uy0Y4Lz9Rb6xYBNgD3+K4+zCT5R/klGGXiP+aToGXt5oQKBgFLL\naVC0GomoCOP533/vv7HmC9lsTGkHQMR5LTYGtZi13iHBlZdE1Ea5f/B0JOJxoq/I\nxSws+W4aOJEu4VIBQ3YeLP8wq1U/aJBERkkVvwzqmF+Wr2iB5/Gaq+xFuJVRY0lT\nPuLn6XTC0mZno9vh57zpwiQDJA0OBsT8SmaMx8OBAoGBAN/1HRQGQ51mXAGBPZGp\necguUmU7F4msRxwjNrcmC9J5U98w+7HoCESQyp00nRv56cJWbRQ9/t8sle7fD6xs\nnA0Xj3FY2eXxzb7TDufxU8EQVqfimEe50QjgGqBNUf/FuqXP4uZLpAjcU7uyaHSO\nO8cnXetsrUZORmudLnJtcS4/\n-----END PRIVATE KEY-----\n"

//    dataTask.resume()
    let fcm = FCM(email: "firebase-adminsdk-l6kcq@mhi-test-58b3b.iam.gserviceaccount.com",
                  projectId: "mhi-test-58b3b",
                  key: key)
    
    fcm.apnsDefaultConfig = FCMApnsConfig(headers: [:],
                                          aps: FCMApnsApsObject(sound: "default"))
    fcm.androidDefaultConfig = FCMAndroidConfig(ttl: "86400s",
                                                restricted_package_name: "com.example.myapp",
                                                notification: FCMAndroidNotification(sound: "default"))
    fcm.webpushDefaultConfig = FCMWebpushConfig(headers: [:],
                                                data: [:],
                                                notification: [:])

    
    services.register(fcm, as: FCM.self)
    
    /// Register providers first
    try services.register(FluentSQLiteProvider())

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a SQLite database
    let sqlite = try SQLiteDatabase(storage: .memory)

    /// Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: sqlite, as: .sqlite)
    services.register(databases)

    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Todo.self, database: .sqlite)
    services.register(migrations)

}

func saveJSON() -> FCM? {
    
// Get the url of Persons.json in document directory
guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
let fileUrl = documentsDirectoryUrl.appendingPathComponent("serviceAccountKey.json")

let fcm = FCM(pathToServiceAccountKey: fileUrl.absoluteString)
//                    services.register(fcm, as: FCM.self)

fcm.apnsDefaultConfig = FCMApnsConfig(headers: [:],
                                      aps: FCMApnsApsObject(sound: "default"))
fcm.androidDefaultConfig = FCMAndroidConfig(ttl: "86400s",
                                            restricted_package_name: "com.example.myapp",
                                            notification: FCMAndroidNotification(sound: "default"))
fcm.webpushDefaultConfig = FCMWebpushConfig(headers: [:],
                                            data: [:],
                                            notification: [:])
    return fcm;

}
