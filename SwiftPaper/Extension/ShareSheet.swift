//
//  ShareSheet.swift
//  iSubscribe
//
//  Created by 吕丁阳 on 2021/10/3.
//

import Foundation
import UIKit
import SwiftUI

// For iOS 15

// For iPhone
@available(iOS, deprecated: 16.0, message: "Use the built-in API instead")
func ShareAppSheet() {
    // UIActivityViewController
    let controller = UIActivityViewController(activityItems: [AppURL], applicationActivities: nil)
    UIApplication.shared.keyWindow?.rootViewController?.present(controller, animated: true, completion: nil)
}

extension UIApplication {
    
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
    }
}


// For iPad
@available(iOS, deprecated: 16.0, message: "Use the built-in API instead")
struct ActivityViewController: UIViewControllerRepresentable {

    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}

}

public var AppURL = URL(string: "https://itunes.apple.com/app/id1640972298")!
