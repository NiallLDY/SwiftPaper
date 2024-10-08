//
//  WelcomeView.swift
//  SwiftPaper (iOS)
//
//  Created by 吕丁阳 on 2021/11/9.
//

import SwiftUI

struct WelcomeView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
            VStack {
                Image("welcome")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 400, maxHeight: 400)
                    .padding()
                Text("SwiftPaper")
                    .font(.system(.largeTitle, design: .rounded))
                Text("**SwiftPaper** 能够助你快速地查询、检索 CCF 计算机推荐期刊、会议列表，查看该会议、期刊的详细信息，能够快速访问查看会议期刊的网址， 并查看会议征稿信息。")
                    .padding()
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Label("开始吧～", systemImage: "bolt")
                }
                .tint(.green)
                .buttonStyle(.bordered)
                .controlSize(.large)
                .padding(.bottom)
            }
        #if os(macOS)
            .frame(minWidth: 400, idealWidth: 500, minHeight: 400, idealHeight: 400)
        #endif
            
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
