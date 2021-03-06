//
//  SwipeView.swift
//  Login
//
//  Created by RCMACEXT-44 on 12/2/18.
//  Copyright © 2018 James Clark. All rights reserved.
//

import Foundation
import UIKit

protocol CardSwipeDelegate: class{
    func dislikeSwipe(_ cardView:UIView);
    func likeSwipe(_ cardView:UIView);
}

class SwipeView:UIView{
    
    var panGR: UIPanGestureRecognizer?
    var tapGR: UITapGestureRecognizer?
    var panGT: CGPoint = .zero
    weak var delegate: CardSwipeDelegate?
    
    var username: String?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGR()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGR()
    }
    
    func setupGR(){
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(SwipeView.panRecognized(_:)))
        self.panGR = panGR
        addGestureRecognizer(panGR)
        // Tap Gesture Recognizer
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(SwipeView.tapRecognized(_:)))
        self.tapGR = tapGR
        addGestureRecognizer(tapGR)
        print("panGR tapGR")
    }
    
    deinit{
        if let panGR = panGR {
            removeGestureRecognizer(panGR)
        }
        if let tapGR = tapGR {
            removeGestureRecognizer(tapGR)
        }
    }
    
    @objc func panRecognized(_ gestureRecognizer: UIPanGestureRecognizer){
        //        panGT = gestureRecognizer.translation(in: self)
        let leashPoint = CGPoint(x: self.superview!.center.x, y: self.superview!.center.y * 0.67)
        
        switch gestureRecognizer.state {
        case .began:
            print("begin")
            
        case .changed:
            
            let translation = gestureRecognizer.translation(in: self)
            
            self.center = CGPoint(x: self.center.x + translation.x, y: self.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self)
            
        case .ended:
            //           print(self.center)
            if( self.center.y > 400) {
                print("bottom")
                self.center = leashPoint
//                self.superview!.sendSubview(toBack: self)
                
            }else if( self.center.x < 20){
                print("Swiped left")
                self.center = leashPoint
                delegate?.dislikeSwipe(self)
//                self.superview!.sendSubview(toBack: self)
                
            }else if( self.center.x > 300){
                print("Swiped right")
                self.center = leashPoint
                delegate?.likeSwipe(self)
//                self.superview!.sendSubview(toBack: self)
                
            }
            else{
                self.center = leashPoint
                print("reset")
            }
            
            
        default:
            print("default")
        }
    }
    
    @objc func tapRecognized(_ gestureRecognizer: UITapGestureRecognizer){
        print("tapped")
    }
    
    
}
