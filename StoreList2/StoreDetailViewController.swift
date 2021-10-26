//
//  StoreDetailViewController.swift
//  StoreList2
//
//  Created by Andjela Rakic on 10/15/21.
//

import UIKit
import MapKit
import CoreLocation

class StoreDetailViewController: UIViewController, CLLocationManagerDelegate {
    
    
    private var locationManager: CLLocationManager?
    
    private lazy var storeNameLabel: UILabel = {
        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
   private var mapView = MKMapView()
    
           let leftMargin:CGFloat = 10
           let topMargin:CGFloat = 60
           let mapWidth:CGFloat = 20
           let mapHeight:CGFloat = 300
                     
    
    private var logoImageView = UIImageView(frame: CGRect())
    private var storePhoneNumber = UIButton()
    
    
    private var store: Store
    
    private var heighConstraint = NSLayoutConstraint()
    
    init(store: Store) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        view.backgroundColor = .systemPink
        
        setupViews()
        
        loadImage()
        updateViewWithData()
        updateMapWithData()
        
        storePhoneNumber .addTarget(self, action: #selector(createPhoneCall), for: .touchUpInside)
        
        }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                }
            }
        }
    }
    
    @objc
    func createPhoneCall() {
        if let phoneCallURL = URL(string: "tel://\(store.phone)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    
    fileprivate func updateViewWithData() {
        storePhoneNumber.setTitle(store.phone, for: .normal)
        storeNameLabel.text = store.name
    }
    
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
       
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
       }
    
    
    
    fileprivate func extractedFunc() {
        ImageCacheManager.getImage(from: store.storeLogoURL) { image in
            if let image = image {
                DispatchQueue.main.async { [weak self] in
                    self?.logoImageView.image = image
                }
                
            }
            
        }
    }
    
    fileprivate func loadImage() {
        extractedFunc()
    }
    
    private func updateMapWithData() {
        let latitude: CLLocationDegrees = Double(store.latitude) ?? 0
        let longitude: CLLocationDegrees = Double(store.longitude) ?? 0
        
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let location = MKCoordinateRegion(center: center, span: span)
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = store.name
        mapView.addAnnotation(annotation)
        mapView.setRegion(location, animated: true)
    }
    
    private func setupViews() {
        navigationController?.navigationBar.backgroundColor = .white
        view.backgroundColor = .white
                
        storePhoneNumber.setTitleColor(.blue, for: .normal)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleAspectFill
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleAspectFill
        

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(mapView)
        stackView.addArrangedSubview(storeNameLabel)
        stackView.addArrangedSubview(storePhoneNumber)
        
        view.addSubview(stackView)
      
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            mapView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 200)
            
        ])
    }
    
    func changeHeight() {
            self.logoImageView.isHidden = false
            self.heighConstraint.isActive = true
            self.heighConstraint.constant = 100
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }
}

extension StoreDetailViewController: MKMapViewDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {

        print(mapView)
    }
    
}


