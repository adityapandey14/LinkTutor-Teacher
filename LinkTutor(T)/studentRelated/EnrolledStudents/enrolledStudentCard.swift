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
    
    @State var isCopied = false
    @State var isButtonClicked = false
    @ObservedObject var viewModel = RequestListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(studentName)
                            .font(AppFont.smallReg)
                        Spacer()
                        HStack {
                            Image(systemName: "phone.fill")
                                .font(.system(size: 17))
                            
                            Text(String("\(phoneNumber)"))
                                .font(AppFont.actionButton)
                        }
                        .padding([.top, .bottom], 6)
                        .padding([.leading, .trailing], 12)
                        .background(Color.phoneAccent)
                        .foregroundStyle(Color.black)
                        .cornerRadius(50)
                        .onTapGesture {
                            let phoneNumberString = "\(phoneNumber)"
                            UIPasteboard.general.string = phoneNumberString
                            isCopied = true
                        }
                        .alert(isPresented: $isCopied) {
                            Alert(title: Text("Copied!"), message: Text("Phone number copied to clipboard."), dismissButton: .default(Text("OK")))
                        }
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
                        
                        Spacer()
                    }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 70)
            .padding()
            .background(Color.elavated)
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

