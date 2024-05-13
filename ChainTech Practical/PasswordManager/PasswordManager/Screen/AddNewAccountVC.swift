//
//  AddNewAccountVC.swift
//  PasswordManager
//
//  Created by Darshan Dangar on 13/05/24.
//

import SwiftUI
import CoreData

struct AddNewAccountVC: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State var name: String = ""
    @State var userOrEmail: String = ""
    @State var password: String = ""
    @State var toast: Toast? = nil
    @FocusState private var focusedField: FocusableField?
    var clsAddData: ((DataStatus) -> ())?
    
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
                    addNewAccount()
                }
            }, label: {
                Text("Add New Account")
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
        }
    }
}

#Preview {
    AddNewAccountVC()
}

// MARK: - Validation
extension AddNewAccountVC {
    
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

enum FocusableField: Hashable {
    case accountName, userName, password
}


extension AddNewAccountVC {
    
    private func addNewAccount() {
        let newPassword = PasswordList(context: viewContext)
        newPassword.id = UUID()
        newPassword.name = name
        newPassword.username = userOrEmail
        newPassword.password = password
        
        do {
            try viewContext.save()
            //            toast = Toast(style: .success, message: "Account added successfully!")
            dismiss()
            clsAddData?(.add)
        } catch {
            // Handle errors gracefully, display error toast
            print(error.localizedDescription)
            toast = Toast(style: .error, message: "Error saving account!")
        }
    }
    
}

