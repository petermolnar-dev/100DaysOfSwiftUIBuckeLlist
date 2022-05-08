//
//  FaceAndTouchIDView.swift
//  BucketList
//
//  Created by Peter Molnar on 07/05/2022.
//

import SwiftUI
import LocalAuthentication

struct FaceAndTouchIDView: View {
    
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // Check whether biometric auth is possible?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication was completed
                if success {
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // No biometrics
        }
    }
}

struct FaceAndTouchIDView_Previews: PreviewProvider {
    static var previews: some View {
        FaceAndTouchIDView()
    }
}
