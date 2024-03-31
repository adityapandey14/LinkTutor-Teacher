import SwiftUI
import Firebase

struct enrolledClassCard: View {
    var documentId: String
    var className: String
    var days: [String]
    var startTime: Date // Change to Date
    var endTime: Date // Change to Date
    @State private var showingUpdateCourse = false
    @ObservedObject var skillViewModel = SkillViewModel()
    @State private var showDeleteAlert = false

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }

    var body: some View {
        NavigationLink(destination : enrolledLandingPage(id : id , skillUid: skillUid, skillOwnerDetailsUid: skillOwnerDetailsUid , className: className , teacherUid: teacherUid)){
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
                    
                    Text("Timing")
                        .font(AppFont.smallSemiBold)
                        .foregroundColor(.gray)
                    HStack{
                        Text(formattedTimingWithoutDay(date: startTime))
                        Text("-")
                        Text(formattedTimingWithoutDay(date: startTime))
                    }
                    .font(AppFont.smallReg)
                    Spacer()
                }//v end
                Spacer()
                VStack{
                    Button(action: {
                        // Update button action
                        showingUpdateCourse = true
                    }) {
                        Text("Update")
                            .font(AppFont.actionButton)
                            .frame(width: 70, height: 25)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8.0)
                    }
                    .sheet(isPresented: $showingUpdateCourse) {
                        // Present the update course view here
                        UpdateCourseView()
                    }
                    
                    Button(action: {
                        // Delete button action
                        showDeleteAlert.toggle()
                    }) {
                        Text("Delete")
                            .font(AppFont.actionButton)
                            .frame(width: 70, height: 25)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .alert(isPresented: $showDeleteAlert) {
                        Alert(
                            title: Text("Are you sure?"),
                            message: Text("This action cannot be undone."),
                            primaryButton: .destructive(Text("Delete")) {
                                // Perform deletion action
                                deleteClass()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                    Spacer()
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 140)
            .background(Color.elavated)
            .cornerRadius(10)
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
