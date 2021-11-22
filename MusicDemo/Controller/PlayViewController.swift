//
//  PlayViewController.swift
//  MusicDemo
//
//  Created by Charron on 2021/11/22.
//

import UIKit


class PlayViewController: BaseViewController {

    //远程播放URL
    var xmTrack: XMTrack? {
        didSet {
            title = xmTrack?.trackTitle
            if let coverUrl = xmTrack?.coverUrlLarge {
                musicImgView.sd_setImage(with: .init(string: coverUrl), completed: nil)
            }
            if let downloadUrl = xmTrack?.downloadUrl{
                
                XMSDKPlayer.shared().play(withDecryptedUrl: .init(string: downloadUrl))
            }
        }
    }
    deinit {
//        print("PlayViewController-denit")
        XMSDKPlayer.shared().stopTrackPlay()
    }
    @objc private func btnClick(sender: UIButton) {
        if XMSDKPlayer.shared().isPlaying() {
            playBtn.setImage(.init(named: "play"), for: .normal)
            XMSDKPlayer.shared().pauseTrackPlay()
        }else if XMSDKPlayer.shared().isPaused() {
            playBtn.setImage(.init(named: "pause"), for: .normal)
            XMSDKPlayer.shared().resumeTrackPlay()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = RGBColorHex(s: 0xf2f1f7)
        XMSDKPlayer.shared().trackPlayDelegate = self
        initUI()
        configBackBarItem()
    }
    //MARK: initUI
    private func initUI() {
        view.addSubview(musicImgView)
        view.addSubview(playBtn)
    }
    //MARK: 适配View
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        musicImgView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.size.equalTo(CGSize(width: 240, height: 240))
        }
        playBtn.snp.makeConstraints { make in
            make.bottom.equalTo(-TabBar_And_Bottom_Safe_Height())
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 128, height: 128))
        }
        let path = UIBezierPath(roundedRect: musicImgView.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 120, height: 120))
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.frame = musicImgView.bounds
        musicImgView.layer.mask = layer
//        print("frame = \(musicImgView.frame)")
    }
    //MARK: 懒加载
    private lazy var progressSlider: UISlider = {
        let progressSlider = UISlider(frame: .zero)
        return progressSlider
    }()
    private lazy var musicImgView: UIImageView = {
        let backGroundImgView = UIImageView(frame: .zero)
        backGroundImgView.isUserInteractionEnabled = true
        backGroundImgView.image?.withRenderingMode(.alwaysOriginal)
        return backGroundImgView
    }()
    private lazy var playBtn: UIButton = {
        let playBtn = UIButton(frame: .zero)
        playBtn.setImage(.init(named: "pause"), for: .normal)
        playBtn.setTitleColor(.black, for: .normal)
        playBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return playBtn
    }()
}
extension PlayViewController: XMTrackPlayerDelegate {
    func xmTrackPlayNotifyCacheProcess(_ percent: CGFloat) {
        print("percent = \(percent)")
    }
    func xmTrackPlayNotifyProcess(_ percent: CGFloat, currentSecond: UInt) {
        print("percent = \(percent),currentSecond = \(currentSecond)")
    }
    func xmTrackPlayerDidStart() {
        print("xmTrackPlayerDidStart")
    }
}
