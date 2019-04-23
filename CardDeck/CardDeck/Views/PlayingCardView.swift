//
//  PlayingCardView.swift
//  CardDeck
//
//  Created by Кирилл Смирнов on 17/04/2019.
//  Copyright © 2019 asu. All rights reserved.
//

import UIKit

@IBDesignable
class PlayingCardView: UIView {
    
    //MARK: - Stored properies
    
    @IBInspectable
    var rank: Int = 9 {
        didSet {
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var suit: String = "♥️" {
        didSet {
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var isFaceUp: Bool = true {
        didSet {
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }
    
    //MARK: - Computed properies
    
    private var cornerString: NSAttributedString {
        return self.centeredAttributedString(self.rankString + "\n" + self.suit, fontSize: self.cornerFontSize)
    }
    
    //MARK: - UI
    
    private lazy var upperLeftCornerLabel: UILabel = self.createCornerLabel()
    private lazy var lowerRightCornerLabel: UILabel = self.createCornerLabel()
    
    //MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Configure Left Top Label
        self.configureCornerLabel(self.upperLeftCornerLabel)
        
        self.upperLeftCornerLabel.frame.origin =
            self.bounds.origin.offsetBy(dx: self.cornerOffset,
                                        dy: self.cornerOffset)
        
        //Configure Right Bottom Label
        self.configureCornerLabel(self.lowerRightCornerLabel)
        
        self.lowerRightCornerLabel.transform = CGAffineTransform.identity
            .translatedBy(x: self.lowerRightCornerLabel.frame.size.width, y: self.lowerRightCornerLabel.frame.size.height)
            .rotated(by: CGFloat.pi)
        
        self.lowerRightCornerLabel.frame.origin = CGPoint(x: self.bounds.maxX, y: self.bounds.maxY)
            .offsetBy(dx: -self.cornerOffset, dy: -self.cornerOffset)
            .offsetBy(dx: -self.lowerRightCornerLabel.frame.width, dy: -self.lowerRightCornerLabel.frame.height)
        
    }
    
    override func draw(_ rect: CGRect) {
        
        let roundedRect = UIBezierPath(roundedRect: self.bounds,
                                       cornerRadius: self.cornerRadius)
        roundedRect.addClip()
        
        if self.isFaceUp {
            
            UIColor.white.setFill()
            roundedRect.fill()
            
            if let faceCardImage = UIImage(named: self.rankString + self.suit, in: Bundle(for: self.classForCoder), compatibleWith: self.traitCollection) {
                faceCardImage.draw(in: self.bounds.zoom(by: SizeRatio.faceCardImageSizeToBoundsSize))
            } else {
                self.drawPips()
            }
        } else {
            
            UIColor.red.setFill()
            roundedRect.fill()
            
            if let cardBackImage = UIImage(named: "cardback", in: Bundle(for: self.classForCoder), compatibleWith: self.traitCollection) {
                cardBackImage.draw(in: self.bounds)
            }
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.setNeedsDisplay()
        self.setNeedsLayout()
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
    
    private func drawPips() {
        
        let pipsPerRowForRank = [[0], [1], [1,1], [1,1,1], [2,2], [2,1,2], [2,2,2], [2,1,2,2], [2,2,2,2], [2,2,1,2,2], [2,2,2,2,2]]
        
        if pipsPerRowForRank.indices.contains(self.rank) {
            let pipsPerRow = pipsPerRowForRank[self.rank]
            
            let offsetSize = CGSize(width: self.cornerOffset, height: self.cornerOffset)
            let stringSize = CGSize(width: self.cornerString.size().width, height: self.cornerString.size().height / 2)
            
            //Фрейм для pips
            var pipRect = self.bounds.inset(by: offsetSize).inset(by: stringSize)
            
            let pipString = self.createPipString(pipsPerRowForRank, thatFits: pipRect)
            let pipRowSpacing = pipRect.size.height / CGFloat(pipsPerRow.count)
            pipRect.size.height = pipString.size().height
            pipRect.origin.y += (pipRowSpacing - pipRect.size.height) / 2
            
            for pipCount in pipsPerRow {
                switch pipCount {
                case 1:
                    pipString.draw(in: pipRect)
                case 2:
                    pipString.draw(in: pipRect.leftHalf)
                    pipString.draw(in: pipRect.rightHalf)
                default:
                    break
                }
                pipRect.origin.y += pipRowSpacing
            }
            
        }
    }
    
    func createPipString(_ pipsPerRowForRank: [[Int]], thatFits pipRect: CGRect) -> NSAttributedString {
        
        let maxVerticalPipCount = CGFloat(pipsPerRowForRank.reduce(0) { max($1.count, $0)})
        let maxHorizontalPipCount = CGFloat(pipsPerRowForRank.reduce(0) { max($1.max() ?? 0, $0)})
        
        let verticalPipRowSpacing = pipRect.size.height / maxVerticalPipCount
        
        let attemptedPipString = self.centeredAttributedString(self.suit, fontSize: verticalPipRowSpacing)
        
        let probablyOkayPipStringFontSize = verticalPipRowSpacing / (attemptedPipString.size().height / verticalPipRowSpacing)
        let probablyOkayPipString = self.centeredAttributedString(self.suit, fontSize: probablyOkayPipStringFontSize)
        
        if probablyOkayPipString.size().width > pipRect.size.width / maxHorizontalPipCount {
            return self.centeredAttributedString(self.suit, fontSize: probablyOkayPipStringFontSize /
                (probablyOkayPipString.size().width / (pipRect.size.width / maxHorizontalPipCount)))
        } else {
            return probablyOkayPipString
        }
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
