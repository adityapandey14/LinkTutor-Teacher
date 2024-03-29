import SwiftUI

struct enrolledClassCard: View {
    var documentId: String
    var className: String
    var days: [String]
    var startTime: Date
    var endTime: Date
    @State private var showingUpdateCourse = false
    @ObservedObject var skillViewModel = SkillViewModel()
    @State private var showDeleteAlert = false

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(className)
                .font(.headline)
            
            Text("Days")
                .font(.subheadline)
                .foregroundColor(.gray)
            HStack {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.subheadline)
                }
            }
            
            Text("Timing")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("\(dateFormatter.string(from: startTime)) - \(dateFormatter.string(from: endTime))")
                .font(.subheadline)
            
            HStack {
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
                .sheet(isPresented: $showingUpdateCourse) {
                    // Present the update course view here
                    UpdateCourseView()
                }

                Button(action: {
                    // Delete button action
                    showDeleteAlert.toggle()
                }) {
                    Text("Delete")
                        .frame(minWidth: 90, minHeight: 30)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8.0)
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
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding()
    }

    func deleteClass() {
        // Perform deletion logic using skillViewModel
        Task {
            await skillViewModel.deleteOwnerDetails(documentId: documentId)
        }
    }
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
