//
//  AppDelegate.swift
//  OpenWeather
//
//  Created by Achref Ben Tekaya on 13/3/2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // Define a lazy variable called `persistentContainer` of type `NSPersistentContainer`.
    lazy var persistentContainer: NSPersistentContainer = {

        // Initialize a new `NSPersistentContainer` with the name "CityData".
        let container = NSPersistentContainer(name: "CityData")

        // Load the persistent stores associated with the container using the `loadPersistentStores(completionHandler:)` method.
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            // Check for any errors during the loading process.
            if let error = error {
                // If an error is found, terminate the program and print an error message that includes the error information.
                fatalError("Unresolved error, \((error as NSError).userInfo)")
            }
        })

        // Return the initialized container.
        return container
    }()

}

