//
//  BaseTabBarController.swift
//  YoutubeApp
//
//  Created by Raphael on 2020/10/10.
//  Copyright © 2020 Raphael. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    enum ControllerName: Int {
        case home, search, channel, inbox, library
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        //タブバーのアイコンを設定
        viewControllers?.enumerated().forEach({(index, viewController) in
            
            if let name = ControllerName.init(rawValue: index){
                switch name {
                case .home:
                    setTabBarInfo(viewController, selectedImageName: "home(色)", unselectedImageName: "home", title: "ホーム")
                case .search:
                    setTabBarInfo(viewController, selectedImageName: "コンパス(色)", unselectedImageName: "コンパス", title: "検索")
                case .channel:
                    setTabBarInfo(viewController, selectedImageName: "登録チャンネル(色)", unselectedImageName: "登録チャンネル", title: "登録チャンネル")
                case .inbox:
                    setTabBarInfo(viewController, selectedImageName: "ベル(色)", unselectedImageName: "ベル", title: "通知")
                case .library:
                    setTabBarInfo(viewController, selectedImageName: "設定(色)", unselectedImageName: "設定", title: "設定")
                    
                }
            }
        })
    }
    
    //UIImage-Extension.swiftでアイコンのサイズをリサイズ「〜?.resize(size: .init(width: 25, height: 25))」で反映させる
    //「〜?.withRenderingMode(.alwaysOriginal)」で画像本来の色を使う
    private func setTabBarInfo(_ viewController: UIViewController, selectedImageName: String, unselectedImageName: String, title: String) {
        //選択した場合のアイコン
        viewController.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.resize(size: .init(width: 25, height: 25))?.withRenderingMode(.alwaysOriginal)
        //選択していない場合のアイコン
        viewController.tabBarItem.image = UIImage(named: unselectedImageName)?.resize(size: .init(width: 25, height: 25))?.withRenderingMode(.alwaysOriginal)
        //アイコン下に名前を表示
        viewController.tabBarItem.title = title
        //※文字の色はAppDelegateで設定
    }
}
