//
//  QuestionCell.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/11/1.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import SnapKit

class QuestionCell: UITableViewCell {
    var checkIv:UIImageView!
    var contentlb:UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        checkIv = UIImageView()
        self.addSubview(checkIv)
        
        checkIv.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalTo(self.snp.centerY)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        contentlb = UILabel()
        self.addSubview(contentlb)
        
        contentlb.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right)
        }
    }
    


func setDataSource(dict:[String:AnyObject]) -> Void {
    ///{
    //        "label": "not at all",
    //        "value":
    
    if let label = dict["label"]{
      contentlb.text = label as? String
    }
    
    
    
}

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
