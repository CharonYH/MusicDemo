//
//  AlbumViewController.swift
//  MusicDemo
//
//  Created by Charron on 2021/11/21.
//

import UIKit

class AlbumViewController: BaseViewController {

    private lazy var albumsDatas: [XMAlbum?]? = []
    var tagName: String?
    var categoryID: Int? {
        didSet {
            var albumsParamas: [String:Any] = [:]
            albumsParamas["category_id"] = categoryID
            albumsParamas["tag_name"] = tagName
            //1-热门推荐，2-最新，3-最多播放
            albumsParamas["calc_dimension"] = 1
            albumsParamas["page"] = 1
            albumsParamas["count"] = 20
            //是否为付费内容
            albumsParamas["contains_paid"] = false
            //MARK: 获取专辑列表
            XMReqMgr.sharedInstance().requestXMData(.XMReqType_AlbumsList, params: albumsParamas) { result, error in
                if let result = result as? [String:Any],
                   let albums = result["albums"] as? [Any]{
                    for value in albums {
                        if let value = value as? [String:Any] {
                            let model = XMAlbum(dictionary: value)
                            self.albumsDatas?.append(model)
                        }
                    }
                }
                self.tableView.reloadData()
                MBProgressHUD.hide(for: self.view, animated: true)
//                print("albumsDatasCount = \(self.albumsDatas?.count)")
                print("result = \(result)")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //配置返回按钮
        configBackBarItem()
        initUI()
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    //MARK: 初始化UI
    private func initUI() {
        view.addSubview(tableView)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: Status_And_Navigation_Height(), left: 0, bottom: 0, right: 0))
        }
    }
    //MARK: 懒记载
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.rowHeight = 44
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: "\(AlbumTableViewCell.self)")
        
        if #available(iOS 11, *) {
            tableView.estimatedRowHeight = 0
            tableView.estimatedSectionHeaderHeight = 0
            tableView.estimatedSectionFooterHeight = 0
            tableView.contentInsetAdjustmentBehavior = .never
        }else {
            automaticallyAdjustsScrollViewInsets = false
        }
        return tableView
    }()
}
extension AlbumViewController: UITableViewDelegate, UITableViewDataSource {

    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //MARK: 获取专辑下的声音列表
        var voiceParams: [String:Int] = [:]
        voiceParams["album_id"] = albumsDatas?[indexPath.section]?.albumId
        XMReqMgr.sharedInstance().requestXMData(.XMReqType_AlbumsBrowse, params: voiceParams) { result, error in
            var datas: [XMHotTrack?]? = []
            if let result = result as? [String:Any],
               let tracks = result["tracks"] as? [Any] {
                for value in tracks {
                    if let value = value as? [String:Any] {
                        let model = XMTrack(dictionary: value)
                        print("tagName = \(model?.playUrl32)")
                    }
                }
                print("album_title = \(result["album_title"])")
            }
            print("声音列表结果:\(result)")
        }
    }
    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return albumsDatas?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(AlbumTableViewCell.self)", for: indexPath) as! AlbumTableViewCell
        cell.model = albumsDatas?[indexPath.section]
        cell.selectionStyle = .none
        cell.backgroundColor = .secondarySystemBackground
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        return cell
    }
}
