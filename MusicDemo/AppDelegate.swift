//
//  AppDelegate.swift
//  MusicDemo
//
//  Created by Charron on 2021/11/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let vc = ViewController()
        let nav = UINavigationController(rootViewController: vc)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        //注册喜马拉雅
//        XMReqMgr.sharedInstance().registerXMReqInfo(withKey: XMLYAPPKEY, appSecret: XMLYAPPSECRET)
//        XMReqMgr.sharedInstance().delegate = self
        return true
    }
    //程序终止的时候调用
    func applicationWillTerminate(_ application: UIApplication) {
        YHLog(message: "applicationWillTerminate")
        XMReqMgr.sharedInstance().close()
    }
}


//extension AppDelegate: XMReqDelegate {
//    //初始化失败
//    func didXMInitReqOK(_ result: Bool) {
//        NotificationCenter.default.post(name: .name(XMLYStartFinishedNotification), object: nil)
//        print("初始化成功")
//    }
//    //初始化成功
//    func didXMInitReqFail(_ respModel: XMErrorModel!) {
//        print("初始化失败:\(String(describing: respModel.error_code)),\(String(describing: respModel.error_desc))")
//    }
//}
