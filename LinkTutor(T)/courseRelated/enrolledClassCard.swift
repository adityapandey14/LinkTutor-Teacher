import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct enrolledClassCard: View{
    var documentId : String
    var className : String
    var days : [String]
    var startTime : String
    var endTime : String
    @State var showingUpdateCourse = false
    @EnvironmentObject var viewModel: AuthViewModel
    @ObservedObject var skillViewModel = SkillViewModel()
    
    
    var body: some View{
        NavigationStack{
            
            HStack{
                VStack(alignment: .leading){
                    Text("\(className)")
                        .font(AppFont.mediumSemiBold)
                    
                    Text("Days")
                        .font(AppFont.smallReg)
                        .foregroundColor(.gray)
                        .padding(.top, 1)
                    HStack {
                        ForEach(days, id: \.self) { data in
                            Text("\(data)")
                                .font(AppFont.smallReg)
                        }
                    }
                    
                    Text("Timing")
                        .font(AppFont.smallReg)
                        .foregroundColor(.gray)
                        .padding(.top, 1)
                    HStack{
                        Text("\(startTime)")
                            .font(AppFont.smallReg)
                        Text("\(endTime)")
                            .font(AppFont.smallReg)
                    }
                    
                    HStack {
                        NavigationLink(destination: updateCourse(documentId: documentId), isActive: $showingUpdateCourse) {
                            
                            
                            Button(action: {
                                // Update button action
                                
                                showingUpdateCourse = true
                            }) {
                                Text("Update")
                                    .frame(minWidth: 90, minHeight: 30)
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(8.0)
                            }
                        }
                        
                        Button(action: {
                            // Delete button action
                            skillViewModel.deleteOwnerDetails(documentId: documentId)
                            
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
            .frame(width: min(180,180), height: 160)
            .fixedSize()
            .padding()
            .background(Color.littleDarkAccent)
            .cornerRadius(10)
        }
    }
}



#Preview {
    enrolledClassCard(documentId: "", className: "Guitar", days: ["Mon", "Tue"], startTime: "4:00" , endTime: "5:00")
}






