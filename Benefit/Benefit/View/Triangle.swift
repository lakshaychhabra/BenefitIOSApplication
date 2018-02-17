//
//  Triangle.swift
//  Benefit
//
//  Created by Delta One on 04/02/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class Triangle: UIView
{
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect)
    {
        let size = self.bounds.size
        let p1 = CGPoint(x: self.bounds.origin.x, y: size.height)
        let p2 = CGPoint(x: p1.x + size.width, y: p1.y)
        let p3 = CGPoint(x: p1.x + size.width, y: self.bounds.origin.y)
        let path = UIBezierPath()
        path.move(to: p1)
        path.addLine(to: p2)
        path.addLine(to: p3)
        path.close()
        UIColor.white.setFill()
        path.fill()
    }

}
