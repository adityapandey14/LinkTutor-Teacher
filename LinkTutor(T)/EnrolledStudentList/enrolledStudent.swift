//
//  enrolledStudent.swift
//  LinkTutor(T)
//
//  Created by Aditya Pandey on 13/03/24.
//

import SwiftUI
import Firebase

struct EnrolledStudentView: View {
    @StateObject var viewModel = RequestListViewModel()
    
    var body: some View {
        VStack {
            Text("Enrolled Students")
                .font(.title)
                .padding()
            
            VStack {
                ForEach(viewModel.enrolledStudents.filter { $0.requestAccepted == 0 }, id: \.id) { student in
                    enrolledStudentCard(studentName: student.studentName, phoneNumber: student.studentNumber, id : student.id , className: student.className)
                }
            }
            .onAppear {
                viewModel.fetchEnrolledStudents()
            }
        }
    }
}

struct EnrolledStudentreviews_Previews: PreviewProvider {
    static var previews: some View {
        EnrolledStudentView()
    }
}





