//
//  HomeCell.swift
//  PasswordManager
//
//  Created by Darshan Dangar on 13/05/24.
//

import SwiftUI
import CoreData

struct HomeCell: View {
    
    var data: PasswordList?
    var clsShowDetails: (() -> ())?
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 20) {
            Text(data?.name ?? "Google")
                .font(.customFont(.bold, fontSize: 20))
            
            Text(String(repeating: "*", count: data?.password?.count ?? 0))
                .font(.customFont(.bold, fontSize: 20))
                .foregroundStyle(.gray)
            
            Spacer(minLength: 40)
            
            Image(uiImage: .imgForward)
            
        }
        .padding(20)
        .frame(height: 66)
        .background(.white)
        .background {
            RoundedRectangle(cornerRadius: 33)
                .stroke(.grayBorder, lineWidth: 1)
                .fill(.white)
        }
        .cornerRadius(30)
        .onTapGesture {
            clsShowDetails?()
        }
        
    }
}

#Preview {
    HomeCell()
}

// Assuming PasswordList is your Core Data entity:

class PasswordData: NSManagedObject {
    var id: UUID = UUID()
    var name: String?
    var email: String?
    var password: String?
}
