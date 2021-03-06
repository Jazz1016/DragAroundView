//
//  ViewController.swift
//  DragAroundView
//
//  Created by James Lea on 3/18/22.
//

import UIKit

class ViewController: UIViewController {
    
    private let myView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        view.backgroundColor = .link
        view.isUserInteractionEnabled = true
        view.layer.zPosition = 5
        
        return view
    }()
    
    private let topView: UIView = {
        let topView  = UIView(frame: CGRect(x: 0.5, y: 0.5, width: 1000, height: 1000))
        topView.backgroundColor = .gray
        
        return topView
    }()
    
    private var isDragging: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(myView)
        view.addSubview(topView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topView.anchor(top: self.view.topAnchor, bottom: nil, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, paddingTop: 8, paddingBottom: 8, paddingLeft: 8, paddingRight: 8, width: nil, height: 500)
        myView.center = view.center
    }
    var oldX: CGFloat = 0
    var oldY: CGFloat = 0
}

extension ViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: myView)
        if myView.bounds.contains(location) {
            isDragging = true
        }
        
        oldX = location.x
        oldY = location.y
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDragging, let touch = touches.first else { return }
        
        let location = touch.location(in: view)
        myView.frame.origin.x = location.x - (myView.frame.size.width/2)
        myView.frame.origin.y = location.y - (myView.frame.size.height/2)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDragging = false
    }
}
