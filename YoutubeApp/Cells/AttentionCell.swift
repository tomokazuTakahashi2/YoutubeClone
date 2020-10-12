//
//  AttentionCell.swift
//  YoutubeApp
//
//  Created by Raphael on 2020/10/11.
//  Copyright © 2020 Raphael. All rights reserved.
//

import UIKit

class AttentionCell: UICollectionViewCell {
    
    var videoItems = [Item]()
    private let attentionId = "attentionId"
    
    lazy var attentionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //横スクロールにする
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        backgroundColor = .blue
        
        addSubview(attentionCollectionView)
        
        //オートレイアウト
        [
            attentionCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            attentionCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            attentionCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            attentionCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ].forEach{$0.isActive = true}
        
        attentionCollectionView.register(UINib(nibName: "AttentionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: attentionId)
        //横スクロールセルの両端のスペースを15空ける
        attentionCollectionView.contentInset = .init(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -コレクションビュー
extension AttentionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //横スクロールセル同士の隙間の幅
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    //レイアウト関係
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //幅はフレームの幅、高さはフレームの高さ
        let height = self.frame.height
        return .init(width: height, height: height)
    }
    //セルの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //カスタムセルを設定
        let cell = attentionCollectionView.dequeueReusableCell(withReuseIdentifier: attentionId, for: indexPath)as! AttentionCollectionViewCell
        //横スクロールセルにvideoItemsを渡す
        cell.videoItem = videoItems[indexPath.row]
        
        return cell
    }
    
    
    
}
