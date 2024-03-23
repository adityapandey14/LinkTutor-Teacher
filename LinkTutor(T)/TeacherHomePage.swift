import SwiftUI
import FirebaseAuth
struct TeacherHomePage: View{


    @StateObject var viewModel = listClassesScreenModel()
    @State var isShowingFilterViewPopup = false
    @ObservedObject var teacherViewModel = TeacherViewModel.shared
    @State private var isPresentingAddCourseSheet = false
    
    var body: some View{
        NavigationView {
            VStack{
                VStack{
                    
                    if let fullName = teacherViewModel.teacherDetails.first?.fullName {
                        let nameComponents = fullName.components(separatedBy: " ")
                        let firstName = nameComponents.first ?? ""
                        header(yourName: firstName)
                    }
                    
//                    NavigationLink(destination : addCoursePage()){
//                        HStack{
//                            Image(systemName: "plus")
//                            Text(" Add Class !")
//                            Spacer()
//                        }
//                        .font(AppFont.mediumSemiBold)
//                        .padding()
//                        .background(Color.accent)
//                        .foregroundStyle(Color.black)
//                        .cornerRadius(20)
//                    }
                    Button(action: {
                                isPresentingAddCourseSheet.toggle()
                            }) {
                                HStack {
                                    Image(systemName: "plus")
                                    Text(" Add Class !")
                                    Spacer()
                                }
                                .font(AppFont.mediumSemiBold)
                                .padding()
                                .background(Color.accent)
                                .foregroundColor(Color.black) // Use foregroundColor instead of foregroundStyle
                                .cornerRadius(20)
                            }
                            .sheet(isPresented: $isPresentingAddCourseSheet) {
                                addCoursePage()
                            }
                    .padding(.top)
                }
                .padding(.bottom, 10)
                .onAppear {
                    Task {
                        let userId = Auth.auth().currentUser?.uid
                        await teacherViewModel.fetchTeacherDetailsByID(teacherID: userId!)
                    }
                }
                

                VStack{
                    //today classes section
                    HStack {
                        Text("Your classes today")
                            .font(AppFont.mediumSemiBold)
                        Spacer()
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 15)
                    
                    //today classes cards
                    TeacherEnrolledClassList(classdata: enrolledClassMockData.sampleClassData)
                
                    
                    //My cources section
                    SectionHeader(sectionName: "My classes", fileLocation: RequestList())
                        .onTapGesture {
                            viewModel.TeacherEnrolledClassFramework = TeacherEnrolledClasses(classdata: enrolledClassMockData.sampleClassData)
                        }
                    
                    
                    //My classes cards
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 10) {
                            ForEach(1..<4) { index in
                                TeacherEnrolledClassCard(classCard: enrolledClassMockData.classData[index] )
                            }
                        }
                      
                    }
                    Spacer()
                }
            } // v full end
            .padding()
            .background(Color.background)
        }

    }
    
       
}

#Preview {
    TeacherHomePage()
}



