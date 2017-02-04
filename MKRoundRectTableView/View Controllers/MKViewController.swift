//
//  MKViewController.swift
//  MKRoundRectTableView
//
//  Created by Muhammad Khaliq ur Rehman on 04/02/2017.
//  Copyright © 2017 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class MKViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    // MARK: - Class Properties
    @IBOutlet weak var tableView: MKTableView!
    
    
    //MARK: - View Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Helper Methods
    
    private func setupViewController() {
        self.title = "MK Table View"
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    func showAlert(withTitle title: String, andMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(actionOk)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    //MARK: - UITableView Methods
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        if section == 0 {
            rows = 1
        } else if section == 1 {
            rows = 2
        } else {
            rows = 3
        }
        
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MKTableViewCell
        
        cell.cellLabel.text = "Section: \(indexPath.section + 1) Row: \(indexPath.row + 1)"
        
        return cell;
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.tableView.tableView(tableView, willDisplay: cell, forRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let headerTitle = "Section Header \(section + 1)"
        return headerTitle
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderTitle = self.tableView(tableView, titleForHeaderInSection: section)
        return self.tableView.tableView(tableView, viewForHeaderInSection: section, withTitle: sectionHeaderTitle!)
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let sectionTitle = "Section Footer \(section + 1)"
        return sectionTitle
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionFooterTitle = self.tableView(tableView, titleForFooterInSection: section)
        return self.tableView.tableView(tableView, viewForFooterInSection: section, withTitle: sectionFooterTitle!)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.tableView.tableView(tableView, heightForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.tableView.tableView(tableView, heightForFooterInSection: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = "Information Alert"
        let message = "You Select Row \(indexPath.row + 1) in Section \(indexPath.section + 1)."
        
        self.showAlert(withTitle: title, andMessage: message)
    }


}

