//
//  MapDetailView.swift
//  MealsOnWheels2
//
//  Created by Craig Belinfante on 2/9/21.
//

import Foundation
import UIKit

class MapDetailView: UIView {
    
    var truck: TruckRep? {
        didSet {
           updateViews()
        }
    }
    
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var addressTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = false
        textField.textColor = .label
        textField.textAlignment = .center
        textField.textContentType = .addressCity
        return textField
    }()
    
    //change to image
    /*
    private var truckImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    */
    
    private var infoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        button.setTitle("View Truck", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(infoButtonSelected), for: .touchUpInside)
        return button
    }()
    
    private var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        //change state .selected and optional heart.fill
        button.setImage(UIImage(systemName: "heart"), for: .normal)
       // button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(favoriteButtonSelected), for: .touchUpInside)
        return button
    }()

    @objc func infoButtonSelected() {
        print("Showing Truck Information 📙")
    }
    
    @objc func favoriteButtonSelected() {
        print("Favorited a truck ❤️")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //add in address to stack view later
        let stackView = UIStackView(arrangedSubviews: [nameLabel, infoButton, favoriteButton])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
        ])

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func updateViews() {
        guard let truck = truck else { return }

        nameLabel.text = truck.name
        
    //  convert lat and long
    //  addressTextField.text = truck.address
    //  truckImageView.image = truck.imageOfTruck
        
    }
    
}
