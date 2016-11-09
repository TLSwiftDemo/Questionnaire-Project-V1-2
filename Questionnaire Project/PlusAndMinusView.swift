//
//  PlusAndMinusView.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/11/1.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import SnapKit

class PlusAndMinusView: UIView {
    
    var plusBtn:UIButton!
    var minusBtn:UIButton!
    
    var valueLb:UILabel!
    
    var count:Int = 0

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        plusBtn = UIButton()
        plusBtn.backgroundColor = UIColor(red:255/255, green:182/255, blue:193/255, alpha:1)
        plusBtn.addTarget(self, action: #selector(plusAction(btn:)), for: .touchUpInside)
        self.addSubview(plusBtn)
        
        plusBtn.setTitle("+", for: .normal)
        plusBtn.setTitleColor(UIColor.white, for: .normal)
        plusBtn.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.width.equalTo(self.snp.height)
            make.height.equalTo(self.snp.height)
        }
        
        minusBtn = UIButton()
        minusBtn.setTitle("-", for: .normal)
        minusBtn.setTitleColor(UIColor.white, for: .normal)
        minusBtn.backgroundColor = UIColor(red:255/255, green:182/255, blue:193/255, alpha:1)

        minusBtn.addTarget(self, action: #selector(minusAction(btn:)), for: .touchUpInside)
        self.addSubview(minusBtn)
        
        minusBtn.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.width.equalTo(self.snp.height)
            make.height.equalTo(self.snp.height)
        }
        
        valueLb = UILabel()
        valueLb.textAlignment = .center
        valueLb.text = "0"
        valueLb.font = UIFont.boldSystemFont(ofSize: 20)
        self.addSubview(valueLb)
        
        valueLb.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.size.equalTo(CGSize(width: 60, height: 30))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func plusAction(btn:UIButton) -> Void {
        print("点击了plusAction")
        
        if count == 100{
          return
        }
        count = count + 1
        self.valueLb.text = "\(count)"
    }

    func minusAction(btn:UIButton) -> Void {
        print("点击了minusAction")
        if count == 0{
            return
        }
        count = count - 1
        
        self.valueLb.text = "\(count)"
    }
}
