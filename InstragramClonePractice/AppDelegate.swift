//
//  AppDelegate.swift
//  InstragramClonePractice
//
//  Created by Kelly Douglass on 6/5/18.
//  Copyright © 2018 Kelly Douglass. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Enable storing and querying data from Local Datastore.
		// Remove this line if you don't want to use Local Datastore features or want to use cachePolicy.
		Parse.enableLocalDatastore()
		
		let parseConfiguration = ParseClientConfiguration(block: { (ParseMutableClientConfiguration) -> Void in
			ParseMutableClientConfiguration.applicationId = "6f9423ad5fc6ca80376d9378d851945dd3c2bc0c"
			ParseMutableClientConfiguration.clientKey = "fcdb394110a694fd221bede4069fd4e0ddf3dc00"
			ParseMutableClientConfiguration.server = "http://18.221.243.181:80/parse"
		})
		
		Parse.initialize(with: parseConfiguration)
		
		
		// ****************************************************************************
		// Uncomment and fill in with your Parse credentials:
		// Parse.setApplicationId("your_application_id", clientKey: "your_client_key")
		//
		// If you are using Facebook, uncomment and add your FacebookAppID to your bundle's plist as
		// described here: https://developers.facebook.com/docs/getting-started/facebook-sdk-for-ios/
		// Uncomment the line inside ParseStartProject-Bridging-Header and the following line here:
		// PFFacebookUtils.initializeFacebook()
		// ****************************************************************************
		
		let defaultACL = PFACL();
		
		// If you would like all objects to be private by default, remove this line.
		//defaultACL.getPublicReadAccess = true
		
		PFACL.setDefault(defaultACL, withAccessForCurrentUser: true)
		
		if application.applicationState != UIApplicationState.background {
			// Track an app open here if we launch with a push, unless
			// "content_available" was used to trigger a background push (introduced in iOS 7).
			// In that case, we skip tracking here to avoid double counting the app-open.
			/*
			let preBackgroundPush = !application.responds(to: #selector(getter: UIApplication.backgroundRefreshStatus))
			let oldPushHandlerOnly = !self.responds(to: #selector(UIApplicationDelegate.application(_:didReceiveRemoteNotification:fetchCompletionHandler:)))
			var noPushPayload = false;
			if let options = launchOptions {
			noPushPayload = options[UIApplicationLaunchOptionsRemoteNotificationKey] != nil;
			}
			if (preBackgroundPush || oldPushHandlerOnly || noPushPayload) {
			PFAnalytics.trackAppOpened(launchOptions: launchOptions)
			}
			*/
		}
		return true
	}
	
	//--------------------------------------
	// MARK: Push Notifications
	//--------------------------------------
	
	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
		let installation = PFInstallation.current()
		installation?.setDeviceTokenFrom(deviceToken)
		installation?.saveInBackground()
		
		PFPush.subscribeToChannel(inBackground: "") { (succeeded, error) in // (succeeded: Bool, error: NSError?) is now (succeeded, error)
			
			if succeeded {
				print("ParseStarterProject successfully subscribed to push notifications on the broadcast channel.\n");
			} else {
				print("ParseStarterProject failed to subscribe to push notifications on the broadcast channel with error = %@.\n" as Any)
			}
		}
	}
	
	
	func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
		let error = error as NSError
		if error.code == 3010 {
			print("Push notifications are not supported in the iOS Simulator.\n")
		} else {
			print("application:didFailToRegisterForRemoteNotificationsWithError: %@\n", error)
		}
	}
	
	func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
		PFPush.handle(userInfo)
		if application.applicationState == UIApplicationState.inactive {
			PFAnalytics.trackAppOpened(withRemoteNotificationPayload: userInfo)
		}
	}
	

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}


}

