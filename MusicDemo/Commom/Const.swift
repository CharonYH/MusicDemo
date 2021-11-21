//
//  Const.swift
//  MusicDemo
//
//  Created by Charron on 2021/11/20.
//

//喜马拉雅
let XMLYAPPKEY = "53dfb8147549b960b87f9094f8d9ca84"
let XMLYAPPSECRET = "98bc7836b0ee70117ea8a6d8c870eeca"
let XMLYAPPREDIRECTURI = "https://www.baidu.com/"
let XMLYAPPPBUNDLEID = "com.music.demo.MusicDemo"
let XMLYAPPNAME = "MusicDemo"
let XMLYSCHEME = "xmly53dfb8147549b960b87f9094f8d9ca84"

//通知名
let XMLYStartFinishedNotification = "XMLYStartFinishedNotification"


//扩展
extension Notification.Name {
    static func name(_ name: String) -> Notification.Name {
        return Notification.Name(name)
    }
}
