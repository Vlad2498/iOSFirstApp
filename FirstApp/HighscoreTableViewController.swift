//
//  HighscoreTableViewController.swift
//  FirstApp
//
//  Created by vlad on 16/11/2020.
//

import UIKit
import CoreData


class HighscoreTableViewController: UITableViewController {
    
    var fetchedResultsController : NSFetchedResultsController<GameResult>!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "highschoreIdentifier")
        setupFetchedResultsController()
        
    }
    
    private func setupFetchedResultsController() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = DatabaseManager.shared.managedObjectContext
        
        let request = NSFetchRequest<GameResult>(entityName: "GameResult")
        let dateSort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [dateSort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize fetchedResultsController")
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0	
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "highschoreIdentifier", for: indexPath)

        let gameResult = fetchedResultsController.object(at: indexPath)
        
//        cell.textLabel?.text = "Out of  \(gameResult.numberOfQuestions) questions you answered \(gameResult.rightAnswers) right."
        cell.textLabel?.text = "\(gameResult.date)"

        return cell
    }
    

  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


// MARK: - Table view Delegate
extension HighscoreTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("Selected this row: \(indexPath.row)")
    }
}
