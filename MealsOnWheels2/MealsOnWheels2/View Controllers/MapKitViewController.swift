//
//  MapKitViewController.swift
//  MealsOnWheels2
//
//  Created by Craig Belinfante on 1/25/21.
//

import UIKit
import MapKit
import CoreData

class MapKitViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    // Properties
    let reuseIdentifier = "TruckAnnotationIdentifier"
    let locationManager = CLLocationManager()
    private var userTrackingButton: MKUserTrackingButton!
    var truckController = TruckController()
    let loginController = LoginController()
    
    
    var trucks: [TruckRep] = [] {
        didSet {
            setMapData()
        }
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if loginController.bearer == nil {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        }
        
        trucks = truckController.trucks
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        mapView.delegate = self
        locationManager.requestWhenInUseAuthorization()

        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: reuseIdentifier)

        userTrackingButton = MKUserTrackingButton(mapView: mapView)
        userTrackingButton.translatesAutoresizingMaskIntoConstraints = false
        mapView.addSubview(userTrackingButton)

        userTrackingButton.leftAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        userTrackingButton.bottomAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
    private func setMapData() {
        DispatchQueue.main.async {
            self.mapView.addAnnotations(self.trucks)
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTrucks" {
            let vc = segue.destination as! TruckTableViewController
            vc.trucks = truckController.trucks
        } else if segue.identifier == "LoginSegue" {
            if let loginVC = segue.destination as? LoginViewController {
                loginVC.loginController = loginController
                loginVC.isModalInPresentation = true
            }
            
        }
    }

}

extension MapKitViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier, for: annotation) as! MKMarkerAnnotationView
        
        guard let truck = annotation as? TruckRep else {return nil}
        
        annotationView.glyphImage = UIImage(systemName: "house")!
        annotationView.tintColor = .red
        annotationView.canShowCallout = true
        
        let detailView = MapDetailView(frame: .zero)
        detailView.truck = truck
        annotationView.detailCalloutAccessoryView = detailView
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("Selected")
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
    }
    
}
