//
//  enrolledStudentCard.swift
//  LinkTutor(T)
//
//  Created by Aditya Pandey on 26/03/24.
//

import SwiftUI


struct enrolledStudentCard: View {
    var studentName: String
    var phoneNumber: Int
    var id: String
    var className: String
    var skillOwnerDetailsUid: String
    var teacherUid: String
    var skillUid: String
    
    @State var isButtonClicked = false
    @ObservedObject var viewModel = RequestListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                     
                        
                        Text(studentName)
                            .font(AppFont.mediumSemiBold)
                        Spacer()
                    }
                    
                    Spacer()
                    
                    VStack {

                        Button(action: {
                            Task {
                                 viewModel.deleteEnrolled(id: id)
                            }
                        }) {
                            Text("Unenroll")
                                .font(AppFont.actionButton)
                                .foregroundColor(.white)
                        }
                        .frame(minWidth: 90, minHeight: 30)
                        .background(Color.red)
                        .cornerRadius(8)
                    }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 70)
            .padding()
            .background(Color.accent)
            .foregroundColor(.black)
            .cornerRadius(10)
        }
    }
}

struct EnrolledStudentCard_Previews: PreviewProvider {
    static var previews: some View {
        enrolledStudentCard(studentName: "Student Name",
                            phoneNumber: 1234567890,
                            id: "ID",
                            className: "Class Name",
                            skillOwnerDetailsUid: "Skill Owner Details UID",
                            teacherUid: "Teacher UID",
                            skillUid: "Skill UID")
    }
}

