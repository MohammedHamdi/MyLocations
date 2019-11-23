//
//  AppDelegate.swift
//  MyLocations
//
//  Created by Mohammed Hamdi on 11/6/19.
//  Copyright © 2019 Mohammed Hamdi. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Couldn't load data store: \(error)")
            }
        }
        return container
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = persistentContainer.viewContext

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        customApperance()
        
        if #available(iOS 13.0, *) {
            
        } else {
            let tabController = window!.rootViewController as! UITabBarController
            
            if let tabViewControllers = tabController.viewControllers {
                // Tab 1
                var navController = tabViewControllers[0] as! UINavigationController
                let controller1 = navController.viewControllers.first as! CurrentLocationViewController
                controller1.managedObjectContext = managedObjectContext
                
                // Tab 2
                navController = tabViewControllers[1] as! UINavigationController
                let controller2 = navController.viewControllers.first as! LocationsViewController
                controller2.managedObjectContext = managedObjectContext
                let _ = controller2.view
                
                // Tab 3
                navController = tabViewControllers[2] as! UINavigationController
                let controller3 = navController.viewControllers.first as! MapViewController
                controller3.managedObjectContext = managedObjectContext
            }
            listenForFatalCoreDataNotifications()
        }
        print(applicationDocumentsDirectory)
        
        
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

    // MARK:- Helper Methods
    func listenForFatalCoreDataNotifications() {
        NotificationCenter.default.addObserver(forName: CoreDataSaveFailedNotification, object: nil, queue: OperationQueue.main) { (notification) in
            let message = """
    There was a fatal error in the app and it cannot continue.
    Press OK to terminate the app. Sorry for the inconvenience.
    """
            let alert = UIAlertController(title: "Internal Error", message: message, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default) { (_) in
                let exception = NSException(name: NSExceptionName.internalInconsistencyException, reason: "Fatal Core Data error", userInfo: nil)
                exception.raise()
            }
            alert.addAction(action)
            
            let tabController = self.window!.rootViewController!
            tabController.present(alert, animated: true, completion: nil)
        }
    }
    
    func customApperance() {
        UINavigationBar.appearance().barTintColor = UIColor.black
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        UITabBar.appearance().barTintColor = UIColor.black
        
        let tintColor = UIColor(red: 255/255.0, green: 238/255.0, blue: 136/255.0, alpha: 1.0)
        UITabBar.appearance().tintColor = tintColor
    }
}

