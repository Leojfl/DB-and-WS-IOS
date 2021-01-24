//
//  PeopleListWSViewController.swift
//  FormDBAndWS
//
//  Created by Leonardo Flores Lopez on 22/01/21.
//

import UIKit

class PeopleListWSViewController: UIViewController {
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
        Person.getPeopleWS { people in
            UIUtils.hidenDialog()
            UIUtils.hidenDialog()
            self.people = people ?? []
            self.table.reloadData("Sin usuarios")
        }
    }
    

}
extension PeopleListWSViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell", for: indexPath) as! PersonTableViewCell
        
        tableViewCell.setupUI(person: self.people[indexPath.row])
        
        
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
     
        let contextItem = UIContextualAction(style: .normal, title: "Editar") {  (contextualAction, view, boolValue) in
        
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "FormViewController") as! FormViewController
            vc.person = self.people[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        contextItem.backgroundColor = UIColor(named: "StrongBlue")
      
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        return swipeActions
    }

}
