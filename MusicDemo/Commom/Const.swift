//
//  Const.swift
//  MusicDemo
//
//  Created by Charron on 2021/11/20.
//

//喜马拉雅
let XMLYAPPKEY = "fe569acd06f5409bda13fd585858d182"
let XMLYAPPSECRET = "d30097d24ed7b52a772439f638f4640c"
let XMLYAPPREDIRECTURI = "https://www.baidu.com/"
let XMLYAPPPBUNDLEID = Bundle.main.bundleIdentifier!
let XMLYAPPNAME = "MusicDemo"
let XMLYSCHEME = "xmlyfe569acd06f5409bda13fd585858d182"

//通知名
let XMLYStartFinishedNotification = "XMLYStartFinishedNotification"


//扩展
extension Notification.Name {
    static func name(_ name: String) -> Notification.Name {
        return Notification.Name(name)
    }
}
