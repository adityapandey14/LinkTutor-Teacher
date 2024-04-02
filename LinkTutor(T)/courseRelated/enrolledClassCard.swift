import SwiftUI
import Firebase

struct enrolledClassCard: View {
    var documentId: String
    var className: String
    var days: [String]
    var startTime: Date // Change to Date
    var endTime: Date // Change to Date
    
    @ObservedObject var skillViewModel = SkillViewModel()
    @State private var showDeleteAlert = false
    @State private var showingUpdateCourse = false
    @State private var showingStudentList = false

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }

    var body: some View {
            HStack{
                VStack(alignment: .leading) {
                    Text(className)
                        .font(AppFont.smallSemiBold)
                    
                    Spacer().frame(height: 10)
                    
                    Text("Days")
                        .font(AppFont.smallSemiBold)
                        .foregroundColor(.gray)
                    HStack {
                        ForEach(days, id: \.self) { day in
                            Text(day)
                                .font(AppFont.smallReg)
                        }
                    }
                    
                    Spacer().frame(height: 5)
                    
                    Text("Timing")
                        .font(AppFont.smallSemiBold)
                        .foregroundColor(.gray)
                    HStack{
                        Text(formattedTimingWithoutDay(date: startTime))
                        Text("-")
                        Text(formattedTimingWithoutDay(date: endTime))
                    }
                    .font(AppFont.smallReg)
                    Spacer()
                }//v end
                Spacer()
//                VStack{
//                    Button(action: {
//                        // Update button action
//                        showingUpdateCourse.toggle()
//                    }) {
//                        Text("Update")
//                            .font(AppFont.actionButton)
//                            .frame(width: 70, height: 25)
//                            .background(Color.green)
//                            .foregroundColor(.white)
//                            .cornerRadius(8.0)
//                    }
//                    .sheet(isPresented: $showingUpdateCourse) {
//                        // Present the update course view here
//                        updateCourse(documentId: documentId)
//                    }
//                    
//                    Button(action: {
//                        // Delete button action
//                        showDeleteAlert.toggle()
//                    }) {
//                        Text("Delete")
//                            .font(AppFont.actionButton)
//                            .frame(width: 70, height: 25)
//                            .background(Color.red)
//                            .foregroundColor(.white)
//                            .cornerRadius(8)
//                    }
//                    .alert(isPresented: $showDeleteAlert) {
//                        Alert(
//                            title: Text("Are you sure?"),
//                            message: Text("This action cannot be undone."),
//                            primaryButton: .destructive(Text("Delete")) {
//                                // Perform deletion action
//                                deleteClass()
//                            },
//                            secondaryButton: .cancel()
//                        )
//                    }
//                    Spacer()
//                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 140)
            .background(Color.elavated)
            .foregroundColor(.black)
            .cornerRadius(10)
            .contextMenu {
                //UPDATE DETAILS
                Button(action: {
                    showingUpdateCourse.toggle()
                }) {
                    Text("Update details")
                }
                
                
                //STUDENTS LIST
                Button(action: {
                    showingStudentList.toggle()
                }) {
                    Text("Students enrolled")
                }
                
                
                //DELTE CLASS
                Button(action: {
                    showDeleteAlert.toggle()
                }) {
                    Text("Delete Class")
                }
            }//context menu end
        
            .sheet(isPresented: $showingUpdateCourse) {
                updateCourse(documentId: documentId)
            }
            .sheet(isPresented: $showingStudentList) {
                enrolledStudentList(className: className)
            }
            .alert(isPresented: $showDeleteAlert) {
                Alert(
                    title: Text("Are you sure?"),
                    message: Text("This action cannot be undone."),
                    primaryButton: .destructive(Text("Delete")) {
                        deleteClass()
                    },
                    secondaryButton: .cancel()
                )
            }
    }

    func deleteClass() {
        // Perform deletion logic using skillViewModel
        Task {
            await skillViewModel.deleteOwnerDetails(documentId: documentId)
        }
    }
}

private func formattedTimingWithoutDay(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mm a"
    return formatter.string(from: date)
}

struct UpdateCourseView: View {
    var body: some View {
        // Implement your update course view here
        Text("Update Course View")
    }
}

struct enrolledClassCard_Previews: PreviewProvider {
    static var previews: some View {
        enrolledClassCard(documentId: "", className: "Guitar", days: ["Mon", "Tue"], startTime: Date(), endTime: Date())
    }
}
