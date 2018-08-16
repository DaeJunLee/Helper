//
//  AppDelegate.swift
//  Helper
//
//  Created by EJun on 2018. 5. 9..
//  Copyright © 2018년 EJun. All rights reserved.
//
import UIKit
import CoreData
import PasscodeLock

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    lazy var pinPresenter: PINPresenter = {
        let configuration = PINConfiguration()
        let presenter = PINPresenter(mainWindow: self.window, configuration: configuration)
        
        return presenter
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        pinPresenter.presentPasscodeLock()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        debugPrint("applicationWillResignActive")
    }
    
    /// Background mode, if it has background
    /// First(applicationWillResignActive) -> Second(applicationDidEnterBackground)
    /// - Parameter application: UIApplication
    func applicationDidEnterBackground(_ application: UIApplication) {
        debugPrint("applicationDidEnterBackground")
        pinPresenter.presentPasscodeLock()
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        debugPrint("applicationDidFinishLaunching")
    }

    /// Background mode, if it has background
    /// First(applicationWillResignActive) -> Second(applicationDidEnterBackground)
    /// - Parameter application: UIApplication
    func applicationWillEnterForeground(_ application: UIApplication) {
        debugPrint("applicationWillEnterForeground")
    }
    
    /// Foreground mode, if it has foreground -> The action is launching on top
    ///
    /// - Parameter application: UIApplication
    func applicationDidBecomeActive(_ application: UIApplication) {
        debugPrint("applicationDidBecomeActive")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        debugPrint("applicationWillTerminate")
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Helper")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}