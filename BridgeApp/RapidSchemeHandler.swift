//
//  RapidSchemeHandler.swift
//  BridgeApp
//
//  Created by Franco Octavianus on 23/12/2022.
//

import Foundation
import UniformTypeIdentifiers
import WebKit

final class RapidSchemeHandler: NSObject, WKURLSchemeHandler {
    static var urlScheme = "rapidai"

    func webView(_ webView: WKWebView, start urlSchemeTask: WKURLSchemeTask) {
        guard let url = urlSchemeTask.request.url,
              let fileUrl = fileUrl(from: url),
              let mimeType = mimeType(url: fileUrl),
              let data = try? Data(contentsOf: fileUrl) else { return }
            
        let response = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: String(kCFHTTPVersion1_1),
            headerFields: [
                "Content-Type": mimeType,
                "Cache-Control": "no-cache",
                "Cross-Origin-Embedder-Policy": "require-corp",
                "Cross-Origin-Opener-Policy": "same-origin"
            ]
        )!
            
//        let response = HTTPURLResponse(
//            url: url,
//            mimeType: mimeType,
//            expectedContentLength: data.count, textEncodingName: nil)

//        print("\(#file):\(#line) \(#function)")
//        print(response.description)
//        urlSchemeTask.didReceive(response)
//        urlSchemeTask.didReceive(data)
//        urlSchemeTask.didFinish()
    }

    func webView(_ webView: WKWebView, stop urlSchemeTask: WKURLSchemeTask) {
    }

    // MARK: - Private

    private func fileUrl(from url: URL) -> URL? {
        guard let assetName = url.host else { return nil }
        return Bundle.main.url(forResource: assetName, withExtension: nil)
    }

    private func mimeType(url: URL) -> String? {
        guard let type = UTType(filenameExtension: url.pathExtension) else {
            return nil
        }
        return type.preferredMIMEType
    }
}
