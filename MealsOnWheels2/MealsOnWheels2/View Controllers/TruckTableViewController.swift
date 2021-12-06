//
//  TruckTableViewController.swift
//  MealsOnWheels2
//
//  Created by Craig Belinfante on 1/26/21.
//

import UIKit
import CoreData

class TruckTableViewController: UITableViewController {

    // Properties
    var trucks: [TruckRep] = []
    
//    lazy var fetchedResultsController: NSFetchedResultsController<Truck> = {
//        let fetchRequest: NSFetchRequest<Truck> = Truck.fetchRequest()
//
//        let moc = CoreDataStack.shared.mainContext
//        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: "name", cacheName: nil)
//        frc.delegate = self
//        try! frc.performFetch()
//        return frc
//    }()
//
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(fetchedResultsController.sections?.count ?? 0)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        //fetchedResultsController.sections?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trucks.count
        //fetchedResultsController.sections? [section].numberOfObjects ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Truck", for: indexPath) as? TruckTableViewCell else { fatalError("Error dequeing truck cell")}
        
        cell.delegate = self
        cell.truck = trucks[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}


extension TruckTableViewController: NSFetchedResultsControllerDelegate {
    //Updates
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    
    //Sections
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections((IndexSet(integer: sectionIndex)), with: .automatic)
        case .delete:
            tableView.deleteSections((IndexSet(integer: sectionIndex)), with: .automatic)
        default:
            break
        }
    }
    
    // Rows
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .move:
            guard let oldIndexPath = indexPath,
                let newIndexPath = newIndexPath else {return}
            tableView.deleteRows(at: [oldIndexPath], with: .automatic)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }
}

extension TruckTableViewController: TruckCellDelegate {
    func showTruck(truck: Truck) {
    }
}
