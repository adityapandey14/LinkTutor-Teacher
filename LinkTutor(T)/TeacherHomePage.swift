import SwiftUI

struct TeacherHomePage: View{
//    init() {
//        let sfRoundedFont = UIFont(name: "SFProRounded-Regular", size: 34)!
//
//        UINavigationBar.appearance().largeTitleTextAttributes = [.font: sfRoundedFont]
//        UINavigationBar.appearance().titleTextAttributes = [.font: sfRoundedFont]
//    }

    @StateObject var viewModel = listClassesScreenModel()
    @State var isShowingFilterViewPopup = false
   
    
    var body: some View{
        NavigationStack{
            VStack{
                VStack{
                    VStack{
                        header(yourName: "Emma")
                            .padding(.bottom)
                        HStack{
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(Color.myGray)
                            Text("Skills, tutors, centers...")
                            Spacer()
                        }
                        .foregroundStyle(Color.myGray).opacity(0.6)
                        .padding(3)
                        .padding(.leading, 10)
                        .frame(width: 370, height: 35)
                        .background(.ultraThinMaterial)
                        .cornerRadius(8)
                        
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                        
                    NavigationLink(destination : addCoursePage()){
                        HStack{
                            Image(systemName: "plus")
                            Text(" Add Class !")
                            Spacer()
                        }
                        .font(AppFont.mediumSemiBold)
                      // .frame(width: .infinity, height: 35)
                        .padding()
                        .background(Color.accent)
                        .foregroundStyle(Color.black)
                        .cornerRadius(20)
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
                    SectionHeader(sectionName: "My classes", fileLocation: TeacherEnrolledClasses(classdata: enrolledClassMockData.sampleClassData))
                        .onTapGesture {
                            viewModel.TeacherEnrolledClassFramework = TeacherEnrolledClasses(classdata: enrolledClassMockData.sampleClassData)
                        }
                    
                    
                    //My classes cards
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 10) {
                            ForEach(1..<4) { index in
                                TeacherEnrolledClassCard(classCard: enrolledClassMockData.classData[index] )
                                //                                    .onTapGesture {
                                //                                        viewModel.selectedFramework = classesMockData.classdata[index]
                                //                                    }
                            }
                        }
                        Spacer()
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



