import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestore

struct enrolledClassCardList: View {
    @StateObject var skillViewModel = SkillViewModel() // Initialize as StateObject
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var userId = ""
    @State private var hasLoaded = false

    var body: some View {
        NavigationStack {
            VStack{
                HStack{
                    Text("My Classes")
                        .font(AppFont.largeBold)
                    Spacer()
                }
                ScrollView {
                    ForEach(skillViewModel.skillTypes) { skillType in
                        VStack(alignment: .leading, spacing: 10) {
                                ForEach(skillType.skillOwnerDetails) { detail in
                                    if detail.teacherUid == userId {
                                        enrolledClassCard(documentId: detail.id,
                                                          className: detail.className,
                                                          days: detail.week,
                                                          startTime: detail.startTime,
                                                          endTime: detail.endTime)
                                    }
                                }
                            }
                        .onAppear {
                            // Fetch user ID and trigger fetching enrolled details
                            if let currentUser = Auth.auth().currentUser {
                                userId = currentUser.uid
                                fetchEnrolledDetails(for: skillType)
                            }
                        }
                    }
                }//scroll end
            }//vend
            .padding()
            .background(Color.background)
        }
    }
        

    private func fetchEnrolledDetails(for skillType: SkillType) {
        // Ensure fetching is performed only once
        guard !hasLoaded else { return }
        
        // Fetch skill owner details
        Task {
             skillViewModel.fetchSkillOwnerDetails(for: skillType)
            hasLoaded = true
        }
    }
}

struct enrolledClassCardList_Previews: PreviewProvider {
    static var previews: some View {
        enrolledClassCardList()
    }
}
