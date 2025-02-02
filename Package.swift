// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "vapor",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v11),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "Vapor", targets: ["Vapor"]),
        .library(name: "XCTVapor", targets: ["XCTVapor"]),
    ],
    dependencies: [
        // HTTP client library built on SwiftNIO
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.10.0"),

        // Sugary extensions for the SwiftNIO library
        .package(url: "https://github.com/EdadealMobileDevelopment/async-kit.git", from: "1.12.1"),

        // 💻 APIs for creating interactive CLI tools.
        .package(url: "https://github.com/vapor/console-kit.git", from: "4.0.0"),

        // 🚍 High-performance trie-node router.
        .package(url: "https://github.com/EdadealMobileDevelopment/routing-kit.git", from: "4.5.1"),

        // 💥 Backtraces for Swift on Linux
        .package(url: "https://github.com/swift-server/swift-backtrace.git", from: "1.1.1"),
        
        // Event-driven network application framework for high performance protocol servers & clients, non-blocking.
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.33.0"),
        
        // Bindings to OpenSSL-compatible libraries for TLS support in SwiftNIO
        .package(url: "https://github.com/makleso6/swift-nio-ssl.git", from: "2.20.1"),
        
        // HTTP/2 support for SwiftNIO
        .package(url: "https://github.com/apple/swift-nio-http2.git", from: "1.20.0"),
        
        // Useful code around SwiftNIO.
        .package(url: "https://github.com/apple/swift-nio-extras.git", from: "1.0.0"),
        
        // Swift logging API
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),

        // Swift metrics API
        .package(url: "https://github.com/apple/swift-metrics.git", from: "2.0.0"),

        // WebSocket client library built on SwiftNIO
        .package(url: "https://github.com/EdadealMobileDevelopment/websocket-kit.git", from: "2.4.2"),
        
        // MultipartKit, Multipart encoding and decoding
        .package(url: "https://github.com/vapor/multipart-kit.git", from: "4.2.1"),
    ],
    targets: [
        // C helpers
        .target(name: "CBase32"),
        .target(name: "CBcrypt"),
        .target(name: "COperatingSystem"),
        .target(name: "CURLParser"),

        // Vapor
        .target(name: "Vapor", dependencies: [
            .product(name: "AsyncHTTPClient", package: "async-http-client"),
            .product(name: "AsyncKit", package: "async-kit"),
            .product(name: "Backtrace", package: "swift-backtrace"),
            .target(name: "CBase32"),
            .target(name: "CBcrypt"),
            .target(name: "COperatingSystem"),
            .target(name: "CURLParser"),
            .product(name: "ConsoleKit", package: "console-kit"),
            .product(name: "Logging", package: "swift-log"),
            .product(name: "Metrics", package: "swift-metrics"),
            .product(name: "NIO", package: "swift-nio"),
            .product(name: "NIOConcurrencyHelpers", package: "swift-nio"),
            .product(name: "NIOCore", package: "swift-nio"),
            .product(name: "NIOExtras", package: "swift-nio-extras"),
            .product(name: "NIOFoundationCompat", package: "swift-nio"),
            .product(name: "NIOHTTPCompression", package: "swift-nio-extras"),
            .product(name: "NIOHTTP1", package: "swift-nio"),
            .product(name: "NIOHTTP2", package: "swift-nio-http2"),
            .product(name: "NIOSSL", package: "swift-nio-ssl"),
            .product(name: "NIOWebSocket", package: "swift-nio"),
            .product(name: "RoutingKit", package: "routing-kit"),
            .product(name: "WebSocketKit", package: "websocket-kit"),
            .product(name: "MultipartKit", package: "multipart-kit"),
        ]),
	
        // Development
        .executableTarget(name: "Development", dependencies: [
            .target(name: "Vapor"),
        ], swiftSettings: [
            // Enable better optimizations when building in Release configuration. Despite the use of
            // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
            // builds. See <https://github.com/swift-server/guides#building-for-production> for details.
            .unsafeFlags([
                            "-cross-module-optimization"
            ], .when(configuration: .release)),
        ]),

        // Testing
        .target(name: "XCTVapor", dependencies: [
            .target(name: "Vapor"),
        ]),
        .testTarget(name: "VaporTests", dependencies: [
            .product(name: "NIOTestUtils", package: "swift-nio"),
            .target(name: "XCTVapor"),
        ], resources: [
            .copy("Utilities/foo.txt"),
            .copy("Utilities/index.html"),
            .copy("Utilities/SubUtilities/"),
            .copy("Utilities/foo bar.html"),
            .copy("Utilities/test.env"),
            .copy("Utilities/my-secret-env-content"),
        ]),
        .testTarget(name: "AsyncTests", dependencies: [
            .product(name: "NIOTestUtils", package: "swift-nio"),
            .target(name: "XCTVapor"),
        ]),
    ]
)
