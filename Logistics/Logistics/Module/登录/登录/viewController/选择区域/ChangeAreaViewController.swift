//
//  ChangeAreaViewController.swift
//  MiddleSchool2
//
//  Created by 李琪 on 2017/12/21.
//  Copyright © 2017年 王岩. All rights reserved.
//

import UIKit

class ChangeAreaViewController: BaseViewController {

    @IBOutlet var currentAreaNameLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    
    
    var dataController:ChangeAreaDataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "请选择区域"
        initData()
        initUI()
        getAddressList()
    }


}


extension ChangeAreaViewController {
    // MARK: - Private Function
    //    addressList
    fileprivate func initData() {
        dataController = ChangeAreaDataController(delegate: self)
    }
    
    fileprivate func initUI(){
        self.view.backgroundColor = UIColor.white
        initCurrentAreaNameLabel()
        initCollectionView()
    }
    
    fileprivate func initCurrentAreaNameLabel(){
        currentAreaNameLabel.text = areaName
        currentAreaNameLabel.setCornerWithRadius(4)
        
    }
    
    fileprivate func initCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.setCornerWithRadius(12)
        collectionView.allowsMultipleSelection = false
        collectionView.bounces = false
        collectionView.register(UINib(nibName: "ChangeAreaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ChangeAreaCollectionViewCellID")
    }
    
    fileprivate func getAddressList() {
        dataController.getAreaList { (isSucceed, info) in
            self.collectionView.reloadData()
        }
    }
    
}

//MARK:- CollectionView
extension ChangeAreaViewController : UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    //item个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataController.areaList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChangeAreaCollectionViewCellID", for: indexPath) as! ChangeAreaCollectionViewCell
        cell.update(model: dataController.areaList[indexPath.row])
        return cell
    }
    
    //定义每个UICollectionViewCell 的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (ScreenWidth - 48) / 2, height: 30)
    }
    
    //每个item之间的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for item in dataController.areaList{
            item.isSelected = false
        }
        let selectedItem = dataController.areaList[indexPath.row]
        selectedItem.isSelected = true
        currentAreaNameLabel.text = selectedItem.name
        collectionView.reloadData()
        
        
        dismissBlock?(selectedItem)
        self.back()
    }
}

