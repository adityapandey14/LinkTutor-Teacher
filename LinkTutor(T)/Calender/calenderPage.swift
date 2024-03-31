//
//  calenderPage.swift
//  linkTutor
//
//  Created by admin on 20/03/24.
//

import SwiftUI

struct calenderPage: View {
    var className: String
    var tutorName: String
    var startTime: Date

    @State private var isShowingReminderPopup = false
    @State private var reminderTime = Date()
    @State private var note: String = ""

    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                HStack {
                    Text(className)
                        .font(AppFont.smallSemiBold)
                    Spacer()
                    Button(action: {
                        isShowingReminderPopup.toggle()
                    }) {
                        Text("Set Reminder")
                            .font(AppFont.actionButton)
                            .foregroundColor(.accent)
                            .cornerRadius(8)
                    }
                    .sheet(isPresented: $isShowingReminderPopup) {
                        ReminderPopupView(isShowingReminderPopup: $isShowingReminderPopup, reminderTime: $reminderTime, note: $note, className: className, tutorName: tutorName)
                    }
                }
                Spacer().frame(height: 10)

                Text("Timing")
                    .font(AppFont.smallSemiBold)
                    .foregroundColor(.gray)

                HStack {
                    Text("\(formattedTimingWithoutDay(date: startTime))")
                        .font(AppFont.smallReg)
                }
            }
        }
        .padding([.horizontal, .vertical], 15)
        .background(Color.elavated)
        .cornerRadius(10)
    }

    private func formattedTimingWithoutDay(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
}

struct ReminderPopupView: View {
    @Binding var isShowingReminderPopup: Bool
    @Binding var reminderTime: Date
    @Binding var note: String
    var className: String
    var tutorName: String

    var body: some View {
        VStack {
            DatePicker("Select Reminder Time", selection: $reminderTime, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()

            TextField("Note", text: $note)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Set Reminder") {
                // Implement your reminder setting logic here
                isShowingReminderPopup.toggle()
            }
            .padding()
            .foregroundColor(.blue)
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 1))

            Spacer()

            Button(action: {
                // Implement your permission asking logic here
            }) {
                Text("Ask for Notification Permission")
                    .foregroundColor(.blue)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
            }
            .padding()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}

struct calenderPage_Previews: PreviewProvider {
    static var previews: some View {
        calenderPage(className: "Math", tutorName: "John Doe", startTime: Date())
    }
}
