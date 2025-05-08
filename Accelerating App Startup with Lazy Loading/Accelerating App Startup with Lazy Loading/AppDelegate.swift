//
//  AppDelegate.swift
//  Accelerating App Startup with Lazy Loading
//
//  Created by Stephano Portella on 03/05/25.
//
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = CardsStackViewController()
        let nav = UINavigationController(rootViewController: rootVC)
        // No hide navigation bar
        nav.navigationBar.prefersLargeTitles = false
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }
}
