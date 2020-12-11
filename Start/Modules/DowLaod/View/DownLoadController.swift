//
//  DownLoadController.swift
//  Start
//
//  Created by pactera on 2020/12/4.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class DownLoadController: YMTBaseViewController {
    
    private  var tableView:YMTBaseTableView!
    
    var viewModel : DownloadViewModel?{
        didSet{
      
        }
    }
    var datas : Driver<[DownLoadSection]>?{
        didSet{
            setupUI()
            bindUI()
        }
    }
    
    var testViewModel : DownloadViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
    func setupUI(){
        navigationItem.title = NSLocalizedString("DocumentDownload", comment: "")
        tableView = YMTBaseTableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0),style: .plain)
        tableView.separatorStyle = .none;
        tableView.rowHeight = 65
        tableView.register(DownLoadTableViewCell.self, forCellReuseIdentifier: "DownLoadTableViewCell")
        view.addSubview(self.tableView)
        tableView.snp.makeConstraints { (make) in
            make.right.top.bottom.left.equalToSuperview().offset(0)
        }
    }
    
    func bindUI(){
        
        let dataSource =
            RxTableViewSectionedReloadDataSource<DownLoadSection>(
                configureCell: { (_, tv, indexPath, element) in
                    let cell =  DownLoadTableViewCell().baseTableViewCell(tb: tv, RID: "DownLoadTableViewCell")
                    
                    cell.titleLabel.text = element.title  + String(format: "%.1f", element.progress)
                    cell.buttonBar.setTitle(element.state.rawValue, for: .normal)
                    cell.progress.text = "  已下载 %\(String(format: "%.1f", element.progress*100))"
                    cell.progressView.progress = Float(element.progress)
                    
                    cell.buttonBar.rx.tap.subscribeOn(MainScheduler.instance).subscribe(onNext : { [weak self] _ in
                        if element.state == .none{
                            self!.viewModel!.start(index: indexPath)
                        }
                        if   element.state  == .pause{
                            self!.viewModel!.pause(index: indexPath)
                        }
                        if element.state ==  .continu{
                            self?.viewModel?.goOn(index: indexPath)
                        }
                        if  element.state == .complete{
                            let vc  =  DownLoadWKWebView()
                            vc.fileName = element.title
                            self?.navigationController?.pushViewController(vc, animated: true)
                        }
                    }).disposed(by: cell.bag)
                    return cell
            })
        
       // tableView.rx.setDelegate(self).disposed(by: disposeBag)

        datas!.drive(tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
   
    
    
    deinit {
        print("deinit")
    }
}

//extension DownLoadController : UITableViewDelegate{
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 65
//    }
//}
