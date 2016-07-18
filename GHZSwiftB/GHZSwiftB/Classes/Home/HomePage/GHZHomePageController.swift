//
//  GHZHomePageController.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/17.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit

class GHZHomePageController: GHZBaseViewController
{
    
    private var flag:Int =  -1
    private var headerView :GHZHomeHeaderView!
    private lazy var collectionView:UICollectionView =
        {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 0
            flowLayout.itemSize = CGSize(width: 100, height: 100)
            let collectionView = UICollectionView(frame: GHZScreenBounds, collectionViewLayout: flowLayout)
            return collectionView
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollection()
    }
    func setCollection() {
        view.addSubview(self.collectionView)
        collectionView.register(UINib.init(nibName: "GHZHomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GHZHomeCollectionViewCell")
    }
}

extension GHZHomePageController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GHZHomeCollectionViewCell", for: indexPath)
        cell.backgroundColor = UIColor.cyan()
        return cell
    }
    
}

