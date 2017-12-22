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
    func loadEmployeeUpdateDetail()
    
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
    @IBOutlet weak var buttonClose: DesignButton!
    
    var empolyeeListArray :[EmployeeInfo] = []
    var sceneType : SceneType? = nil
    func loadEmployeeDetail() {
        self.empolyeeListArray = DBManager.shared.fetchEmployeeInfo()
        self.tableViewCustomerList.reloadData()
        
    }
    func loadEmployeeUpdateDetail(){
        self.empolyeeListArray = DBManager.shared.fetchEmployeeInfo()
        self.tableViewCustomerList.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localization()
        tableViewCustomerList.register(UINib(nibName: "AddEmployeeListTableViewCell", bundle: nil), forCellReuseIdentifier: "AddEmployeeListTableViewCell")
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let objEmployee = empolyeeListArray[indexPath.row]
        
        let employeeInfoDict:[String:String] = ["name":objEmployee.EmployeeName,"password":objEmployee.password,"role":objEmployee.role,"contact":objEmployee.contact,"address":objEmployee.address,"rate":objEmployee.rate,"hourly":objEmployee.hourly]
        UserDefaults.standard.set(employeeInfoDict, forKey: "employeeInfoDict")
        let result = UserDefaults.standard.value(forKey: "employeeInfoDict")
        print(result!)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.empolyeeListArray = DBManager.shared.fetchEmployeeInfo()
        self.tableViewCustomerList.reloadData()
    }

    @IBAction func actionAddEmployeeButton(_ sender: Any) {
        
        let popOverVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNewEmployeePopUpViewController") as! AddNewEmployeePopUpViewController
        popOverVc.delegate = self
        self.addChildViewController(popOverVc)
        let scene = SceneType.addEmployeeListScene
        popOverVc.sceneType = scene
        popOverVc.view.frame = self.view.frame
        self.view.addSubview(popOverVc.view)
        popOverVc.didMove(toParentViewController: self)
    }
    @IBAction func actionEditButton(_ sender: Any) {
        
        let popOverVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNewEmployeePopUpViewController") as! AddNewEmployeePopUpViewController
        self.addChildViewController(popOverVc)
        let scene = SceneType.addEmployeeScene
        popOverVc.sceneType = scene
         popOverVc.delegate = self
        popOverVc.view.frame = self.view.frame
        self.view.addSubview(popOverVc.view)
        popOverVc.didMove(toParentViewController: self)
    }
   
    @IBAction func actionCloseButton(_ sender: Any) {
        let allVC = self.navigationController?.viewControllers
        
        if  let ManagementVC = allVC![allVC!.count - 2] as? ManagementViewController {
           self.navigationController!.popToViewController(ManagementVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
         let objEmployee = empolyeeListArray[indexPath.row]
        if editingStyle == .delete {
            if DBManager.shared.deleteEmployeeInfo(withId:objEmployee.employeeId ) {
                empolyeeListArray.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
