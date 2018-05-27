//
//  CuriousWebView.swift
//  Curiouscat
//
//  Created by Harry Twan on 2018/5/26.
//  Copyright © 2018年 Harry Twan. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

public class CuriousWebView: UIView {
    
    private(set) var pageType: CuriousConfig.PageType
    private(set) var rootUrl: String
    
    lazy private var webView: WKWebView = {
        let wkConfig = WKWebViewConfiguration()
        
        let wkPreferences = WKPreferences()
        wkPreferences.javaScriptEnabled = true
        
        let wkUserContentController = WKUserContentController()
        
        if let userScript = CuriousConfig.loadUserScript(with: .githubMarkdown) {
            wkUserContentController.addUserScript(userScript)
        }
        
        wkConfig.userContentController = wkUserContentController
        wkConfig.preferences = wkPreferences

        var webView = WKWebView.init(frame: .zero, configuration: wkConfig)
        return webView
    }()
    
    
    lazy private var progressView: UIProgressView = {
        var progressView = UIProgressView()
        progressView.backgroundColor = .blue
        return progressView
    }()
    
    override init(frame: CGRect) {
        self.pageType = .other
        self.rootUrl = "https://desgard.com/"
        super.init(frame: frame)
        initialViews()
        initialLayouts()
        load()
    }
    
    public init(type: CuriousConfig.PageType, url: String) {
        self.pageType = type
        self.rootUrl = url
        super.init(frame: .zero)
        initialViews()
        initialLayouts()
        load()
    }

    private func initialViews() {
        addSubview(webView)
        
    }
    
    private func initialLayouts() {
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }


    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CuriousWebView {
    
    public func load() {
        if let url = URL(string: rootUrl) {
            webView.load(URLRequest(url: url))
        }
    }
    
    public func reload() {
        webView.reload()
    }
}
