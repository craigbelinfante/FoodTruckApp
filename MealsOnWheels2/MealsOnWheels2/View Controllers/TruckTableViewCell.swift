//
//  TruckTableViewCell.swift
//  MealsOnWheels2
//
//  Created by Craig Belinfante on 1/26/21.
//

import UIKit

protocol TruckCellDelegate: class {
    func showTruck(truck: Truck)
}

class TruckTableViewCell: UITableViewCell {
    
    var truck: TruckRep? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: TruckCellDelegate?
    
    private func updateViews() {
        guard let truck = truck else {return}
        self.textLabel?.text = truck.name
    }
}

