//
//  Extensions.swift
//  Parkiller Demo
//
//  Created by Jesus Santa Olalla on 8/11/16.
//  Copyright © 2016 jsolalla. All rights reserved.
//

import UIKit


extension UIViewController {
    
    public func showActivityIndicator(view: UIView, seconds: Double, completion: () -> Void) {
        
        let indicatorView = UIView()
        indicatorView.frame = view.frame
        indicatorView.center = view.center
        indicatorView.backgroundColor = UIColor.clearColor()
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRectMake(0, 0, 80, 80)
        loadingView.center = view.center
        loadingView.backgroundColor = UIColor.blackColor()
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.WhiteLarge
        actInd.center = CGPointMake(loadingView.frame.size.width / 2,
                                    loadingView.frame.size.height / 2);
        loadingView.addSubview(actInd)
        indicatorView.addSubview(loadingView)
        view.addSubview(indicatorView)
        actInd.startAnimating()
        
        delay(seconds: seconds) {
            indicatorView.removeFromSuperview()
            completion()
        }
        
    }
    
    public func shakeView(viewToShake: UIView){
        
        let shake:CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        var from_point:CGPoint = CGPointMake(viewToShake.center.x - 5, viewToShake.center.y)
        var from_value:NSValue = NSValue(CGPoint: from_point)
        
        var to_point:CGPoint = CGPointMake(viewToShake.center.x + 5, viewToShake.center.y)
        var to_value:NSValue = NSValue(CGPoint: to_point)
        
        shake.fromValue = from_value
        shake.toValue = to_value
        viewToShake.layer.addAnimation(shake, forKey: "position")
        
        from_point = CGPointMake(viewToShake.center.x - 5, viewToShake.center.y)
        from_value = NSValue(CGPoint: from_point)
        
        to_point = CGPointMake(viewToShake.center.x + 5, viewToShake.center.y)
        to_value = NSValue(CGPoint: to_point)
        
        shake.fromValue = from_value
        shake.toValue = to_value
        viewToShake.layer.addAnimation(shake, forKey: "position")
    }
    
    public func addLeftBarButtonWithImage(buttonImage: UIImage) {
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = leftButton
    }
    
    public func addRightBarButtonWithImage(buttonImage: UIImage) {
        let rightButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = rightButton
    }
    
    public func popViewController() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    public func setUpNavigationBar(title:String) {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.navigationController?.navigationBar.topItem?.title = title
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.mkPrincipalBlue()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    public func setUpSlideNavigationBar(title:String) {
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
    
    func showAlertWithCompletionOptionsAndActions(tittle: String, yesAction: String, noAction: String, message: String, completion: (yes:Bool) -> Void) {
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: noAction, style: UIAlertActionStyle.Cancel, handler: { (UIAlertAction) -> Void in
            completion(yes:false)
        }))
        alert.addAction(UIAlertAction(title: yesAction, style: UIAlertActionStyle.Destructive, handler: { (UIAlertAction) -> Void in
            completion(yes:true)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
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
    
    class func mkSecondaryBlueLight() -> UIColor {
        let red = CGFloat(14) / 255
        let green = CGFloat(80) / 255
        let blue = CGFloat(152) / 255
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    class func mkSecondaryBlueDark() -> UIColor {
        let red = CGFloat(7) / 255
        let green = CGFloat(69) / 255
        let blue = CGFloat(137) / 255
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    class func mkTerciaryBlueLight() -> UIColor {
        let red = CGFloat(20) / 255
        let green = CGFloat(100) / 255
        let blue = CGFloat(189) / 255
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}