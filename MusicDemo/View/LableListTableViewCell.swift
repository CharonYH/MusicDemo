//
//  LableListTableViewCell.swift
//  MusicDemo
//
//  Created by Charron on 2021/11/21.
//

import UIKit

private let margin: CGFloat = 15
class LableListTableViewCell: UITableViewCell {

 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        get { return super.frame}
    }
}
