//
//  EntryListTableViewController.swift
//  Journal-CloudKit-36
//
//  Created by Shean Bjoralt on 10/5/20.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    //MARK: - Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        EntryController.shared.fetchAllEntries { (result) in
            self.updateViews()
            self.loadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    //MARK: - Helper Methods
    
    func updateViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func loadData() {
        EntryController.shared.fetchAllEntries { (result) in
            switch result {
            case .success(let entries):
                guard let entries = entries else { return }
                EntryController.shared.entries = entries
                self.updateViews()
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return EntryController.shared.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        let entry = EntryController.shared.entries[indexPath.row]
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.timestamp.formatDate()

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? EntryViewController else { return }
            let entryToSend = EntryController.shared.entries[indexPath.row]
            destinationVC.entry = entryToSend
        }
    }
}
