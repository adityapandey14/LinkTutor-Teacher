//
//  enrolledStudentCard.swift
//  LinkTutor(T)
//
//  Created by Aditya Pandey on 13/03/24.
//

import SwiftUI

struct enrolledStudentCard: View {
    var studentName : String
    var phoneNumber : Int
    var id : String
    var className : String
    @ObservedObject var viewModel = RequestListViewModel()
  
    @State var showingUpdateCourse = false
    
    
    
    var body: some View{
        NavigationStack{
            
            HStack{
                VStack(alignment: .leading){
                    Text("\(studentName)")
                        .font(AppFont.mediumSemiBold)
                    
                    Text("\(phoneNumber)")
                        .font(AppFont.smallReg)
                        .foregroundColor(.gray)
                        .padding(.top, 1)
                    
                    
                    
                    
                    HStack {
                        
                    
                        
                        
                        NavigationLink(destination : TeacherHomePage()){
                            Button(action: {
                            
                                viewModel.deleteEnrolled(id: id)
                                
                            }) {
                                Text("Delete")
                                    .frame(minWidth: 90, minHeight: 30)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8.0)
                            }
                        }
                    }
                }
                Spacer()
            }
            .frame(width: min(300,200), height: 110)
            .fixedSize()
            .padding()
            .background(Color.accent)
            .cornerRadius(10)
        }
        .navigationTitle("Enrolled Student")
    }
}

#Preview {
    enrolledStudentCard(studentName: "Student Name", phoneNumber: 1234567890, id: "1", className: "Class Name")
}
