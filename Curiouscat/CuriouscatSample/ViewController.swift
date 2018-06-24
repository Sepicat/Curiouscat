//
//  ViewController.swift
//  CuriouscatSample
//
//  Created by Harry Twan on 2018/5/26.
//  Copyright © 2018年 Harry Twan. All rights reserved.
//

import UIKit
import Curiouscat
import Alamofire
import SnapKit

class ViewController: UIViewController {
    
    lazy private var demoWebView: CuriousWebView = {
        return CuriousWebView.init(type: .githubMarkdown, url: "https://github.com/Desgard/iOS-Source-Probe/blob/master/README.md")
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialViews()
        initialLayouts()
    }
    
    private func initialViews() {
        view.backgroundColor = .red
        demoWebView.frame = view.bounds
        view.addSubview(demoWebView)
    }
    private func initialLayouts() {
        demoWebView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(20)
            make.right.bottom.equalToSuperview().offset(-20)
        }
        
        demoWebView.reload()
    }
}

