//
//  AnswerCell.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/11/2.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import SnapKit

class AnswerCell: UITableViewCell {
    
    var questionLb:UILabel!
    var answerLb:UILabel!
    
    var answerValue:UILabel!
    
    var answerTimeLb:UILabel!
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        questionLb = UILabel()
        questionLb.numberOfLines = 0
        questionLb.lineBreakMode = .byCharWrapping
        self.addSubview(questionLb)
        questionLb.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(10)
            make.right.equalTo(-25)
            make.height.equalTo(50)
        }
        
        answerTimeLb = UILabel()
        answerTimeLb.textAlignment = .right
        self.addSubview(answerTimeLb)
        
        answerTimeLb.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.bottom.equalTo(-10)
            make.width.equalTo(200)
        }
        
        answerLb = UILabel()
        answerLb.numberOfLines = 0
        answerLb.lineBreakMode = .byCharWrapping
        self.addSubview(answerLb)
        
        answerLb.snp.makeConstraints { (make) in
            make.left.equalTo(questionLb.snp.left)
            make.top.equalTo(questionLb.snp.bottom).offset(20)
            make.right.equalTo(-10)
            make.bottom.equalTo(answerTimeLb.snp.top).offset(-10)
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
    
    func setDataSource(question:Question) -> Void {
        
        questionLb.text = question.question
        answerLb.text = question.chioceLabel
        
        answerTimeLb.text = question.answerTime
        
    }

}
