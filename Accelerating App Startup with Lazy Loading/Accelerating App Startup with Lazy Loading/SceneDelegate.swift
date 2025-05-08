//
//  SceneDelegate.swift
//  Accelerating App Startup with Lazy Loading
//
//  Created by Stephano Portella on 03/05/25.
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        
        // Root view controller
        let rootVC = CardsStackViewController()
        let nav = UINavigationController(rootViewController: rootVC)
        
        // Asegurar barra visible
        nav.navigationBar.prefersLargeTitles = false
        nav.setNavigationBarHidden(false, animated: false)
        
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}
