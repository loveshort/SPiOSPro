//
//  ContentView.swift
//  SPSwiftUIShoppingPro
//
//  Created by macmini on 2025/11/7.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 8) {

            HStack {
                // 跑步数据
                VStack(alignment: .leading, spacing: 5) {
                    // 距离
                    Text("第一次")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(Color(red: 50/255, green: 53/255, blue: 59/255))
                    
                    Text("晚上蹲到")
                        .font(.system(size: 12))
                    
                        .foregroundColor(Color(red: 104/255, green: 107/255, blue: 115/255))
                }
                Spacer()
                Image(uiImage: .add)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .cornerRadius(10)
                    .padding(.top,-15)
                    .padding(.trailing,15)
                    
            }
            .background(.red)
             
            GeometryReader { geo in
                let totalWidth = geo.size.width - 50
                let col1 = totalWidth * 0.5    // 50%
                let col2 = totalWidth * 0.25   // 25%
                let col3 = totalWidth * 0.25   // 25%
                // 数据网格
                LazyVGrid(columns: [
                 GridItem(.fixed(col1)),
                 GridItem(.fixed(col2)),
                 GridItem(.fixed(col3))
                ], alignment: .leading,spacing:0) {
                    // 用时
                    VStack(alignment: .leading, spacing: 0) {
                        Text("12213213123")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color(red: 50/255, green: 53/255, blue: 59/255))
                        Text("用时")
                            .font(.system(size: 12))
                            .foregroundColor(Color(red: 104/255, green: 107/255, blue: 115/255))
                    }
                    // 卡路里
                    VStack(alignment: .leading, spacing: 0) {
                        Text("1233")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color(red: 50/255, green: 53/255, blue: 59/255))
                        Text("千卡")
                            .font(.system(size: 12))
                            .foregroundColor(Color(red: 104/255, green: 107/255, blue: 115/255))
                    }
                    // 配速
                    VStack(alignment: .leading, spacing: 0) {
                        Text("12323")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color(red: 50/255, green: 53/255, blue: 59/255))
                        Text("配速")
                            .font(.system(size: 12))
                            .foregroundColor(Color(red: 104/255, green: 107/255, blue: 115/255))
                    }
                }.background(.blue).frame(height: 30)
            }
            
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 15)
        
         
        
    }
}

#Preview {
    ContentView()
}
