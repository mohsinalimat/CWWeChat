//
//  CWVoiceMessageCell.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/15.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import YYImage

private let redtip_width: CGFloat = 6

class CWVoiceMessageCell: CWChatMessageCell {
    
    /// voice图标的imageView
    lazy var voiceImageView:UIImageView = {
        let voiceImageView = UIImageView()
        voiceImageView.size = CGSize(width: 12.5, height: 17)
        voiceImageView.contentMode = .scaleAspectFit
        return voiceImageView
    }()
    
    ///手势操作
    fileprivate(set) lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(bubbleTapped(_:)))
        return tapGestureRecognizer
    }()
    
    lazy var redTipImageView:UIImageView = {
        let redTipImageView = UIImageView()
        redTipImageView.clipsToBounds = true
        redTipImageView.backgroundColor = UIColor.redTipColor()
        redTipImageView.layer.cornerRadius = redtip_width/2
        return redTipImageView
    }()
    
    lazy var voiceLengthLable: UILabel = {
        let voiceLengthLable = UILabel()
        return voiceLengthLable
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func setup() {
        super.setup()
        addGeneralView()
        self.messageContentView.addSubview(self.backgroundImageView)
        self.messageContentView.addSubview(self.voiceImageView)
        
        self.contentView.addSubview(self.redTipImageView)
        self.contentView.addSubview(self.voiceLengthLable)
    }
    
    override func updateMessage(_ messageModel: CWChatMessageModel) {
        super.updateMessage(messageModel)
    
        // 消息实体
        let body = messageModel.message.messageBody as! CWVoiceMessageBody
        let size = messageModel.messageFrame.contentSize
        
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        
        //如果是自己发送，在右边
        if messageModel.message.direction == .send {
            setUpVoicePlayIndicatorImageView(true)
            voiceImageView.snp.makeConstraints { (make) in
                make.top.equalTo(12)
                make.right.equalTo(-20)
            }
            
            redTipImageView.snp.makeConstraints({ (make) in
                make.size.equalTo(CGSize(width: redtip_width, height: redtip_width))
                make.top.equalTo(5)
                make.right.equalTo(backgroundImageView.snp.left).offset(-5)
            })
            
        } else {
            setUpVoicePlayIndicatorImageView(false)
            voiceImageView.snp.makeConstraints { (make) in
                make.top.equalTo(12)
                make.left.equalTo(20)
            }
            
            redTipImageView.snp.makeConstraints({ (make) in
                make.size.equalTo(CGSize(width: redtip_width, height: redtip_width))
                make.top.equalTo(5)
                make.left.equalTo(backgroundImageView.snp.right).offset(5)
            })
        }
    }
    
    func setUpVoicePlayIndicatorImageView(_ send: Bool) {
        
        let images: [UIImage]
        if send {
            images = [UIImage(named: "SenderVoiceNodePlaying001")!,
                      UIImage(named: "SenderVoiceNodePlaying002")!,
                      UIImage(named: "SenderVoiceNodePlaying003")!]
            voiceImageView.image = images.last
        } else {
            images = [UIImage(named: "ReceiverVoiceNodePlaying001")!,
                      UIImage(named: "ReceiverVoiceNodePlaying002")!,
                      UIImage(named: "ReceiverVoiceNodePlaying003")!]
            voiceImageView.image = images.last
        }
        voiceImageView.animationDuration = 1
        voiceImageView.animationImages = images
    }
    
    /// 结束动画
    func startAnimating() {
        voiceImageView.startAnimating()
    }
    
    /// 开始动画
    func stopAnimating() {
        voiceImageView.stopAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
