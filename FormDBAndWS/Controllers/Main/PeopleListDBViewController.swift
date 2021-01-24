//
//  PeopleListDBViewController.swift
//  FormDBAndWS
//
//  Created by Leonardo Flores Lopez on 22/01/21.
//

import UIKit

class PeopleListDBViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    private var people: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getPeople()
    }
    
    private func setupUI() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        setupTable()
    }
    
    private func setupTable() {
        table.dataSource = self
        table.delegate = self
        table.tableFooterView = UIView()
        table.reloadData("Sin personas registradas")
        table.register(UINib(nibName: "PersonTableViewCell", bundle: nil), forCellReuseIdentifier: "PersonTableViewCell")
    }
    
    private func getPeople(){
        UIUtils.showDialog(controller: self)
        Person.getPeopleDB { people in
            UIUtils.hidenDialog()
            self.people = people ?? []
            self.table.reloadData("Sin personas en la base de datos")
        }
    }
    

}
extension PeopleListDBViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell", for: indexPath) as! PersonTableViewCell
        
        tableViewCell.setupUI(person: self.people[indexPath.row])
        
        
        return tableViewCell
    }

}
