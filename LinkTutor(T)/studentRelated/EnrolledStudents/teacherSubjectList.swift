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
        ScrollView {
            
            ForEach(viewModel.skillTypes) { skillType in
                
               
                    
                VStack{
                    
                    ForEach(skillType.skillOwnerDetails.filter { $0.teacherUid == userId  }) { detail in
                        VStack(alignment: .leading) {
                            NavigationLink(destination : enrolledStudentList(className : detail.className) ){
                                Text("\(detail.className)")
                                    .padding()
                                
                            }
                            
                            
                        }
                    }
                }
                .padding()
                .onAppear() {
                    viewModel.fetchSkillOwnerDetails(for: skillType)
                }
            }
        }
    }
}


#Preview {
    teacherSubjectList()
}
