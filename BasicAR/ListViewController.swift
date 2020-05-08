//
//  ListViewController.swift
//  BasicAR
//
//  Created by heber on 09/04/20.
//  Copyright © 2020 heber. All rights reserved.
//

import UIKit

//var patients = ["Maria", "Jorge","Doroteia","Amelie"]
var patients = [Patient]()
class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = patients[indexPath.row].name
        
        return(cell)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        if(editingStyle == .delete){
            patients.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }

    

    @IBAction func hideView(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
        let patient = Patient(name: "Carlos", age: 50, gender: "M")
        //FirebaseService.shared.create(for: patient)
        
        FirebaseService.shared.read(returning: Patient.self) { (pts) in
            patients = pts
            self.tableView.reloadData()
            
        }        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
            
            FirebaseService.shared.read(returning: Patient.self) { (pts) in
                patients = pts
                self.tableView.reloadData()
                
            }
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
