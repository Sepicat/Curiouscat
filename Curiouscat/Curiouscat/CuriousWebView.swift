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
import KVOController

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
        webView.navigationDelegate = self
        return webView
    }()
    
    
    lazy private var progressView: UIProgressView = {
        var progressView = UIProgressView()
        progressView.backgroundColor = .blue
        progressView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.5)
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
        addSubview(progressView)
        
        kvoController.observe(webView, keyPath: "estimatedProgress", options: .new) {
            _, _, _ in
            let progress = self.webView.estimatedProgress
            self.progressView.progress = Float(progress)
        }
    }
    
    private func initialLayouts() {
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64)
            make.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
    }


    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - API
extension CuriousWebView {
    
    public func load() {
        if let url = URL(string: rootUrl) {
            webView.load(URLRequest(url: url))
        }
    }
    
    public func reload() {
        webView.reload()
    }
    
    public func back() {
        webView.goBack()
    }
    
    public func forward() {
        webView.goForward()
    }
    
    public var canBack: Bool {
        get {
            return webView.canGoBack
        }
    }
    
    public var canForward: Bool {
        get {
            return webView.canGoForward
        }
    }
}

extension CuriousWebView: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if let urlText = webView.url?.absoluteString,
            CuriousConfig.getUrlType(with: urlText) == pageType {
            print("Go to: \(urlText)")
        } else {
            webView.stopLoading()
        }
    }
}
