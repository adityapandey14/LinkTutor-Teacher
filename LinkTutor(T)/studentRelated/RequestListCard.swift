//
//  requestCard.swift
//  LinkTutor(T)
//
//  Created by Aditya Pandey on 14/03/24.
//

import SwiftUI

struct RequestListCard: View {
    var studentName : String
    var phoneNumber : Int
    var id : String
    var className : String
    @State var showingUpdateCourse = false
//    @EnvironmentObject var viewModel: AuthViewModel
    @ObservedObject var viewModel = RequestListViewModel()
    @State private var isCopied = false
    @State private var showDeleteAlert = false
    @State private var showAcceptAlert = false
    
    var body: some View{
        NavigationStack{
            
            HStack{
                
                //details
                VStack(alignment: .leading){
                    Text("\(studentName)")
                        .font(AppFont.mediumSemiBold)
                        .foregroundStyle(Color.black)
                    
                    Text("\(className)")
                        .font(AppFont.smallSemiBold)
                        .foregroundStyle(Color.black)
                    
                    HStack {
                        Image(systemName: "phone.fill")
                            .font(.system(size: 17))
                        
                        Text("\(phoneNumber)")
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
                
                
                //accept and del buttons
                VStack {
                    Button(action: {
                        // Delete button action
                        showAcceptAlert.toggle()
                        Task {
                             viewModel.updateEnrolled(requestAccepted: 1, requestSent: 0, id: id)
                        }
                        
                    }) {
                        Text("Accept")
                            .frame(minWidth: 90, minHeight: 30)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8.0)
                    }
                    .alert(isPresented: $showAcceptAlert) {
                        Alert(
                            title: Text("Accept"),
                            message: Text("New student has been accepted"),
                            dismissButton: .default(Text("Okay"))
                        )
                    }
                    
                    Button(action: {
                        // Delete button action
                        showDeleteAlert.toggle()
//                        Task {
//                            await viewModel.deleteEnrolled(id: id)
//                        }
                        
                    }) {
                        Text("Delete")
                            .frame(minWidth: 90, minHeight: 30)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8.0)
                    }
                    .alert(isPresented: $showDeleteAlert) {
                        Alert(
                            title: Text("Delete request"),
                            message: Text("Are you sure?"),
                            primaryButton: .destructive(Text("Delete")) {
                                Task {
                                     viewModel.deleteEnrolled(id: id)
                                }
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
                
            }// hstack end
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .fixedSize(horizontal: false, vertical: true) // Allow vertical expansion only
            .padding()
            .background(Color.accentColor)
            .cornerRadius(10)
        }
    }
}
    
#Preview {
    RequestListCard(studentName: "Student Name", phoneNumber: 123456789, id: "id", className: "Class Name")
}


