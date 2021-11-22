//
//  MusicTableViewCell.swift
//  MusicDemo
//
//  Created by Charron on 2021/11/22.
//

import UIKit

private let margin:CGFloat = 15

class MusicTableViewCell: UITableViewCell {

    var model: XMTrack? {
        didSet {
            musicNameLbl.text = model?.trackTitle
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customView()
    }
    //MARK: 自定义View
    private func customView() {
        contentView.addSubview(musicNameLbl)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        musicNameLbl.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(15*RATIO_WIDHT750)
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
    private lazy var musicNameLbl: UILabel = {
        let musicNameLbl = UILabel(frame: .zero)
        musicNameLbl.text = ""
        musicNameLbl.textAlignment = .left
        musicNameLbl.textColor = .black
        musicNameLbl.font = .systemFont(ofSize: 18)
        return musicNameLbl
    }()
}
