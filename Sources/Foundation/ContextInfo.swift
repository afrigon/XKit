import Foundation

#if os(iOS)
import UIKit
#endif

public class ContextInfo {
    public enum Configuration {
        case debug
        case release
    }

    public enum TargetEnvironment {
        case simulator
        case macCatalyst
        case native
    }

    public enum Platform {
        case iOS
        case macOS
        case watchOS
        case tvOS
        case xrOS
    }

    #if DEBUG
    public let configuration: Configuration = .debug
    #else
    public let configuration: Configuration = .release
    #endif

    #if targetEnvironment(simulator)
    public let targetEnvironment: TargetEnvironment = .simulator
    #elseif targetEnvironment(macCatalyst)
    public let targetEnvironment: TargetEnvironment = .macCatalyst
    #else
    public let targetEnvironment: TargetEnvironment = .native
    #endif

    #if os(iOS)
    public let platform: Platform = .iOS
    #elseif os(macOS)
    public let platform: Platform = .macOS
    #elseif os(watchOS)
    public let platform: Platform = .watchOS
    #elseif os(tvOS)
    public let platform: Platform = .tvOS
    #elseif os(xrOS)
    public let platform: Platform = .xrOS
    #endif

    public private(set) lazy var testing: Bool = NSClassFromString("XCTest") != nil
    public private(set) lazy var jailbroken: Bool = isJailbroken()

    public static var shared: ContextInfo = .init()

    private func isJailbroken() -> Bool {
        #if !os(iOS)
        return false
        #else
        let files = [
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/etc/apt",
            "/usr/bin/ssh",
            "/usr/sbin/sshd",
            "/private/var/lib/apt"
        ]

        // check for common jailbreak files
        for path in files {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }

            let file = fopen(path, "r")
            guard file == nil else {
                fclose(file)
                return true
            }
        }

        // try to exit the app sandbox
        do {
            let path = "/private/x.txt"
            try "x".write(toFile: path, atomically: true, encoding: .utf8)
            try FileManager.default.removeItem(atPath: path)

            return true
        } catch {
            // Ignoring error since failure was expected
        }

        if let url = URL(string: "cydia://package/com.example.package"), UIApplication.shared.canOpenURL(url) {
            return true
        }

        return false
        #endif
    }
}
