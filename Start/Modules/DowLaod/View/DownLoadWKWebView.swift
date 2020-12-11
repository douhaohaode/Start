//
//  DownLoadWKWebView.swift
//  Start
//
//  Created by wangjian on 2020/12/6.
//  Copyright © 2020 pactera. All rights reserved.
//

import Foundation
import WebKit



class DownLoadWKWebView: YMTBaseViewController , WKUIDelegate, WKNavigationDelegate{
    
    var webView =  WKWebView()
    
    var fileName : String?{
        didSet{
            navigationItem.title = fileName
            let webConfiguration = WKWebViewConfiguration()
            webConfiguration.selectionGranularity = .character
            webView = WKWebView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), configuration: webConfiguration)
            webView.uiDelegate = self
            webView.navigationDelegate = self
            let docmentsURL : URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = docmentsURL.appendingPathComponent(fileName!)
            webView.loadFileURL(fileURL, allowingReadAccessTo: docmentsURL)
            self.view.addSubview(webView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}



