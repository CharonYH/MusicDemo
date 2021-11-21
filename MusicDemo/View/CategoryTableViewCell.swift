//
//  CategoryTableViewCell.swift
//  MusicDemo
//
//  Created by Charron on 2021/11/20.
//

import UIKit

private let margin:CGFloat = 15

class CategoryTableViewCell: UITableViewCell {

    //分类模型model
    var model: XMCategory? {
        didSet {
            if let coverUrlLarge = model?.coverUrlLarge {
                imgView.sd_setImage(with: .init(string: coverUrlLarge ), completed: nil)
            }
            categoryNameLbl.text = model?.categoryName
        }
    }


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customView()
    }
    //MARK: 适配View
    private func customView() {
        contentView.addSubview(imgView)
        contentView.addSubview(categoryNameLbl)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(15*RATIO_WIDHT750)
            make.size.equalTo(CGSize(width: 64, height: 64))
        }
        categoryNameLbl.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(imgView.snp.right).offset(15*RATIO_WIDHT750)
            make.right.equalTo(0)
            make.height.equalTo(21)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var frame: CGRect {
        set {
            var Frame = newValue
            Frame.origin.x += margin
            Frame.size.width -= 2 * margin
            super.frame = Frame
        }
        get { super.frame }
    }

    //MARK: 懒加载
    private lazy var imgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        return imgView
    }()
    private lazy var categoryNameLbl: UILabel = {
        let categoryNameLbl = UILabel(frame: .zero)
        categoryNameLbl.text = ""
        categoryNameLbl.textAlignment = .left
        categoryNameLbl.textColor = .black
        categoryNameLbl.font = .systemFont(ofSize: 18)
        return categoryNameLbl
    }()
}
