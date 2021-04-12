//
//  Extensions.swift
//  IP_Tracker_Akshay_Awtade
//
//  Created by Akshay Awtade on 03/04/21.
//  Copyright © 2021 Akshay Awtade. All rights reserved.
//

import Foundation
import UIKit
import MapKit


extension UIView {
func setview(backgroundcolor: UIColor,shadowcolor: UIColor,shadowradius: CGFloat,shadowopacity: Float,cornerradius: CGFloat,bound: Bool,offsetWidth:Int,offsetHeight:Int,bordercolor: UIColor,borderwidth: CGFloat){
    self.backgroundColor = backgroundcolor
    self.layer.shadowColor = shadowcolor.cgColor
    self.layer.shadowRadius = shadowradius
    self.layer.shadowOpacity = shadowopacity
    self.layer.shadowOffset = CGSize(width:offsetWidth, height:offsetHeight)
    self.layer.cornerRadius = cornerradius
    self.layer.masksToBounds = bound
    self.layer.borderColor = bordercolor.cgColor
    self.layer.borderWidth = borderwidth
}
    
    func makeCornerRadius(corners: UIRectCorner,cornerRadius: CGFloat){
        
        let maskPath = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                    cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))

        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        self.layer.mask = shape
    }
}



extension UIColor{
    
    func setColorRGB(r:CGFloat,g:CGFloat,b:CGFloat){
        UIColor.init(red: r, green: g, blue: b, alpha: 1)
    }
}



 extension MKMapView {

    func centerToLocation(_ location: CLLocation,regionRadius: CLLocationDistance) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
    
    func setAnnotation(lat:CLLocationDegrees,long:CLLocationDegrees,title:String){
           let annotation = MKPointAnnotation()
           annotation.title = title
           annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
           self.addAnnotation(annotation)
       }
    
}
