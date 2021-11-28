//
//  DeadLineTimeLine.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/11/28.
//

import SwiftUI

struct DeadLineTimeLine: View {
    var timeLines: [DeadLine.Conf.Timeline]
    var body: some View {
        List {
            ForEach(timeLines, id: \.self) { timeLine in
                Section {
                    if (timeLine.abstractDeadline != nil) {
                        TextinForm(Title: "摘要截止时间", Content: timeLine.abstractDeadline!)
                    }
                    TextinForm(Title: "正文截止时间", Content: timeLine.deadline)
                    if (timeLine.comment != nil) {
                        TextinForm(Title: "备注", Content: timeLine.comment!)
                    }
                }
            }
        }
        .navigationBarTitle(Text("截稿时间"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DeadLineTimeLine_Previews: PreviewProvider {
    static var previews: some View {
        DeadLineTimeLine(timeLines: DeadLineStore.placeholderCCF[0].confs[0].timeline)
    }
}
