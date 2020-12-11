//
//  DownLoadTableViewCell.swift
//  Start
//
//  Created by pactera on 2020/12/4.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit
import RxSwift

class DownLoadTableViewCell: UITableViewCell {
    
    var bag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    
    lazy var buttonBar  = {() -> UIButton in
        let btn = UIButton()
        btn.backgroundColor = UIColor(red: 30/255, green: 94/255, blue: 219/255, alpha: 1.0);
        btn.setTitleColor(UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0), for: .normal)
        btn.titleLabel?.font = wfont13
        btn.setTitleColor(UIColor.gray, for: .highlighted)
        btn.layer.borderWidth = 1
        btn.layer.borderColor =  UIColor.init(red: 105/255, green: 232/255, blue: 253/255, alpha: 1.0).cgColor
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        return btn
    }()
    
    lazy var titleLabel = {()->UILabel in
        let lab = UILabel()
        lab.textAlignment = .center
        lab.font = wfont13
        return lab
    }()
    
    lazy var progress = {()->UILabel in
        let lab = UILabel()
        lab.textAlignment = .center
        lab.backgroundColor = .clear
        //lab.textColor = UIColor(red: 255/255, green: 210/255, blue: 98/255, alpha: 1.0)
        lab.font = wfont13
        return lab
    }()
    
    lazy var progressView = {()->UIProgressView in
        let pro  = UIProgressView(progressViewStyle:UIProgressView.Style.default)
        pro.progress = 0.0
        pro.setProgress(0.1,animated:true)
        return pro
    }()
    
    func baseTableViewCell(tb tableView: UITableView ,RID ReuseID: String) -> DownLoadTableViewCell {
        var cell  = tableView.dequeueReusableCell(withIdentifier: ReuseID) as? DownLoadTableViewCell
        if cell == nil {
            cell = DownLoadTableViewCell.init(style: .value1, reuseIdentifier: ReuseID)
        }
        return cell!;
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none;
        
        //buttonBar.setTitle("开始", for: .normal)
        self.contentView.addSubview(progressView)
        self.contentView.addSubview(buttonBar)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(progress)
        
        progressView.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.left.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-90)
        }
        progress.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.left.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-80)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 120, height: 30))
        }
        buttonBar.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(60)
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
