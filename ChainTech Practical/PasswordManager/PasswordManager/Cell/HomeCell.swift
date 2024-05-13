//
//  HomeCell.swift
//  PasswordManager
//
//  Created by Darshan Dangar on 13/05/24.
//

import SwiftUI

struct HomeCell: View {
    var body: some View {
        
        HStack(alignment: .center, spacing: 20) {
            Text("Google")
            
            Text("******")
                .foregroundStyle(.gray)
            
            Spacer(minLength: 40)
            
            Image(uiImage: .imgForward)
            
        }
        .padding(20)
        .background(.white)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .background(.white)
        }
        
    }
}

#Preview {
    HomeCell()
}

struct PasswordData: Codable {
    var name: String?
    var email: String?
    var password: String?
}
