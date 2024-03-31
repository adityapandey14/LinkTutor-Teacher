//
//  myClassesView.swift
//  LinkTutor(T)
//
//  Created by admin on 31/03/24.
//

import SwiftUI

struct myClassesView: View {
    var className: String
    var tutorName: String
    var startTime: Date
    var endTime: Date
    
    @State private var isShowingReminderPopup = false
    @State private var reminderTime = Date()
    @State private var note: String = ""

    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                HStack {
                    Text(className)
                        .font(AppFont.mediumSemiBold)
                    Spacer()
                }
                
                Text("by \(tutorName)")
                    .font(AppFont.smallSemiBold)
                    .foregroundColor(.gray)
                
                Spacer().frame(height: 10)
                
                Text("Timing")
                    .font(AppFont.smallSemiBold)
                    .foregroundColor(.gray)
                
                HStack{
                    Text(formattedTimingWithoutDay(date: startTime))
                        .font(AppFont.smallReg)
                    Text("-")
                    Text(formattedTimingWithoutDay(date: startTime))
                        .font(AppFont.smallReg)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }

    private func formattedTimingWithoutDay(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
}
