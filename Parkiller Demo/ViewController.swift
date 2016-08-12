//
//  ViewController.swift
//  Parkiller Demo
//
//  Created by Jesus Santa Olalla on 8/11/16.
//  Copyright © 2016 jsolalla. All rights reserved.
//

import UIKit
import GoogleMaps
import Social

class ViewController: UIViewController {

    @IBOutlet weak var viewDistanceDetails: UIView!
    @IBOutlet weak var lblMessageDescription: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var btnSetDestination: UIButton!
    @IBOutlet weak var bottomBtnDestinationConstraint: NSLayoutConstraint!
    @IBOutlet weak var topViewDistanceConstraint: NSLayoutConstraint!
    
    private let locationManager = CLLocationManager()
    private let tools = Tools()
    
    private var imagePinView: UIImageView?
    private var marker: GMSMarker?
    private var currentLocation: CLLocation?
    private var lastLocation: CLLocation?
    private var temporalLocation: CLLocation?
    private var didFindMyLocation = false
    private var isDestinationSet = false
    private var isTweetSent = false
    private var isLocalSent = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setUpNavigationBar("Parkiller -  Demo")
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        mapView.settings.myLocationButton = true
        mapView.delegate = self;
        
        mapView.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.New, context: nil)
        cofigureDetailView()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        configurePinView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if !didFindMyLocation {
            let myLocation: CLLocation = change![NSKeyValueChangeNewKey] as! CLLocation
            mapView.camera = GMSCameraPosition.cameraWithTarget(myLocation.coordinate, zoom: 15.0)
            mapView.settings.myLocationButton = true
            didFindMyLocation = true
        }
    }
    
    func configurePinView() {
        
        imagePinView = UIImageView(image: UIImage(named: "pin"))
        imagePinView!.frame = CGRectMake(0, 0, 40, 40)
        imagePinView!.center = CGPointMake(self.view.frame.size.width / 2,
                                           self.view.frame.size.height / 2 - 60)
        self.view.addSubview(imagePinView!)

        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.2, options: .CurveEaseIn, animations: {
            self.imagePinView!.frame = CGRectMake(0, 0, 40, 40)
            self.imagePinView!.center = CGPointMake(self.view.frame.size.width / 2,
                self.view.frame.size.height / 2 - 40)
        }) { (finished) in
            
        }

    }
    
    func cofigureDetailView() {
        self.topViewDistanceConstraint.constant = -100
        viewDistanceDetails.layer.shadowColor = UIColor.blackColor().CGColor
        viewDistanceDetails.layer.shadowOpacity = 0.3
        viewDistanceDetails.layer.shadowRadius = 10
        self.view.layoutIfNeeded()
    }
    
    func evaluateDistance(distance:Int) {
        
        if distance > 200 {
            lblMessageDescription.text = UP_200MTS_MESSAGE
            isTweetSent = false
            if isLocalSent == 0 || isLocalSent != 1 {
                self.sendLocalNotificationWithText(UP_200MTS_MESSAGE)
                isLocalSent = 1
            }
        } else if distance > 100 && distance <= 200 {
            lblMessageDescription.text = UP_100200MTS_MESSAGE
            isTweetSent = false
            if isLocalSent == 0 || isLocalSent != 2 {
                self.sendLocalNotificationWithText(UP_100200MTS_MESSAGE)
                isLocalSent = 2
            }
        } else if distance > 50 && distance <= 100 {
            lblMessageDescription.text = UP_50100MTS_MESSAGE
            isTweetSent = false
            if isLocalSent == 0 || isLocalSent != 3 {
                self.sendLocalNotificationWithText(UP_50100MTS_MESSAGE)
                isLocalSent = 3
            }
        } else if distance > 10 && distance <= 50 {
            lblMessageDescription.text = UP_1050MTS_MESSAGE
            isTweetSent = false
            if isLocalSent == 0 || isLocalSent != 4 {
                self.sendLocalNotificationWithText(UP_1050MTS_MESSAGE)
                isLocalSent = 4
            }
        } else {
            lblMessageDescription.text = IN_10MTS_MESSAGE
            if !isTweetSent {
                self.sendLocalNotificationWithText(IN_10MTS_MESSAGE)
                delay(seconds: 1.0, completion: { 
                    self.sendTweet()
                })
            }
        }
        
        lblDistance.text = "\(distance.toDecimal())m"
    }
    
    func sendTweet() {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            let twitterController:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterController.setInitialText("I'm at the objective point! \(lastLocation!.coordinate.latitude) - \(lastLocation!.coordinate.longitude)")
            let layer = UIApplication.sharedApplication().keyWindow!.layer
            let scale = UIScreen.mainScreen().scale
            UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
            
            layer.renderInContext(UIGraphicsGetCurrentContext()!)
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            twitterController.addImage(screenshot)
            self.presentViewController(twitterController, animated: true, completion: nil)
            isTweetSent = true
        } else {
            let alert = UIAlertController(title: "Twitter Account", message: "Please login to your Twitter account.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func setDestinationPoint(sender: UIButton) {
        if isDestinationSet {
            
            isDestinationSet = false
            isTweetSent = false
            mapView.clear()
            configurePinView()
            lastLocation = temporalLocation
            sender.setTitle("Set destination", forState: .Normal)
            sender.backgroundColor = UIColor.whiteColor()
            sender.setTitleColor(UIColor.blackColor(), forState: .Normal)
            
            UIView.animateWithDuration(0.5, animations: {
                self.topViewDistanceConstraint.constant = -100
                self.view.layoutIfNeeded()
            })
            
        } else {
            
            imagePinView?.removeFromSuperview()
            sender.setTitle("End trip", forState: .Normal)
            sender.backgroundColor = UIColor.mkPrincipalRed()
            sender.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            marker = GMSMarker(position: lastLocation!.coordinate)
            marker!.opacity = 0.8
            marker!.title = "Destination"
            marker!.snippet = ""
            marker!.map = mapView
            isDestinationSet = true
            
            let circleCenter = lastLocation!.coordinate
            var circ = GMSCircle(position: circleCenter, radius: 10)
            
            circ.fillColor = UIColor.clearColor()
            circ.strokeColor = UIColor.mk10mts()
            circ.strokeWidth = 3
            circ.map = mapView
            
            circ = GMSCircle(position: circleCenter, radius: 50)
            
            circ.fillColor = UIColor.clearColor()
            circ.strokeColor = UIColor.mk50mts()
            circ.strokeWidth = 3
            circ.map = mapView
            
            circ = GMSCircle(position: circleCenter, radius: 100)
            circ.fillColor = UIColor.clearColor()
            circ.strokeColor = UIColor.mk100mts()
            circ.strokeWidth = 3
            circ.map = mapView
            
            circ = GMSCircle(position: circleCenter, radius: 200)
            circ.fillColor = UIColor.clearColor()
            circ.strokeColor = UIColor.mk200mts()
            circ.strokeWidth = 3
            circ.map = mapView
            
            UIView.animateWithDuration(0.5, animations: { 
                self.topViewDistanceConstraint.constant = 20
                self.view.layoutIfNeeded()
            })
            
        }
        
    }
    
}

extension ViewController: GMSMapViewDelegate {
    
    func mapView(mapView: GMSMapView, didChangeCameraPosition position: GMSCameraPosition) {
        
    }
    
    func mapView(mapView: GMSMapView, idleAtCameraPosition position: GMSCameraPosition) {
        let newLocation = CLLocation(latitude: position.target.latitude, longitude: position.target.longitude)
        if !isDestinationSet {
            lastLocation = newLocation
        }
        
        temporalLocation = newLocation
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: \(error.localizedDescription)")
        locationManager.stopUpdatingLocation()
        showSettingsAlert("Parkiller - Demo", message: "Your location is required to use the app")
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways {
            locationManager.startUpdatingLocation()
            mapView.myLocationEnabled = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
        if isDestinationSet {
            let distance = Int(tools.getDistanceInMeters(currentLocation, newLocation: lastLocation!)!)
            evaluateDistance(distance)
        }
        
    }
    
}
