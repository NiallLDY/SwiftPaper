//
//  ImageIconModifier.swift
//  iSubscribe
//
//  Created by 吕丁阳 on 2021/2/10.
//

import SwiftUI

extension Image {
    
    /// Image with iOS icon style.
    /// - Parameter width: Image width and height.
    /// - Returns: An image icon with iOS icon style.
    func IconImageStyle(width: CGFloat) -> some View {
        let cornerRadiusRate: CGFloat = 0.2237
        
        return self
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: width)
            .clipShape(RoundedRectangle(cornerRadius: width * cornerRadiusRate, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: width * cornerRadiusRate, style: .continuous)
                    .stroke(Color(UIColor.systemGray4), lineWidth: 0.5)
            )
        
    }
}
