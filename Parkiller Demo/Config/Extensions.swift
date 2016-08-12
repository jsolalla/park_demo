//
//  Extensions.swift
//  Parkiller Demo
//
//  Created by Jesus Santa Olalla on 8/11/16.
//  Copyright © 2016 jsolalla. All rights reserved.
//

import UIKit


extension Int {
    
    func toDecimal() -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        return formatter.stringFromNumber(self)!
    }
    
}

extension UIViewController {
        
    public func setUpNavigationBar(title:String) {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.navigationController?.navigationBar.topItem?.title = title
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.mkPrincipalBlue()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    func showAlert(tittle : String, message : String) {
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Dissmiss", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showSettingsAlert(tittle : String, message : String)  {
        let alert = UIAlertController (title: tittle, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            let settingsUrl = NSURL(string: UIApplicationOpenSettingsURLString)
            if let url = settingsUrl {
                UIApplication.sharedApplication().openURL(url)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showAlertWithCompletion(tittle : String, message : String, completion: () -> Void) {
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Dissmiss", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            completion()
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showAlertWithCompletionOptions(tittle : String, message : String, completion: (yes:Bool) -> Void) {
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            completion(yes:true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: { (UIAlertAction) -> Void in
            completion(yes:false)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func sendLocalNotificationWithText(message: String) {
        
        if UIApplication.sharedApplication().applicationState == .Background {
            print("App is in backgroud")
        }
        
        let notification = UILocalNotification()
        notification.alertBody = message
        notification.fireDate = NSDate(timeIntervalSinceNow: 0)
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
}

extension UIColor {
    
    /* Blue theme */
    
    class func mkPrincipalBlue() -> UIColor {
        let red = CGFloat(56) / 255
        let green = CGFloat(142) / 255
        let blue = CGFloat(229) / 255
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    class func mk200mts() -> UIColor {
        let red = CGFloat(227) / 255
        let green = CGFloat(72) / 255
        let blue = CGFloat(37) / 255
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    class func mk100mts() -> UIColor {
        let red = CGFloat(117) / 255
        let green = CGFloat(117) / 255
        let blue = CGFloat(82) / 255
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    class func mk50mts() -> UIColor {
        let red = CGFloat(255) / 255
        let green = CGFloat(241) / 255
        let blue = CGFloat(67) / 255
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    class func mk10mts() -> UIColor {
        let red = CGFloat(93) / 255
        let green = CGFloat(197) / 255
        let blue = CGFloat(78) / 255
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    class func mkPrincipalRed() -> UIColor {
        let red = CGFloat(255) / 255
        let green = CGFloat(51) / 255
        let blue = CGFloat(51) / 255
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}