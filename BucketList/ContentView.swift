//
//  ContentView.swift
//  BucketList
//
//  Created by Peter Molnar on 05/05/2022.
//

import SwiftUI

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
    
    
}


struct ContentView: View {
    @State private var nr = 0

    var body: some View {
       Text("Hello World")
            .onTapGesture {
                let str = "Test message \(nr)"
                let url = getDocumentsDirectory().appendingPathComponent("message.txt")
                
                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
                nr += 1
            }
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible document directories for this user.
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
