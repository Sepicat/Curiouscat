//
//  CuriousConfig.swift
//  Curiouscat
//
//  Created by Harry Twan on 2018/5/26.
//  Copyright © 2018年 Harry Twan. All rights reserved.
//

import UIKit
import WebKit

public class CuriousConfig {
    
    public enum PageType: Int {
        case githubMarkdown
        case other
    }
    
    static func loadUserScript(with type: PageType) -> WKUserScript? {
        guard let path = Bundle.main.path(forResource: type.scriptName, ofType: "js") else {
            return nil
        }
        
        do {
            let script = try String(contentsOfFile: path, encoding: .utf8)
            return WKUserScript(source: script, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
            
        }
        catch {
            print("Cannot load file")
            return nil
        }
    }
}

public extension CuriousConfig.PageType {
    var scriptName: String {
        get {
            switch self {
            case .githubMarkdown:
                return "github-markdown"
            default:
                return ""
            }
        }
    }
}
