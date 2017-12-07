//
//  AddFloorTableViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by Shruti Gupta on 06/12/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class AddFloorTableViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var collectionViewAddFloor: UICollectionView!
    @IBOutlet weak var collectionViewAddTable: UICollectionView!
    var floorArray = ["Hall","Balcony"]
    var tableArray = ["table1","table2","table3","table4","table5","table6","table7"]
    var index = 1
    
    override func viewDidLoad() {
    super.viewDidLoad()
self.collectionViewAddFloor.register(UINib(nibName:"AddFloorCollectionViewCell",bundle:nil), forCellWithReuseIdentifier: "AddFloorCollectionViewCell")
self.collectionViewAddTable.register(UINib(nibName:"AddTableCollectionViewCell",bundle:nil), forCellWithReuseIdentifier: "AddTableCollectionViewCell")
        // Do any additional setup after loading the view.
        setupView()
        
      
    }
    func setupView()
    {
        self.collectionViewAddFloor.delegate = self
        self.collectionViewAddFloor.dataSource = self
        self.collectionViewAddTable.delegate = self
        self.collectionViewAddTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if (collectionView == collectionViewAddFloor){
           return 1
        }
        else{
            return 1
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == collectionViewAddFloor)
        {
           return floorArray.count
        }
        else{
            return tableArray.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == collectionViewAddFloor){
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddFloorCollectionViewCell", for: indexPath)as! AddFloorCollectionViewCell
        cell.labelFloorName.text = floorArray[indexPath.row]
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddTableCollectionViewCell", for: indexPath)as! AddTableCollectionViewCell
            let image = tableArray[indexPath.row]
            cell.imageViewTable.image = UIImage(named:image)
            return cell
        }
       
    }
    
    @IBAction func actionAddFloorButton(_ sender: Any) {
        let floorString = "Floor" +  "\(index)"
        index += 1
        floorArray.append(floorString)
        print("printed floor name \(floorString)")
        collectionViewAddFloor.reloadData()
    }
    
    @IBAction func actionRemoveFloorButton(_ sender: Any) {
        if(floorArray.count > 2){
            floorArray.removeLast()
            collectionViewAddFloor.reloadData()
        }
        else {
        showDefaultAlertViewWith(alertTitle: "Never Deleted", alertMessage: "you delete only floor", okTitle: "ok", currentViewController: self)
        }
    }
    
    @IBAction func actionAddTableButton(_ sender: Any) {
        
    }
    
    @IBAction func actionRemoveTableButton(_ sender: Any) {
    }
}
