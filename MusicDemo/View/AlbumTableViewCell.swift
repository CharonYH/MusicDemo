//
//  AlbumTableViewCell.swift
//  MusicDemo
//
//  Created by Charron on 2021/11/21.
//

import UIKit

private let margin:CGFloat = 15
class AlbumTableViewCell: UITableViewCell {

    var model: XMAlbum? {
        didSet{
            imgView.sd_setImage(with: .init(string: model?.coverUrlSmall ?? "" ), completed: nil)
            albumNameLbl.text = model?.albumTitle
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customView()
    }
    //MARK: 自定义View
    private func customView() {
        contentView.addSubview(imgView)
        contentView.addSubview(albumNameLbl)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(15*RATIO_WIDHT750)
            make.size.equalTo(CGSize(width: 32, height: 32))
        }
        albumNameLbl.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(imgView.snp.right).offset(15*RATIO_WIDHT750)
            make.right.equalTo(0)
            make.height.equalTo(21)
        }
    }
    override var frame: CGRect {
        set {
            var Frame = newValue
            Frame.origin.x += margin
            Frame.size.width -= 2 * margin
            super.frame = Frame
        }
        get { return super.frame}
    }
    //MARK: 懒加载
    private lazy var imgView: UIImageView = {
        let  imgView = UIImageView(frame: .zero)
        return imgView
    }()
    private lazy var albumNameLbl: UILabel = {
        let albumNameLbl = UILabel(frame: .zero)
        albumNameLbl.text = ""
        albumNameLbl.textAlignment = .left
        albumNameLbl.textColor = .black
        albumNameLbl.font = .systemFont(ofSize: 18)
        return albumNameLbl
    }()
}
