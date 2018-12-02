//
//  SwipeView.swift
//  Login
//
//  Created by RCMACEXT-44 on 12/2/18.
//  Copyright © 2018 James Clark. All rights reserved.
//

import Foundation
import UIKit

class SwipeView:UIView{
    
    var panGR: UIPanGestureRecognizer?
    var tapGR: UITapGestureRecognizer?
    var panGT: CGPoint = .zero
    
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
        panGT = gestureRecognizer.translation(in: self)
        
        switch gestureRecognizer.state {
        case .began:
            print("begin")
            
        case .changed:
            print("changed")
            
        case .ended:
           print("ended")
            
        default:
            print("default")
        }
    }
    
    @objc func tapRecognized(_ gestureRecognizer: UITapGestureRecognizer){
        print("tapped")
    }
    
    
}
