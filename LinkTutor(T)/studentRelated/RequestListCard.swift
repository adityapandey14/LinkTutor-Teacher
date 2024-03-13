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
    
    
    var body: some View{
        NavigationStack{
            
            HStack{
                VStack(alignment: .leading){
                    Text("\(studentName)")
                        .font(AppFont.mediumSemiBold)
                    
                    Text("\(className)")
                        .font(AppFont.smallSemiBold)
                    
                    Text("\(phoneNumber)")
                        .font(AppFont.smallReg)
                        .foregroundColor(.gray)
                        .padding(.top, 1)
                   
                    
                   
                    
                    HStack {
                        Button(action: {
                            // Delete button action
                            viewModel.updateEnrolled(requestAccepted: 1, requestSent: 0, id: id)
                            
                        }) {
                            Text("Update")
                                .frame(minWidth: 90, minHeight: 30)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8.0)
                        }
                    
                        
                      
                            Button(action: {
                                // Delete button action
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
                Spacer()
            }
            .frame(width: min(300,200), height: 110)
            .fixedSize()
            .padding()
            .background(Color.accentColor)
            .cornerRadius(10)
        }
    }
}
    
#Preview {
    RequestListCard(studentName: "Student Name", phoneNumber: 123456789, id: "id", className: "Class Name")
}


