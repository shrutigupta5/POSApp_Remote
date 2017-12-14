//
//  AddEmployeeViewController
//  POSApp
//
//  Created by webwerks on 14/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

class AddEmployeeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableViewCustomerList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        tableViewCustomerList.register(UINib(nibName: "AddEmployeeListTableViewCell", bundle: nil), forCellReuseIdentifier: "AddEmployeeListTableViewCell");
    }
    func setupView(){
        self.tableViewCustomerList.delegate = self
        self.tableViewCustomerList.dataSource = self
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddEmployeeListTableViewCell", for: indexPath)as! AddEmployeeListTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
