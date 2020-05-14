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
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell
        cell?.lbl.text = patients[indexPath.row].name
        
        return(cell!)
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        //cell.textLabel?.text = patients[indexPath.row].name
        
        //return(cell)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        let patient = patients[indexPath.row]
        
        if(editingStyle == .delete){
            
            if let id = patient.id  {
                
                ImageIOService.deleteImage(forKey: id)
            }
            patients.remove(at: indexPath.row)
            
            FirebaseService.shared.delete(patient)
            
            self.tableView.reloadData()
        }
    }

    

    @IBAction func hideView(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        
        let patient = Patient(name: "Carlos", age: 50, gender: "M")
        //FirebaseService.shared.create(for: patient)
        
        FirebaseService.shared.read(returning: Patient.self) { (pts) in
            patients = pts
            self.tableView.reloadData()
            
        }        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
            self.navigationController?.isNavigationBarHidden = false
            FirebaseService.shared.read(returning: Patient.self) { (pts) in
                patients = pts
                self.tableView.reloadData()
                
            }
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController
        
        vc!.patient = patients[indexPath.row]
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
    }
}
