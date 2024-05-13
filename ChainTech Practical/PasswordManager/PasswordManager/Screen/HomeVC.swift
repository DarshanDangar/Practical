//
//  HomeVC.swift
//  PasswordManager
//
//  Created by Darshan Dangar on 13/05/24.
//

import SwiftUI
import CoreData

struct HomeVC: View {
    
    @EnvironmentObject var manager: PasswordManager
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: PasswordList.entity(), sortDescriptors: []) // Assuming PasswordList is your entity
    var passwordList: FetchedResults<PasswordList>
    @State var passwordDetails: PasswordList?
    
    @State var passwordData: [PasswordData]? = []
    @State var isAddNewAccount: Bool = false
    @State var isShowDetails: Bool = false
    @State var dataStatus: DataStatus = .add
    @State var toast: Toast? = nil
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                
                VStack(alignment: .leading) {
                    Text("Password Manager")
                        .font(.customFont(.bold, fontSize: 18))
                        .padding()
                    
                    Rectangle()
                        .fill(.graySeperator)
                        .frame(height: 1)
                    
                    ScrollView {
                        LazyVStack {
                            ForEach(passwordList) { data in
                                HomeCell(data: data) {
                                    isShowDetails = true
                                    passwordDetails = data
                                    passwordDetails?.id = data.id
                                    passwordDetails?.name = data.name
                                    passwordDetails?.password = data.password
                                    passwordDetails?.username = data.username
                                }
                            }
                        }
                        .padding()
                        .sheet(isPresented: $isShowDetails, content: {
                            AccountDetailsVC(data: passwordDetails) { status in
                                toast = Toast(style: .success, message: status.title)
                            }
                            .presentationDetents([.medium, .large])
                        })
                    }
                    .scrollIndicators(.hidden)
                }
                .background(.mainBgWhite)
                
                Image("imgAdd") // Replace with your image loading method
                    .background(.darkBlue)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.darkBlue)
                            .frame(width: 60, height: 60)
                    }
                    .padding(.trailing, 20)
                    .sheet(isPresented: $isAddNewAccount, content: {
                        AddNewAccountVC() { status in
                            toast = Toast(style: .success, message: status.title)
                        }
                        .presentationDetents([.medium, .large])
                    })
                    .onTapGesture {
                        isAddNewAccount = true
                    }
                
            }
        }
        .toastView(toast: $toast)
    }
}

#Preview {
    HomeVC()
}

enum DataStatus {
    case add
    case update
    case delete
    
    var title: String {
        switch self {
        case .add:
            return "Data add successfully!"
        case .update:
            return "Data update successfully!"
        case .delete:
            return "Data delete successfully!"
        }
    }
}
