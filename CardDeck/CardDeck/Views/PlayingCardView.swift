//
//  PlayingCardView.swift
//  CardDeck
//
//  Created by Кирилл Смирнов on 17/04/2019.
//  Copyright © 2019 asu. All rights reserved.
//

import UIKit

class PlayingCardView: UIView {
    
    //MARK: - Stored properies
    
    var rank: Int = 5
    var suit: String = "♥️"
    var isFaceUp: Bool = true
    
    //MARK: - Computed properies
    
    private var cornerString: NSAttributedString {
        return self.centeredAttributedString(self.rankString + "\n" + self.suit, fontSize: self.cornerFontSize)
    }
    
    //MARK: - UI
    
    private lazy var upperLeftCornerLabel: UILabel = self.createCornerLabel()
    private lazy var lowerLeftCornerLabel: UILabel = self.createCornerLabel()
    
    //MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.configureCornerLabel(self.upperLeftCornerLabel)
        
        self.upperLeftCornerLabel.frame.origin =
            self.bounds.origin.offsetBy(dx: self.cornerOffset,
                                        dy: self.cornerOffset)
        
        //FIXME: - Сделать нижий лейбл
        
    }
    
    override func draw(_ rect: CGRect) {
        
        let roundedRect = UIBezierPath(roundedRect: self.bounds,
                                       cornerRadius: self.cornerRadius)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
    
    }
    
    //MARK: - Private
    
    private func createCornerLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        self.addSubview(label)
        return label
    }
    
    private func configureCornerLabel(_ label: UILabel) {
        label.attributedText = self.cornerString
        label.frame.size = CGSize.zero
        label.sizeToFit()
        label.isHidden = !self.isFaceUp
    }
    
    private func centeredAttributedString(_ string: String,
                                          fontSize: CGFloat) -> NSAttributedString {
        
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        
        let pargraphStyle = NSMutableParagraphStyle()
        pargraphStyle.alignment = .center
        
        return NSAttributedString(string: string,
                                  attributes: [.paragraphStyle: pargraphStyle, .font: font])
    }
    
}

//MARK: - Constants

extension PlayingCardView {
    
    private struct SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.785
    }
    
    private var cornerRadius: CGFloat {
        return self.bounds.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    
    private var cornerOffset: CGFloat {
        return self.cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    
    private var cornerFontSize: CGFloat {
        return self.bounds.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    
    private var rankString: String {
        switch self.rank {
        case 1: return "A"
        case 2...10: return String(self.rank)
        case 11: return "J"
        case 12: return "Q"
        case 13: return "K"
        default: return "?"
        }
    }
}


//MARK: - Helpers

extension CGRect {
    
    func zoom(by zoomFactor: CGFloat) -> CGRect {
        let zoomedWidth = size.width * zoomFactor
        let zoomedHeight = size.height * zoomFactor
        let originX = origin.x + (size.width - zoomedWidth) / 2
        let originY = origin.y + (size.height - zoomedHeight) / 2
        return CGRect(origin: CGPoint(x: originX,y: originY) , size: CGSize(width: zoomedWidth, height: zoomedHeight))
    }
    
    var leftHalf: CGRect {
        let width = size.width / 2
        return CGRect(origin: origin, size: CGSize(width: width, height: size.height))
    }
    
    var rightHalf: CGRect {
        let width = size.width / 2
        return CGRect(origin: CGPoint(x: origin.x + width, y: origin.y), size: CGSize(width: width, height: size.height))
    }
    
    func inset(by size: CGSize) -> CGRect {
        return self.insetBy(dx: size.width, dy: size.height)
    }
    
    func sized(to size: CGSize) -> CGRect {
        return CGRect(origin: self.origin, size: size)
    }
    
}

extension CGPoint {
    
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + dx, y: self.y + dy)
    }
    
}
