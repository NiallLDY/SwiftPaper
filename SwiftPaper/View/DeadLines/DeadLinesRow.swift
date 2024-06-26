//
//  DeadLinesRow.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/11/29.
//

import SwiftUI

struct DeadLinesRow: View {
    @State var deadLine: DeadLine
    
    @State var countDown = "00d:00h:00m:00s"
    @State var futureDate: Date = Date()
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            RankView(rank: deadLine.rank.ccf)
            VStack(alignment: .leading) {
                Text(deadLine.title + " \(deadLine.latestConf.year)")
                    .font(.system(.title, design: .rounded))
                    .bold()
//                Spacer()
                Text(deadLine.description)
                    .lineLimit(2)
                VStack(alignment: .leading) {
                    Text(LocalizedStringKey(deadLine.sub))
                }
                .font(.caption)
                .foregroundColor(.secondary)
                HStack {
                    Image(systemName: "calendar.badge.clock").renderingMode(.original)
                    Text(countDown).bold()
                        .foregroundStyle(self.futureDate > Date() ? LinearGradientColors[deadLine.rank.ccf] ?? LinearGradientColors["Non-CCF"]! : .linearGradient(colors: [.gray], startPoint: .leading, endPoint: .trailing))
                }
                .padding(.top, 0.5)
                .font(.system(.title3, design: .rounded))
                .animation(.default, value: countDown)
            }
        }
        .task {
            self.futureDate = self.deadLine.latestConf.nearestDeadLineDate
            if futureDate < Date() {
                self.timer.upstream.connect().cancel()
            } else {
                self.countDown = countDownString(from: self.futureDate, until: Date())
            }
        }
        .onReceive(timer) { time in
            if futureDate > Date() {
                self.countDown = countDownString(from: self.futureDate, until: Date())
            }
        }
    }
}

struct DeadLinesRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            DeadLinesRow(deadLine: DeadLineStore.placeholderCCF[0])
        }
    }
}

func countDownString(from date: Date, until nowDate: Date) -> String {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day, .hour, .minute, .second] ,from: nowDate, to: date)
    return String(format: "%02dd:%02dh:%02dm:%02ds",
                  components.day ?? 00,
                  components.hour ?? 00,
                  components.minute ?? 00,
                  components.second ?? 00)
}
