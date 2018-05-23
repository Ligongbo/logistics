//
//  MyCollectionTableViewCell.swift
//  选择图片
//
//  Created by 王岩 on 2017/9/27.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import Photos
import SKPhotoBrowser
typealias SelectPhotoBlock = (_ photoArray:Array<PhotoBrowserShowModel>)->Void
class MyCollectionTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource ,TZImagePickerControllerDelegate,SKPhotoBrowserDelegate{
    var isCanEdit = true
    
    @IBOutlet weak var titleNameLabel: UILabel!
    var model = PhotoBrowserShowModel()
    var photoArray:Array<PhotoBrowserShowModel> = [PhotoBrowserShowModel]()
    let kwidth = UIScreen.main.bounds.width
    var kheight = (UIScreen.main.bounds.width - 2)/3
    
    @IBOutlet weak var collectionHeightConstraint: NSLayoutConstraint!
    var selectedAssets:NSMutableArray = NSMutableArray()
    var imagePicker:TZImagePickerController!
    var selectPhotoBlock:SelectPhotoBlock!
    var delegate:UIViewController!
    var photos:Array<SKPhoto> = [SKPhoto]()
    @IBOutlet var collectionView: UICollectionView!
    var total = 9
    override func awakeFromNib() {
        
        super.awakeFromNib()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:(kwidth)/3,height:(kwidth)/3)
        //列间距,行间距,偏移
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        //        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        //注册一个cell
        
        collectionView.register(UINib.init(nibName: "MyCell", bundle: nil), forCellWithReuseIdentifier: "MyCell")
        
