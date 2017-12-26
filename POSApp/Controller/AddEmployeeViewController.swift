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
class AddEmployeeViewController: UIViewController, AddNewEmployeePopUpViewControllerDelegate {
    
    
    //MARK:- Variable declaration

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
    
    
    //MARK:- View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localization()
        tableViewCustomerList.register(UINib(nibName: "AddEmployeeListTableViewCell", bundle: nil), forCellReuseIdentifier: "AddEmployeeListTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.empolyeeListArray = DBManager.shared.fetchEmployeeInfo()
        self.tableViewCustomerList.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Helper methods

    func loadEmployeeDetail() {
        self.empolyeeListArray = DBManager.shared.fetchEmployeeInfo()
        self.tableViewCustomerList.reloadData()
        
    }
    func loadEmployeeUpdateDetail(){
        self.empolyeeListArray = DBManager.shared.fetchEmployeeInfo()
        self.tableViewCustomerList.reloadData()
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
        self.tableViewCustomerList.estimatedRowHeight = 100
        self.tableViewCustomerList.rowHeight = UITableViewAutomaticDimension
    }

    //MARK:- Button events

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
}

//MARK:- Tableview datasource

extension AddEmployeeViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return empolyeeListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddEmployeeListTableViewCell", for: indexPath)as! AddEmployeeListTableViewCell
        

        let objEmployee = empolyeeListArray[indexPath.row]
        if objEmployee != nil{
            cell.labelName.text = objEmployee.EmployeeName
            cell.labelPassword.text = objEmployee.password
            cell.labelRole.text = objEmployee.role
            cell.labelContact.text = objEmployee.contact
            cell.labelAddress.text = objEmployee.address
            cell.labelRate.text = objEmployee.rate
            cell.labelHourly.text = objEmployee.hourly
        }
        else
        {
            showDefaultAlertViewWith(alertTitle: "Error", alertMessage: "something went wrong", okTitle: "ok", currentViewController: self)
        }
        
        
        return cell
    }
    
}

//MARK:- Tableview delegate

extension AddEmployeeViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let objEmployee = empolyeeListArray[indexPath.row]
        if editingStyle == .delete {
            if DBManager.shared.deleteEmployeeInfo(withId:objEmployee.employeeId ) {
                empolyeeListArray.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let objEmployee = empolyeeListArray[indexPath.row]
        
        let employeeInfoDict:[String:String] = ["name":objEmployee.EmployeeName,"password":objEmployee.password,"role":objEmployee.role,"contact":objEmployee.contact,"address":objEmployee.address,"rate":objEmployee.rate,"hourly":objEmployee.hourly]
        UserDefaults.standard.set(employeeInfoDict, forKey: "employeeInfoDict")
        let result = UserDefaults.standard.value(forKey: "employeeInfoDict")
        print(result!)
        
    }
}

