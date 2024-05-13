//
//  AccountDetailsVC.swift
//  PasswordManager
//
//  Created by Darshan Dangar on 13/05/24.
//

import SwiftUI
import CoreData

struct AccountDetailsVC: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State var isShowText: Bool = true
    @State var data: PasswordList?
    @State var isOpenEdit: Bool = false
    @State var toast: Toast? = nil
    var clsAddData: ((DataStatus) -> ())?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Account Details")
                .font(.customFont(.bold, fontSize: 20))
                .foregroundStyle(.blue)
                .font(.headline)
            
            Text("Account Type")
                .font(.customFont(.medium, fontSize: 12))
                .foregroundStyle(.gray)
                .padding([.top], 28)
            
            Text(data?.name ?? "Facebook")
                .font(.customFont(.bold, fontSize: 16))
                .foregroundStyle(.black)
                .padding([.top], 4)
            
            Text("Username/ Email")
                .font(.customFont(.medium, fontSize: 12))
                .foregroundStyle(.gray)
                .padding([.top], 28)
            
            Text(data?.username ?? "Amitshah165@maill.com")
                .font(.customFont(.bold, fontSize: 16))
                .foregroundStyle(.black)
                .padding([.top], 4)
            
            Text("Password")
                .font(.customFont(.medium, fontSize: 12))
                .foregroundStyle(.gray)
                .padding([.top], 28)
            
            HStack {
                Text((isShowText ? "*******" : data?.password) ?? "")
                    .font(.customFont(.bold, fontSize: 16))
                
                Spacer()
                
                Image(systemName: isShowText ? "eye.slash.fill" : "eye.fill")
                    .onTapGesture {
                        isShowText.toggle()
                    }
            }
            .padding([.top], 4)
            
            HStack {
                
                Button(action: {
                    isOpenEdit = true
                }, label: {
                    Text("Edit")
                        .foregroundStyle(.white)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.black)
                                .frame(width: 150)
                        }
                })
                .padding(.leading, 24)
                .sheet(isPresented: $isOpenEdit, content: {
                    EditAccountDetailsVC(data: data) {
                        dismiss()
                        clsAddData?(.update)
                    }
                    .presentationDetents([.medium, .large])
                })
                
                Spacer()
                
                Button(action: {
                    deletePassword(passwordList: data ?? PasswordList(context: viewContext))
                }, label: {
                    Text("Delete")
                        .foregroundStyle(.white)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.red)
                                .frame(width: 150)
                        }
                })
                .padding(.trailing, 24)
                
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 45)
            .padding([.bottom], 24)
            .padding([.horizontal], 24)
            
            
            
        }
        .padding([.horizontal], 24)
        .toastView(toast: $toast)
        
    }
}

#Preview {
    AccountDetailsVC()
}

extension AccountDetailsVC {
    
    private func deletePassword(passwordList: PasswordList) {
        viewContext.delete(passwordList)
        
        do {
            try viewContext.save()
            dismiss()
            clsAddData?(.delete)
            print("Password deleted successfully!")
        } catch {
            // Handle errors appropriately
            print(error.localizedDescription)
        }
    }
    
    private func updatePassword(passwordList: PasswordList) {
        do {
            try viewContext.save()
            dismiss()
            print("Password updated successfully!")
        } catch {
            // Handle errors appropriately
            print(error.localizedDescription)
        }
    }
}
