//
//  ActivityIndicatorView.swift
//  MovieInfo
//
//  Created by administrator on 2020. 10. 24..
//  Copyright © 2020. administrator. All rights reserved.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
}
