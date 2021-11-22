//
//  MusicListViewController.swift
//  MusicDemo
//
//  Created by Charron on 2021/11/22.
//

import UIKit

class MusicListViewController: BaseViewController {
    //专辑下的声音列表
    private var tracksDatas: [XMTrack?]? = []
    var albumID: Int? {
        didSet {
            //MARK: 获取专辑下的声音列表
            var voiceParams: [String:Int] = [:]
            voiceParams["album_id"] = albumID
            XMReqMgr.sharedInstance().requestXMData(.XMReqType_AlbumsBrowse, params: voiceParams) { result, error in
                if let result = result as? [String:Any],
                   let tracks = result["tracks"] as? [Any] {
                    for value in tracks {
                        if let value = value as? [String:Any] {
                            let model = XMTrack(dictionary: value)
                            self.tracksDatas?.append(model)
                            print("trackTitle = \(model?.trackTitle)")
                            print("coverUrlLarge = \(model?.coverUrlLarge)")
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configBackBarItem()
        initUI()
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
    //MARK: 适配View

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
        
        tableView.register(MusicTableViewCell.self, forCellReuseIdentifier: "\(MusicTableViewCell.self)")
        
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
extension MusicListViewController: UITableViewDelegate, UITableViewDataSource,SDKDownloadMgrDelegate {
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var paramas: [String:Any] = [:]
        paramas["track_id"] = tracksDatas?[indexPath.section]?.trackId
        XMReqMgr.sharedInstance().requestXMData(withPath: "tracks/get_single", params: paramas) { result, error in
            print("单个声音信息:\(result)")
        }
        let playVC = PlayViewController()
        playVC.xmTrack = tracksDatas?[indexPath.section]
        navigationController?.pushViewController(playVC, animated: true)
    }
    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return tracksDatas?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MusicTableViewCell.self)", for: indexPath) as! MusicTableViewCell
        cell.model = tracksDatas?[indexPath.section]
        cell.selectionStyle = .none
        cell.backgroundColor = RGBColorHex(s: 0xf2f1f7)
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}
