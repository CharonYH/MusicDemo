//
//  ViewController.swift
//  MusicDemo
//
//  Created by Charron on 2021/11/20.
//

import UIKit


class ViewController: UIViewController {

    private var categoryDatas: [XMCategory?]? = []

    //MARK: getXMLYCategory(XMLY初始化成功后获取XMLY的分类)
    private func getXMLYCategory() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        DispatchQueue.global().async {
            XMReqMgr.sharedInstance().registerXMReqInfo(withKey: XMLYAPPKEY, appSecret: XMLYAPPSECRET)
            DispatchQueue.global().async {
                XMReqMgr.sharedInstance().requestXMData(.XMReqType_CategoriesList, params: nil) { result, error in
                    if let result = result as? [Any] {
                        for value in result {
                            if let value = value as? [String:Any] {
                                let model = XMCategory(dictionary: value)
                                self.categoryDatas?.append(model)
                                self.tableView.reloadData()
                                MBProgressHUD.hide(for: self.view, animated: true)
                            }
                        }
    //                    YHLog(message: "categoryDatasCount = \(String(describing: self.categoryDatas?.count))")
                    }
    //                YHLog(message: "result = \(String(describing: result))")
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "音乐分类"
        //设置代理
        XMReqMgr.sharedInstance().delegate = self
        //初始化UI
        initUI()
        //获取专辑列表
        getXMLYCategory()
    }
    //MARK: initUI
    private func initUI() {
        navigationItem.backBarButtonItem?.tintColor = .black
        navigationController?.navigationItem.backBarButtonItem?.tintColor = .black
        view.addSubview(tableView)
        layoutSubViews()
    }
    //MARK: 适配View
    private func layoutSubViews() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: Status_And_Navigation_Height(), left: 0, bottom: 0, right: 0))
        }
    }

    //MARK: 懒加载
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.rowHeight = 100
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "\(CategoryTableViewCell.self)")
        
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
extension ViewController: XMReqDelegate {
    //初始化成功
    func didXMInitReqOK(_ result: Bool) {
        print("初始化成功")
    }
    //初始化失败
    func didXMInitReqFail(_ respModel: XMErrorModel!) {
        print("初始化失败:\(String(describing: respModel.error_code)),\(String(describing: respModel.error_desc))")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let musicDetailVC = MusicDetailViewController()
        musicDetailVC.title = categoryDatas?[indexPath.section]?.categoryName
        musicDetailVC.categoryID = categoryDatas?[indexPath.section]?.categoryId
        navigationController?.pushViewController(musicDetailVC, animated: true)
    }
    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryDatas?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CategoryTableViewCell.self)", for: indexPath) as! CategoryTableViewCell
        cell.model = categoryDatas?[indexPath.section]
        cell.selectionStyle = .none
        cell.backgroundColor = RGBColorHex(s: 0xf2f1f7)
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        return cell
    }
}
