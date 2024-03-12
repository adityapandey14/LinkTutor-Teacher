import SwiftUI
import Firebase

struct ProfileInputView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var image: Image?
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var city: String = ""
    @State private var phoneNumber: Int = 91
    @State private var about: String = ""
    @State private var occupation : String = ""
    @State private var age : String = ""
    @State private var imageUrl : String = "teacherStockPhoto.jpg"
    @State private var location: GeoPoint = GeoPoint(latitude: 12.8096, longitude: 80.8097)
    
    @State private var showImagePicker: Bool = false
    @State private var isProfileIsSubmit = false
    
    var body: some View {
       
        NavigationStack{
            
            VStack {
                VStack{
                    HStack{
                        Text("Edit Profile ")
                            .font(AppFont.largeBold)
                        Spacer()
                    }
                    
                    
                    Button(action: {
                        showImagePicker = true
                    }) {
                        if let image = image {
                            image
                                .resizable()
                            
                                .frame(width: 100, height: 100)
                                .cornerRadius(50.0)
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .foregroundColor(.gray)
                                .frame(width: 90, height: 90)
                                .cornerRadius(50.0)
                            
                        }
                        //Text("Change profile photo").foregroundColor(.blue)
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(image: $image)
                    }
                }
                .padding()
                
                List{
                    Section(header: Text("")){
                        // Name TextField
                        TextField("Name", text: $fullName)
                            .listRowBackground(Color.elavated)
                        
                        // About TextField
                        TextField("About", text: $about)
                            .listRowBackground(Color.elavated)
                        
                        // Email TextField
                        TextField("Email Address", text: $email)
                            .listRowBackground(Color.elavated)
                            .autocapitalization(.none)
                        
                        TextField("City", text: $city)
                            .listRowBackground(Color.elavated)
                        
                        
                        
                        TextField("Age", text: $age)
                            .listRowBackground(Color.elavated)
                        TextField("Occupation", text: $occupation)
                            .listRowBackground(Color.elavated)
                    }
                    
                    Section(header: Text("Phone Number")){
                        // Password SecureField
                        TextField("PhoneNumber", value: $phoneNumber, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                    }
                    
                    
                    
                }
                .listStyle(.plain)
                .background(.clear)
                NavigationLink(destination: TeacherHomePage(), isActive: $isProfileIsSubmit) {
                    Button(action: {
                        // Handle add class action
                        viewModel.updateTeacherProfile(fullName: fullName,
                                                       email: email,
                                                       aboutParagraph: about,
                                                       age: age,
                                                       city: city,
                                                       imageUrl: imageUrl,
                                                       location: location,
                                                       occupation: occupation,
                                                       phoneNumber: phoneNumber)
                        // Activate the navigation to TeacherHomePage
                        
                        
                        isProfileIsSubmit = true
                    }) {
                        Text("Submit Profile")
                            .foregroundColor(.white)
                            .font(AppFont.mediumSemiBold)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(20)
                    }
                }
               
                // Submit Button
               
                
            } //v end
            .background(Color.background)
            
        }
    }
        
        func submitProfileData() {
            // Handle submission logic here
            print("Name: \(fullName)")
            print("Email: \(email)")
            print("City: \(city)")
            print("Phone Number: \(phoneNumber)")
            print("About: \(about)")
            // You can perform additional actions here, such as validation or sending data to a server.
        }
    }



#Preview {
    ProfileInputView()
    }
//struct ProfileInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileInputView()
//    }
//}




struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: Image?
    @Environment(\.presentationMode) var presentationMode

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = Image(uiImage: uiImage)
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
