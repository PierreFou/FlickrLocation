//
//  PopVC.swift
//  pixel-city
//
//  Created by Caleb Stultz on 7/20/17.
//  Copyright © 2017 Caleb Stultz. All rights reserved.
//

import UIKit
import MapKit

class PopVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var popImageView: UIImageView!
    @IBOutlet weak var titlePictureLbl: UILabel!
    @IBOutlet weak var descriptionPictureLbl: UILabel!
    @IBOutlet weak var postedDatePictureLbl: UILabel!
    @IBOutlet weak var locationPictureMV: MKMapView!
    
    var passedImage: UIImage!
    var passedPhoto: Photo!
    let regionRadius: Double = 1000
    
    func initData(forImage image: UIImage, andPhoto photo: Photo) {
        self.passedImage = image
        self.passedPhoto = photo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popImageView.image = passedImage
        titlePictureLbl.text = passedPhoto.title
        descriptionPictureLbl.text = passedPhoto.description
        postedDatePictureLbl.text = passedPhoto.postedDate
        locationPictureMV.delegate = self
        
        centerMapOnPhotoLocation()
        addAnnotation()
        addDoubleTap()
    }
    
    func addDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(screenWasDoubleTapped))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        view.addGestureRecognizer(doubleTap)
    }
    
    @objc func screenWasDoubleTapped() {
        dismiss(animated: true, completion: nil)
    }

    
}

extension PopVC : MKMapViewDelegate{
    
    func centerMapOnPhotoLocation() {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(passedPhoto.location, regionRadius, regionRadius)
        locationPictureMV.setRegion(coordinateRegion, animated: true)
    }
    
    func addAnnotation(){
        let annotation = DroppablePin(coordinate: passedPhoto.location, identifier: "droppablePin")
        locationPictureMV.addAnnotation(annotation)
    }
}
