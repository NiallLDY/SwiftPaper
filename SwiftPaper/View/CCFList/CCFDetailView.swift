//
//  CCFDetailView.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/10/12.
//

import SwiftUI

struct CCFDetailView: View {
    @EnvironmentObject var deadlineStore: DeadLineStore
    
    @State var model: CCFModel
    
    @State var deadline: DeadLine?
    @State var url: URL? = nil
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    VStack {
                        RankView(rank: model.rank, width: 100, height: 100)
                        Text(LocalizedStringKey("\(model.rank) 类")).foregroundColor(.secondary) +
                        Text((LocalizedStringKey(model.form))).foregroundColor(.secondary)
                        if !model.abbreviation.isEmpty {
                            Text(model.abbreviation)
                                .font(.system(.title, design: .rounded))
                                .bold()
                        }
                        Text(model.fullName)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true).font(.title2)
                    }
                    Spacer()
                }
            }
            .listRowBackground(Color.clear)
            
            Section {
                TextinForm(Title: "国际/中文", Content: model.region)
                TextinForm(Title: "领域", Content: model.field)
                    .multilineTextAlignment(.trailing)
                TextinForm(Title: "出版社", Content: model.press)
                Link(destination: URL(string: model.site) ?? URL(string: "https://dblp.org/")!) {
                    Label("访问 dblp 链接", systemImage: "safari")
                }
            }
            .onAppear() { // .task
//                await self.deadlineStore.fetch()
                if self.deadline == nil {
                    self.deadline = deadlineStore.getDeadLine(ccfModel: self.model)
                }
            }
            
            if (self.deadline != nil) {
                DeadLineConfs(conf: deadline!.latestConf, header: "会议征稿信息", abbreviation: self.model.abbreviation, timeZone: deadline!.latestConf.timezone)
                
                NavigationLink(destination: AllDeadLines(confs: deadline!.confs, abbreviation: self.model.abbreviation)) {
                    Text("历届会议信息")
                }
                
            }
        }
        .formStyle(.grouped)
        .navigationTitle(Text("详细信息"))
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

struct CCFDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CCFDetailView(model: CCFStore.placeholderCCF.filter {$0.fullName == "International Joint Conference on Artificial Intelligence"}.first!)
                .environmentObject(DeadLineStore())
        }
        NavigationView {
            CCFDetailView(model: CCFStore.placeholderCCF.filter {$0.fullName == "IEEE Symposium on Security and Privacy"}.first!)
                .environmentObject(DeadLineStore())
        }
        
    }
}


struct TextinForm: View {
    @State var Title: String
    @State var Content: String
    
    var body: some View {
        HStack {
            Text(LocalizedStringKey(Title))
            Spacer()
            Text(LocalizedStringKey(Content)).foregroundColor(.secondary)
        }
        .multilineTextAlignment(.trailing)
    }
}
