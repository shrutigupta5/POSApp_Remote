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
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPassword: UILabel!
    @IBOutlet weak var labelRole: UILabel!
    @IBOutlet weak var labelContact: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelRate: UILabel!
    @IBOutlet weak var labelHours: UILabel!
    @IBOutlet weak var buttonAddEmployee: DesignButton!
    @IBOutlet weak var buttonEdit: DesignButton!
    @IBOutlet weak var buttonDelete: DesignButton!
    @IBOutlet weak var buttonClose: DesignButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localization()
        tableViewCustomerList.register(UINib(nibName: "AddEmployeeListTableViewCell", bundle: nil), forCellReuseIdentifier: "AddEmployeeListTableViewCell");
    }
    func localization()
    {
       self.labelName.text = Localizator.instance.localize(string: "Key_customerName")
        self.labelPassword.text = Localizator.instance.localize(string: "Key_customerPassword")
        self.labelRole.text = Localizator.instance.localize(string: "Key_role")
        self.labelContact.text = Localizator.instance.localize(string: "Key_customerContact")
         self.labelAddress.text = Localizator.instance.localize(string: "Key_customerAddress")
         self.labelRate.text = Localizator.instance.localize(string: "Key_customerRate")
         self.labelHours.text = Localizator.instance.localize(string: "Key_customerHourly")
        self.buttonAddEmployee.setTitle(Localizator.instance.localize(string: "Key_AddEmployee"), for: .normal)
        self.buttonEdit.setTitle(Localizator.instance.localize(string: "Key_buttonEdit"), for: .normal)
        self.buttonDelete.setTitle(Localizator.instance.localize(string: "Key_buttonDelete"), for: .normal)
        self.buttonClose.setTitle(Localizator.instance.localize(string: "Key_buttonClose"), for: .normal)
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

    @IBAction func actionAddEmployeeButton(_ sender: Any) {
    }
    @IBAction func actionEditButton(_ sender: Any) {
    }
    @IBAction func actionDeleteButton(_ sender: Any) {
    }
    @IBAction func actionCloseButton(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
