//
//  enrolledStudentList.swift
//  LinkTutor(T)
//
//  Created by Aditya Pandey on 26/03/24.
//

import SwiftUI
import Firebase

struct enrolledStudentList: View {
    @StateObject var viewModel = RequestListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Enrolled Subject")
                        .font(AppFont.largeBold)
                    Spacer()
                }
                
                let userId = Auth.auth().currentUser?.uid
                
                VStack(spacing: 10) {
                    let filteredStudents = viewModel.enrolledStudents.filter { $0.teacherUid == userId && $0.requestAccepted == 1 }
                       
                       ForEach(filteredStudents, id: \.id) { student in
                           enrolledStudentCard(studentName: student.studentName,
                                               phoneNumber: student.teacherNumber,
                                               id: student.id,
                                               className: student.className,
                                               skillOwnerDetailsUid: student.skillOwnerDetailsUid,
                                               teacherUid: student.teacherUid,
                                               skillUid: student.skillUid)
                    }
                }
                .onAppear {
                    Task {
                        await viewModel.fetchEnrolledStudents()
                    }
                }
                
                Spacer()
            }
            .padding()
            .background(Color.background)
        }
    }
}

struct enrolledStudentList_Previews: PreviewProvider {
    static var previews: some View {
        enrolledStudentList()
    }
}
