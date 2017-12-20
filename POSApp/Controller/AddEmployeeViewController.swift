//
//  AddEmployeeViewController
//  POSApp
//
//  Created by webwerks on 14/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit
protocol AddNewEmployeePopUpViewControllerDelegate: class {
    
    func loadEmployeeDetail()
    
}
class AddEmployeeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,AddNewEmployeePopUpViewControllerDelegate {
    
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
    var userDefaultsDictionary  : [String:String] = [:]
    var empolyeeListArray :[EmployeeInfo] = []
    
    func loadEmployeeDetail() {
       
        self.empolyeeListArray = DBManager.shared.fetchEmployeeInfo()
        self.tableViewCustomerList.reloadData()
        
    }
    
    
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
        return empolyeeListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddEmployeeListTableViewCell", for: indexPath)as! AddEmployeeListTableViewCell
    

        let objEmployee = empolyeeListArray[indexPath.row]
    
        cell.labelName.text = objEmployee.EmployeeName
        cell.labelPassword.text = objEmployee.password
        cell.labelRole.text = objEmployee.role
        cell.labelContact.text = objEmployee.contact
        cell.labelAddress.text = objEmployee.address
        cell.labelRate.text = objEmployee.rate
        cell.labelHourly.text = objEmployee.hourly
       
       
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func viewWillAppear(_ animated: Bool) {
        self.empolyeeListArray = DBManager.shared.fetchEmployeeInfo()
        self.tableViewCustomerList.reloadData()
    }

    @IBAction func actionAddEmployeeButton(_ sender: Any) {
        let popOverVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNewEmployeePopUpViewController") as! AddNewEmployeePopUpViewController
        popOverVc.delegate = self
        self.addChildViewController(popOverVc)
        popOverVc.view.frame = self.view.frame
        self.view.addSubview(popOverVc.view)
        popOverVc.didMove(toParentViewController: self)
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
