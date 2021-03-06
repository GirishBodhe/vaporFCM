// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "vaporFCM",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
//
//        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0-rc.2"),

//        .package(url: "https://github.com/MihaelIsaev/FCM.git", from: "0.5.0"),

//        .package(url: "https://github.com/favret/PoutouPush.git", from: "0.0.5")
        // 👤 Authentication and Authorization layer for Fluent.
        .package(url: "https://github.com/vapor/auth.git", from: "2.0.0"),
        
        ],
    targets: [
        .target(name: "App", dependencies: ["Vapor","FluentSQLite","Authentication" /*,"PoutouPush","Crypto","FCM",*/]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

