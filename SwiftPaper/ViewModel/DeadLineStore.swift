//
//  DeadLineStore.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/11/28.
//
import Foundation
import Combine

@MainActor
class DeadLineStore: ObservableObject {
    
    private static var loadDataURL = "https://niallapi.top/app/ccf/conference/all.json"
    
    @Published var deadLines: [DeadLine] = []
    @Published var loading: Bool = true
    
    
    func fetch(force: Bool = false) async {
        if deadLines.isEmpty {
            self.loading = true
        }
        do {
            self.deadLines = try await loadjsonfromWeb(from: URL(string: Self.loadDataURL)!, force: force)
            sort()
        } catch {
            print(error)
        }
        self.loading = false
    }
    
    func getDeadLine(ccfModel: CCFModel) -> DeadLine? {
        for deadLine in deadLines {
            if deadLine.title == ccfModel.abbreviation {
                return deadLine
            }
        }
        return nil
    }
    
    func sort() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSSS"
        print(formatter.string(from: Date()))
        let nowDate = Date()
        var times = 0
        self.deadLines = deadLines.sorted {
            times += 1
//            print("times: \(times), \(formatter.string(from: Date()))")
            let date1 = $0.latestConf.nearestDeadLineDate
            let date2 = $1.latestConf.nearestDeadLineDate
            if date1 > nowDate && date2 <= nowDate { return true }
            else if date1 > nowDate && date2 > nowDate && date1 < date2 { return true }
            else if date1 <= nowDate && date2 <= nowDate && date1 > date2 { return true }
            else { return false }
        }
        print(formatter.string(from: Date()))
    }
    
    static var placeholderCCF: [DeadLine] {
        return loadjsonfromFile("all.json")
    }
}
