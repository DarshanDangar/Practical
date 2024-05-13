//
//  EditAccountDetailsVC.swift
//  PasswordManager
//
//  Created by Darshan Dangar on 14/05/24.
//

import SwiftUI

struct EditAccountDetailsVC: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State var data: PasswordList?
    @State var name: String = "" //(data?.name ?? "")
    @State var userOrEmail: String = "" // (data?.username ?? "")
    @State var password: String = "" // (data?.password ?? "")
    @State var toast: Toast? = nil
    @FocusState private var focusedField: FocusableField?
    
    var clsEditData: (() -> ())?
    
    var body: some View {
        VStack(alignment: .center) {
            
            TextField("Account Name", text: $name)
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .stroke(.grayBorder, lineWidth: 1)
                }
                .padding([.horizontal], 24)
                .focused($focusedField, equals: .accountName)
            
            TextField("Username / Email", text: $userOrEmail)
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .stroke(.grayBorder, lineWidth: 1)
                }
                .padding([.horizontal], 24)
                .padding([.top], 12)
                .focused($focusedField, equals: .userName)
            
            TextField("Password", text: $password)
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .stroke(.grayBorder, lineWidth: 1)
                }
                .padding([.horizontal], 24)
                .padding([.top], 12)
                .focused($focusedField, equals: .password)
            
            Button(action: {
                if validation {
                    data?.name = name
                    data?.password = password
                    data?.username = userOrEmail
                    updatePassword(passwordList: data ?? PasswordList(context: viewContext))
                }
            }, label: {
                Text("Save Changes")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
            })
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 30)
            }
            .padding([.horizontal], 24)
            .padding([.top, .bottom], 12)
        }
        .toastView(toast: $toast)
        .onAppear {
            focusedField = .accountName
            name = (data?.name ?? "")
            userOrEmail = (data?.username ?? "")
            password = (data?.password ?? "")
        }
    }
}

#Preview {
    EditAccountDetailsVC()
}

extension EditAccountDetailsVC {
    
    var validation: Bool {
        var message: String?
        
        if name.isEmpty {
            message = "Please enter Acount Name."
            focusedField = .accountName
        } else if userOrEmail.isEmpty {
            message = "Please enter Username or Email."
            focusedField = .userName
        } else if password.isEmpty {
            message = "Please enter Password."
            focusedField = .password
        }
        
        if let message {
            toast = Toast(message: message)
            return false
        }
        
        return true
    }
    
}

extension EditAccountDetailsVC {
    
    private func updatePassword(passwordList: PasswordList) {
        
        do {
            try viewContext.save()
            dismiss()
            clsEditData?()
            Toast(style: .success, message: "Password updated successfully!")
            print("Password updated successfully!")
        } catch {
            // Handle errors appropriately
            print(error.localizedDescription)
        }
    }
    
}
