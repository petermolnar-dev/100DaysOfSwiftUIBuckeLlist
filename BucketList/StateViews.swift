//
//  StateViews.swift
//  BucketList
//
//  Created by Peter Molnar on 05/05/2022.
//

import SwiftUI

enum LoadingState {
    case loading, success, failed
}

struct LoadingView: View {
    var body: some View {
        Text("⏳")
            .font(.largeTitle)
    }
}

struct SuccessView: View {
    var body: some View {
        Text("🎉")
            .font(.largeTitle)
    }
}

struct FailedView: View {
    var body: some View {
        Text("🤷🏽‍♂️")
            .font(.largeTitle)
    }
}


// MARK: - Main view
struct StateViews: View {
    @State private var loadingState = LoadingState.loading

    var body: some View {
        VStack {
            switch loadingState {
            case .loading:
                LoadingView()
            case .success:
                SuccessView()
            case .failed:
                FailedView()
            }
                
            HStack {
                Button("Loading") {
                    loadingState = .loading
                }
                .padding(.horizontal)
                
                Button("Success") {
                    loadingState = .success
                }
                .padding(.horizontal)
                
                Button("Failure") {
                    loadingState = .failed
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
    }
}

struct StateViews_Previews: PreviewProvider {
    static var previews: some View {
        StateViews()
    }
}
