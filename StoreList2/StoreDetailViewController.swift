//
//  StoreDetailViewController.swift
//  StoreList2
//
//  Created by Andjela Rakic on 10/15/21.
//

import UIKit
import MapKit

class StoreDetailViewController: UIViewController {
    
    private lazy var storeNameLabel: UILabel = {
        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private var map = MKMapView()
    
    
    private var logoImageView = UIImageView(frame: CGRect())
    private var storePhoneNumber = UILabel()
    
    
    private var store: Store
    
    
    init?(store: Store) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.map.delegate = self
        setupViews()
        
        self.logoImageView.isHidden = true
        self.heighConstraint.isActive = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 2) {
            self.changeHeight()
            }
        }
    }
    
    private var heighConstraint = NSLayoutConstraint()
    
    private func setupViews() {
        navigationController?.navigationBar.backgroundColor = .white
        view.backgroundColor = .white
        
        heighConstraint = logoImageView.heightAnchor.constraint(equalToConstant: 0)

        
        ImageCacheManager.getImage(from: store.storeLogoURL) { image in
            if let image = image {
                DispatchQueue.main.async { [weak self] in
                    self?.logoImageView.image = image
                }
                
            }
            
        }
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleAspectFill
        storePhoneNumber.text = store.phone
        storeNameLabel.text = store.name

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(storeNameLabel)
        stackView.addArrangedSubview(storePhoneNumber)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            logoImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            
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
