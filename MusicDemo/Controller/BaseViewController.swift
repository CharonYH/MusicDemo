//
//  BaseViewController.swift
//  MusicDemo
//
//  Created by Charron on 2021/11/21.
//

import UIKit

class BaseViewController: UIViewController {

    //返回
    @objc func popViewController() {
//        XMSDKPlayer.shared().stopTrackPlay()
        navigationController?.popViewController(animated: true)
    }
    func configBackBarItem() {
        let backBarItem = UIBarButtonItem(image: .init(named: "navigation_back_black"), style: .done, target: self, action: #selector(popViewController))
        navigationItem.leftBarButtonItem = backBarItem
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

}
