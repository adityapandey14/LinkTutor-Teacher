import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

struct myProfileView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @State var showEditView = false
    @ObservedObject var teacherViewModel = TeacherViewModel.shared
    @State var isClicked : Bool = false
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                HStack{
                    Text("My Profile")
                        .font(AppFont.largeBold)
                    Spacer()
                }
                
                HStack{
                    if let imageUrl = teacherViewModel.teacherDetails.first?.imageUrl {
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image
                                .resizable()
                                .clipped()
                                .frame(width: 70, height: 70)
                                .cornerRadius(50)
                                .padding(.trailing, 5)
                        } placeholder: {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .clipped()
                                .frame(width: 70, height: 70)
                                .cornerRadius(50)
                                .padding(.trailing, 5)
                                .foregroundStyle(Color.gray)
                        }
                        .frame(width: 90, height: 90)
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .clipped()
                            .frame(width: 70, height: 70)
                            .cornerRadius(50)
                            .padding(.trailing, 5)
                            .foregroundStyle(Color.gray)
                    }
                    
                    if let user = viewModel.currentUser {
                        VStack(alignment: .leading){
                            Text(user.fullName)
                                .font(AppFont.mediumSemiBold)
                                .foregroundStyle(Color.black)
                            Text(user.email)
                                .font(AppFont.actionButton)
                                .foregroundStyle(Color.black).opacity(0.7)
                        }
                        .padding(.trailing)
                    }
                    Spacer()
                    VStack{
//                        NavigationLink(destination: ProfileInputView() , isActive: $isClicked){}
                            Button(action: {
                                showEditView.toggle()
                                isClicked = true
                            }) {
                                Text("Edit")
                                    .font(AppFont.actionButton)
                                    .foregroundStyle(Color.blue)
                            }
                            .sheet(isPresented: $showEditView) {
                                ProfileInputView()
                            }
                        Spacer()
                    }
                }
                .padding()
                .frame(width: 350, height: 100)
                .background(Color.elavated)
                .cornerRadius(20)
                
                List{
                    HStack{
                        Text("Change password")
                        NavigationLink(destination : newPassword()){}
                            .opacity(0.0)
                        Spacer()
                        Image(systemName: "arrow.right")
                            .foregroundColor(.accent)
                    }
                    .listRowBackground(Color.clear)
                    HStack{
                        Text("Delete my account")
                        Spacer()
                        Button{
                            showAlert = true
                        } label: {
                            Image(systemName: "arrow.right")
                                .foregroundColor(.accent)
                        }
                    }
                    .alert(isPresented: $showAlert) {
                                // Alert asking for confirmation
                                Alert(
                                    title: Text("Delete Account"),
                                    message: Text("Are you sure you want to delete your account?"),
                                    primaryButton: .destructive(Text("Delete")) {
                                        viewModel.deleteAccount()
                                        print("Account deleted")
                                    },
                                    secondaryButton: .cancel(Text("Cancel"))
                                )
                            }
                    .listRowBackground(Color.clear)
                   
                }
                .listStyle(PlainListStyle())
                .padding(.top)
                .frame(maxWidth: .infinity, maxHeight: 200,  alignment: .center)
                
                Spacer()
                HStack{
                    Spacer()
                    Button {
                        viewModel.signOut()
                    } label: {
                        Text("Logout")
                            .font(AppFont.mediumSemiBold)
                            .foregroundStyle(Color.black)
                            .frame(width: 250, height: 35)
                            .padding()
                            .background(Color.elavated)
                            .cornerRadius(50)
                    }
                    
                    Spacer()
                }
            }
            .padding()
            .background(Color.background)
        }
        .onAppear {
          
            Task {
                let userId = Auth.auth().currentUser?.uid
                await teacherViewModel.fetchTeacherDetailsByID(teacherID: userId!)
            }
        }
    }
}

#Preview {
    let viewModel = AuthViewModel()
          viewModel.currentUser = User(id: "mockUserID", fullName: "John Doe", email: "john@example.com")
          
          return myProfileView()
              .environmentObject(viewModel)
}
