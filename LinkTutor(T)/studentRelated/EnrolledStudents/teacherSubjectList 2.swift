//
//  teacherSubjectList.swift
//  LinkTutor(T)
//
//  Created by Aditya Pandey on 29/03/24.
//

import SwiftUI
import FirebaseAuth

struct teacherSubjectList: View {
    @ObservedObject var viewModel = SkillViewModel()
    @State private var selectedSkillType: SkillType?
    let userId = Auth.auth().currentUser?.uid
    
    var body: some View {
        VStack{
            HStack{
                Text("My Students")
                    .font(AppFont.largeBold)
                Spacer()
            }
            ScrollView {
                ForEach(viewModel.skillTypes) { skillType in
                    VStack{
                        ForEach(skillType.skillOwnerDetails.filter { $0.teacherUid == userId  }) { detail in
                            VStack(alignment: .leading) {
                                NavigationLink(destination : enrolledStudentList(className : detail.className) ){
                                    VStack{
                                        HStack{
                                            Text("\(detail.className)")
                                                .font(AppFont.smallReg)
                                                .foregroundStyle(Color.black)
                                            Spacer()
                                            Image(systemName: "arrow.right")
                                                .foregroundColor(.accent)
                                        }
                                        Divider()
                                    }
                                }
                            }
                        }
                    }
                    .onAppear() {
                        viewModel.fetchSkillOwnerDetails(for: skillType)
                    }
                }
            }//scroll end
            Spacer()
        }
        .padding()
        .background(Color.background)
    }
}


#Preview {
    teacherSubjectList()
}
