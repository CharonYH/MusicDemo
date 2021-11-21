//
//  MusicDetailViewController.swift
//  MusicDemo
//
//  Created by Charron on 2021/11/20.
//

import UIKit
class MusicDetailViewController: BaseViewController {
    
    private var xMTagDatas: [XMTag?]? = []
    var categoryID: Int? {
        didSet {
            print("categoryID = \(String(describing: categoryID))")
            var params: [String: Any] = [:]
            params["category_id"] = categoryID
            //0:专辑标签
            params["type"] = 0
            //MARK: 获取专辑标签
            XMReqMgr.sharedInstance().requestXMData(.XMReqType_TagsList, params: params) { result, error in
                if let result = result as? [Any]{
                    for value in result {
                        if let value = value as? [String:Any] {
                            let model = XMTag(dictionary: value)
                            self.xMTagDatas?.append(model)
//                            print("model = \(String(describing: model?.tagName))")
                        }
                    }
                }
                
                self.tableView.reloadData()
//                print("result = \(String(describing: result))")
            }
        }
    }
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //配置返回按钮
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
        
        tableView.register(LableListTableViewCell.self, forCellReuseIdentifier: "\(LableListTableViewCell.self)")
        
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

extension MusicDetailViewController: UITableViewDelegate, UITableViewDataSource {

    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumVC = AlbumViewController()
        albumVC.title = xMTagDatas?[indexPath.section]?.tagName
        albumVC.tagName = xMTagDatas?[indexPath.section]?.tagName
        albumVC.categoryID = categoryID
        navigationController?.pushViewController(albumVC, animated: true)
    }
    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return xMTagDatas?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(LableListTableViewCell.self)", for: indexPath) as! LableListTableViewCell
        cell.textLabel?.text = xMTagDatas?[indexPath.section]?.tagName
        cell.selectionStyle = .none
        cell.backgroundColor = .secondarySystemBackground
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        return cell
    }
}
