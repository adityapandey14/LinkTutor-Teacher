import SwiftUI

struct ProfileInputView: View {
    @State private var image: Image?
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var phoneNumber: String = ""
    @State private var about: String = ""
    @State private var showImagePicker: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack {
                Color(.background)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Spacer()
                    
                    Text("Edit Profile Information")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    VStack(spacing: 20) {
                        // Profile Photo
                        VStack(spacing: 10) {
                            if let image = image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(50.0)
                            } else {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(50.0)
                                
                            }
                            
                            Button(action: {
                                showImagePicker = true
                            }) {
                                Text("Change profile photo")
                                    .foregroundColor(.blue)
                            }
                            .sheet(isPresented: $showImagePicker) {
                                ImagePicker(image: $image)
                            }
                        }
                        
                        // Name TextField
                        TextField("Name", text: $name)
                            .padding()
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(8)
                        
                        // Email TextField
                        TextField("Email Address", text: $email)
                            .padding()
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(8)
                        
                        // Password SecureField
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(8)
                        
                        // Phone Number TextField
                        TextField("Phone Number", text: $phoneNumber)
                            .padding()
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(8)
                        
                        // About TextField
                        TextField("About", text: $about)
                            .padding()
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(8)
                    }
                    
                    // Submit Button
                    Button(action: submitProfileData) {
                        Text("Submit")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 12)
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
        
        func submitProfileData() {
            // Handle submission logic here
            print("Name: \(name)")
            print("Email: \(email)")
            print("Password: \(password)")
            print("Phone Number: \(phoneNumber)")
            print("About: \(about)")
            // You can perform additional actions here, such as validation or sending data to a server.
        }
    }


struct ProfileInputView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileInputView()
    }
}




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
