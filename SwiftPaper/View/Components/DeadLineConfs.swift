//
//  DeadLineConfs.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/11/28.
//

import SwiftUI

struct DeadLineConfs: View {
    @State var conf: DeadLine.Conf
    @State var url: URL?
    
    @State var header: String?
    
    var abbreviation = ""
    var timeZone = "UTC"
    
    var body: some View {
        Section {
            TextinForm(Title: "会议名称", Content: "\(abbreviation)\(conf.year)")
            TextinForm(Title: "会议时间", Content: conf.date)
            TextinForm(Title: "会议地点", Content: conf.place)
            NavigationLink(destination: DeadLineTimeLine(timeLines: conf.timeline, timeZone: timeZone)) {
                TextinForm(Title: "截稿时间", Content: conf.nearestDeadLine.deadline.localTimeString(timeZone: timeZone))
            }
            Link(destination: conf.link) {
                Label("访问会议网站", systemImage: "safari")
            }
        } header: {
            Text(LocalizedStringKey(header ?? "") )
        }
    }
}

struct DeadLineConfs_Previews: PreviewProvider {
    static var previews: some View {
        DeadLineConfs(conf: DeadLineStore.placeholderCCF[0].confs[0])
    }
}
