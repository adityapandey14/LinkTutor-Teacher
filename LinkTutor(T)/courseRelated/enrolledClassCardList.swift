//
//  enrolledClassCardList.swift
//  LinkTutor(T)
//
//  Created by Aditya Pandey on 12/03/24.
//

import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestore


struct enrolledClassCardList: View {
    @ObservedObject var skillViewModel = SkillViewModel()
    @EnvironmentObject var viewModel: AuthViewModel
    @State var userId : String = Auth.auth().currentUser?.uid as? String ?? ""
 
    
    var body: some View {
        NavigationStack{
            ScrollView {
                
                ForEach(skillViewModel.skillTypes) { skillType in
                    VStack {
                        
                        VStack(alignment: .leading) {
                            
                            // let userId = Auth.auth().currentUser
                            ForEach(skillType.skillOwnerDetails) { detail in
                                if detail.teacherUid == userId {
                                    VStack(alignment: .leading) {
                                        
                                        enrolledClassCard(documentId: detail.id,
                                                          className: detail.className,
                                                          days: detail.week,
                                                          startTime: detail.startTime,
                                                          endTime: detail.endTime)
                                        // Add other fields as needed
                                    }
                                    .padding()
                                }
                            }
                        }
                        .onAppear() {
                            
                            // await viewModel.fetchUser()
                            skillViewModel.fetchSkillOwnerDetails(for: skillType)
                        }
                    }
                    
                    
                }
            }
        }
    }
}


#Preview {
    enrolledClassCardList()
}
