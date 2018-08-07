import FluentSQLite
import Vapor
import FCM

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    
    let fcm = FCM(pathToServiceAccountKey: "mhi-test-58b3b-firebase-adminsdk-l6kcq-7df896fcbe.json")
    
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
