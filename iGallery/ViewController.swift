//
//  ViewController.swift
//
//
//  Created by Marc Zita and Daniyal Azhar 08/10/21.
//
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var images = [ImageEntity]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loaddata()
        tableView.reloadData()
    }

    func loaddata(){
        
        images = DatabaseHelper.shareInstance.fetchImage()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let row = images[indexPath.row]
        
        cell.shortDesc.text = row.shortdescription
        cell.title.text = row.title
        
        if let data = row.image {
            cell.img.image = UIImage(data: data)
        }
        else {
            cell.img.image = nil
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let row = images[indexPath.row]
            images.remove(at: indexPath.row)
            DatabaseHelper.shareInstance.deleteData(title: row.title!)
            self.tableView.reloadData()
        }
    }
}














