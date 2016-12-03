//
//  AppDelegate.swift
//  test
//
//  Created by Dennis Chau on 2016-11-04.
//  Copyright © 2016 Dennis Chau. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    
    let notificationCentre = NotificationCenter.default
    let locationManager = CLLocationManager()
    var window: UIWindow?
    var currentLocation : CLLocation? = nil
    var gpsToggleObserver : AnyObject?
    var gpsToggle = false
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        gpsToggleObserver = notificationCentre.addObserver(forName: NSNotification.Name(rawValue: Notifications.gpsToggled),
                                                           object: nil,
                                                           queue: nil)
        {
            (note) in
            let toggle = Notifications.getGpsToggled(note)
            self.gpsToggle = toggle!
            self.update()
            
        }
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        if (self.gpsToggle == true) {
            locationManager.startUpdatingLocation()
        }
        else {
            locationManager.stopUpdatingLocation()
        }
        
        FIRApp.configure()
        
        return true
    }
    
    func update() {
        if (self.gpsToggle == true) {
            locationManager.startUpdatingLocation()
        }
        else {
            locationManager.stopUpdatingLocation()
        }
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        let db = FIRDatabase.database().reference()
        let deviceId = UIDevice.current.identifierForVendor!.uuidString
        db.child("locations").child(deviceId).removeValue()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        locationManager.stopUpdatingLocation()
        sleep(1)
        let db = FIRDatabase.database().reference()
        let deviceId = UIDevice.current.identifierForVendor!.uuidString
        db.child("locations").child(deviceId).removeValue()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last!
        Notifications.postLocationUpdated(self, location: currentLocation)
        /*
        if currentLocation == nil {
            currentLocation = locations.last!
            Notifications.postLocationUpdated(self, location: currentLocation)
        } else {
            let tmpLocation = locations.last!
            if currentLocation!.distance(from: tmpLocation) > 20 {
                currentLocation = tmpLocation
                Notifications.postLocationUpdated(self, location: currentLocation)
            }
        }*/
    }
    
}

