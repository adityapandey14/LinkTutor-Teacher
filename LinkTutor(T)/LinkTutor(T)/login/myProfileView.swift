//
//  myProfileView.swift
//  linkTutor
//
//  Created by Vikashini G on 31/01/24.
//

import SwiftUI

struct myProfileView: View {
    
    @StateObject var viewModel = listClassesScreenModel()
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                HStack{
                    Text("My Profile")
                        .font(AppFont.largeBold)
                    Spacer()
                }
                
                profileCard(personName: "Fakie Nameiae", personEmail: "fake_email@gmail.com")
                    .shadow(color: .black.opacity(0.03), radius: 10, x: 0, y: 12)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top)
                
                
                List{
                    HStack{
                        Text("Change password")
                        Spacer()
                        NavigationLink(destination : ChangePasswordView()){
                            
                        }
                    }
                    .listRowBackground(Color.clear)
                    HStack{
                        Text("Delete my account")
                        Spacer()
                        NavigationLink(destination : ChangePasswordView()){}
                    }
                    .listRowBackground(Color.clear)
                    
                    
                }
                .listStyle(PlainListStyle())
                .padding(.top)
                .frame(maxWidth: .infinity, maxHeight: 200,  alignment: .center)
                
                VStack{
                    Text("Logout")
                        .font(AppFont.mediumReg)
                        .foregroundStyle(.black)
                        .frame(width: 180, height: 55)
                        .background(Color.white)
                        .cornerRadius(15)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                
            }
            .padding()
            //.background(gradientBackground())
            .background(Color.background)
        }
    }
}

#Preview {
    myProfileView()
}
