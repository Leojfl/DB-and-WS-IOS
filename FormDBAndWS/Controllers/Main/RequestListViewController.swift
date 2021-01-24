//
//  RequestListViewController.swift
//  FormDBAndWS
//
//  Created by Leonardo Flores Lopez on 22/01/21.
//

import UIKit

class RequestListViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    private var requests: [RequestDB] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getRequests()
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
        table.register(UINib(nibName: "RequestTableViewCell", bundle: nil), forCellReuseIdentifier: "RequestTableViewCell")
    }
    
    private func getRequests(){
        UIUtils.showDialog(controller: self)
        RequestDB.getRequestsDB { requests in
            UIUtils.hidenDialog()
            self.requests = requests ?? []
            self.table.reloadData("Sin personas en la base de datos")
        }
    }
    

}
extension RequestListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.requests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "RequestTableViewCell", for: indexPath) as! RequestTableViewCell
        
        tableViewCell.setupUI(request: self.requests[indexPath.row])
        
        
        return tableViewCell
    }

}