        self.collectionHeightConstraint.constant = (kwidth)/3
        layoutIfNeeded()
    }

    func update(delegate:UIViewController,selectPhotoBlock:@escaping SelectPhotoBlock,photoArray:Array<PhotoBrowserShowModel>){

        
        self.selectPhotoBlock = selectPhotoBlock
        self.photoArray = photoArray
        var showRowCount:Int = 0
        if isCanEdit{
            if self.photoArray.count == total{
                showRowCount = self.photoArray.count / Int(3)
            }else{
                showRowCount = self.photoArray.count / Int(3) + 1
            }
            
        }else{
            showRowCount = Int(ceil(Double(self.photoArray.count) / Double(3)))
        }
        self.collectionHeightConstraint.constant = CGFloat(showRowCount) * self.kheight
        
        
        self.delegate = delegate
        initImagePick(urlCount: 0)
       
        collectionView.reloadData()
    }
    
    func initImagePick(urlCount:Int){
        imagePicker = TZImagePickerController.init(maxImagesCount: total, delegate: self,urlCount:urlCount)
        // 在内部是否显示拍照按钮
        imagePicker?.allowTakePicture = true
        // 对照片排序，按修改时间升序，默认是YES。如果设置为NO,最新的照片会显示在最前面，内部的拍照按钮会排在第一个
        imagePicker?.sortAscendingByModificationDate = false
        //        // 单选模式
        //        imagePicker?.maxImagesCount = 1
        //        //在单选模式下，照片列表页中，显示选择按钮,默认为NO
        //        imagePicker?.showSelectBtn = false
        //        imagePicker?.allowCrop = true
        //        // 需要圆形裁剪框
        //        imagePicker?.needCircleCrop = false
        //        // 设置竖屏下的裁剪尺寸
        //
        //        let left = 30
        //
        //        let widthHeight = Int(imagePicker.view.tz_width) - 2 * left
        //        let top = (Int(imagePicker.view.tz_height) - widthHeight) / 2
        //        imagePicker?.cropRect = CGRect(x: CGFloat(left), y: CGFloat(top), width: CGFloat(widthHeight), height: CGFloat(widthHeight))
        
    }
    
    //分区个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //        return 2
        return 1
    }
    
    //每个区的item个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isCanEdit{
            if photoArray.count == total{
                return photoArray.count
            }
            return photoArray.count + 1
        }else{
            return photoArray.count
        }
        
        
    }
    
    //自定义cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCell
        if isCanEdit && indexPath.row == photoArray.count && photoArray.count != total{
            cell.testImage.image = UIImage.init(named: "AlbumAddBtn")
            cell.deleteBtn.isHidden = true
        }else{
            
            let model = photoArray[indexPath.row]
            
            if model.photoType == .image{
                cell.testImage.image = photoArray[indexPath.row].image
            }else{
                
                cell.testImage.sd_setImage(with: URL.init(string: model.imageUrl))
            }
            
            if !isCanEdit{
                cell.deleteBtn.isHidden = true
            }else{
                cell.deleteBtn.isHidden = false
            }

        }

        
        
        
        cell.deleteBlock = { () in
            self.photoArray.remove(at: indexPath.row)
//            self.collectionView.reloadData()
            var showRowCount = 0
            if self.photoArray.count > 0 {
                if self.photoArray.count == self.total{
                    showRowCount = self.photoArray.count / 3
                    self.collectionHeightConstraint.constant = CGFloat(showRowCount) * self.kheight
                }else{
                    showRowCount = self.photoArray.count / 3 + 1
                    self.collectionHeightConstraint.constant = CGFloat(showRowCount) * self.kheight
                }
            }else{
                self.collectionHeightConstraint.constant = self.kheight
            }
            self.selectPhotoBlock(self.photoArray)
            

            
        }
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == photoArray.count{
            
           
            var index = 0
            var temMut:NSMutableArray = NSMutableArray()
            for i in 0..<photoArray.count{
                if photoArray[i].photoType == .image{
                    temMut.add(photoArray[i].asset)
                    
                }else{
                    index = index + 1
//                    temMut.add(PHAsset.initialize())
                }
                
            }
            initImagePick(urlCount:index)
//            imagePicker?.selectedAssets = selectedAssets
            imagePicker?.selectedAssets = temMut
            
            imagePicker.maxImagesCount = total
            imagePicker.urlCount = index
            
            imagePicker?.didFinishPickingPhotosHandle = {
                (photos,assets,isSelectOriginalPhoto) in
                if photos != nil && (photos?.count)! > 0{
                    var temPhotoArray = [PhotoBrowserShowModel]()
                    for i in 0..<self.photoArray.count{
                        if self.photoArray[i].photoType == .url{
                            temPhotoArray.append(self.photoArray[i])
                        }
                    }
                    self.photoArray = temPhotoArray
                    var showRowCount = 0
                    if photos!.count > 0 {
                        for i in 0..<photos!.count{
                            let model = PhotoBrowserShowModel()
                            model.image = photos![i]
                            model.asset = assets![i] as? PHAsset
                            model.photoType = .image
                            self.photoArray.append(model)
                        }
                        if self.photoArray.count == self.total {
                            showRowCount = self.photoArray.count / 3
                        }else{
                            showRowCount = self.photoArray.count / 3 + 1
                        }
                        
                        self.collectionHeightConstraint.constant = CGFloat(showRowCount) * self.kheight
                    }else{
                        self.collectionHeightConstraint.constant = self.kheight
                    }
                    self.selectPhotoBlock(self.photoArray)
                    
                }else{
                    print("没有选择任何图片")
                }
            }
            
            (delegate!).present(imagePicker!, animated: true, completion: nil)
        }else{
            photos.removeAll()
            for index in 0..<photoArray.count {
                
                var photo:SKPhoto!
     
                if photoArray[index].photoType == .image{
                    photo = SKPhoto.photoWithImage(photoArray[index].image!)
                }else{
                    photo = SKPhoto.photoWithImageURL(photoArray[index].imageUrl)
                }
                
                
                
                photos.append(photo)
            }
            
            let browser = SKPhotoBrowser(photos: photos)
            browser.delegate = self
            
            browser.initializePageIndex(indexPath.row)
            browser.delegate = self as SKPhotoBrowserDelegate
            SKPhotoBrowserOptions.displayAction = false
//            SKPhotoBrowserOptions.actionButtonTitles = ["保存"]
            SKPhotoBrowserOptions.displayBackAndForwardButton = false
            (delegate!).present(browser, animated: true, completion: nil)
        }
    }
    func didDismissActionSheetWithButtonIndex(_ buttonIndex: Int, photoIndex: Int) {
//        photos.remove(at: photoIndex)
        
    }
    class func loadCell(_ tableView:UITableView)-> MyCollectionTableViewCell{
        let cellId:String = "MyCollectionTableViewCellId"
        var cell:MyCollectionTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? MyCollectionTableViewCell
        
        if (cell == nil || !cell!.isKind(of: MyCollectionTableViewCell.self)){
            cell = MyCollectionTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
}
