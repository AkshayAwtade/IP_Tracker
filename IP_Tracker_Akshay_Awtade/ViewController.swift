//
//  ViewController.swift
//  IP_Tracker_Akshay_Awtade
//
//  Created by Akshay Awtade on 31/03/21.
//  Copyright © 2021 Akshay Awtade. All rights reserved.
//

import UIKit
import MapKit
import Toast_Swift
class ViewController: UIViewController,UITextFieldDelegate,MKAnnotation {
    
    @IBOutlet weak var textFeildIP: UITextField!
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var labelIPAddress: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelTimeZone: UILabel!
    @IBOutlet weak var labelISP: UILabel!
    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let apiCall = APICall()
    var responseData : MainResponse?
    var coordinate = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewDetailsLayout()
        self.buttonNext.makeCornerRadius(corners: [.topRight,.bottomRight], cornerRadius: 15)
        self.textFeildIP.makeCornerRadius(corners: [.topLeft,.bottomLeft], cornerRadius: 15)
        self.activityIndicatorStartStop(onOffStatus: true, animationStatus: false)
        
        
    }
    
    
    func viewDetailsLayout(){
        viewDetails.setview(backgroundcolor: UIColor.white, shadowcolor: UIColor.darkGray, shadowradius: 5, shadowopacity: 0.8, cornerradius: 15, bound: true, offsetWidth: 5, offsetHeight: 5, bordercolor: UIColor.darkGray, borderwidth: 0.3)
    }
    
    @IBAction func GoButtonTapped(_ sender: Any) {
        self.textFeildIP.resignFirstResponder()
        if(textFeildIP.text?.count == 0){
            self.view.makeToast("Please enter IP address and try again", duration: 3.0, position: .bottom)
        }else{
            self.activityIndicatorStartStop(onOffStatus: false, animationStatus: true)
           
            let parameters = ["apiKey":ipifyGeoLocationKey,
                              "ipAddress": self.textFeildIP.text!]
            apiCall.apiCallData(urlStr: geoLocationURL,params:parameters) { responseData in
                if !responseData.isEmpty{
                    do{
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                        self.responseData = try jsonDecoder.decode(MainResponse.self, from: responseData)
                        self.setDataToView()
                    }catch{
                        self.activityIndicatorStartStop(onOffStatus: true, animationStatus: false)
                        self.view.makeToast("Something went wrong")
                    }
                }else{
                    self.activityIndicatorStartStop(onOffStatus: true, animationStatus: false)
                    self.view.makeToast("Something went wrong")
                }
            }
        }
    }
    
    func activityIndicatorStartStop(onOffStatus :Bool , animationStatus: Bool){
        self.activityIndicator.isHidden = onOffStatus
        switch animationStatus {
        case true:
            self.activityIndicator.startAnimating()
        default:
            self.activityIndicator.stopAnimating()
        }
        
    }
    
    
    func setDataToView(){
        self.labelIPAddress.text = self.responseData?.ip
        self.labelLocation.text = self.responseData?.location.city
        self.labelISP.text = self.responseData?.isp
        self.labelTimeZone.text = self.responseData?.location.timezone
        self.activityIndicatorStartStop(onOffStatus: true, animationStatus: false)
        self.setLocationCoordinates(lat: (self.responseData?.location.lat)!, long: (self.responseData?.location.lng)!)
        self.saveDataToDB()
    }
    
    func saveDataToDB(){
        apiCall.apiCallData(urlStr: "localhost:8888/iptracker/insertDetails.php", params: ["ipaddr":"23.234.23.3",
                                                                                           "lat":"4444",
                                                                                           "lng":"55555",
                                                                                           "isp":"One Broadband",
                                                                                           "location":"Mumbai",
                                                                                           "timezone":"IST"]) { (data) in
            print("testeeddddd")
        }
    }
    
    func setLocationCoordinates(lat:CLLocationDegrees,long:CLLocationDegrees){
        let locationCords = CLLocation(latitude:lat, longitude: long)
        mapview.centerToLocation(locationCords, regionRadius: 20)
        let region = MKCoordinateRegion(
            center: locationCords.coordinate,
            latitudinalMeters: 0,
            longitudinalMeters: 0)
        self.mapview.setCameraBoundary(
            MKMapView.CameraBoundary(coordinateRegion: region),
            animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 17000)
        self.mapview.setCameraZoomRange(zoomRange, animated: true)
        mapview.setAnnotation(lat: (self.responseData?.location.lat)!, long: (self.responseData?.location.lng)!, title: self.responseData!.ip)
        
        //self.mapview.addAnnotation()
    }
    

}



