//
//  XMarkLabel.swift
//  Crypto
//
//  Created by Dallin Jared on 12/26/21.
//

import SwiftUI

struct XMarkLabel: View {
    var body: some View {
        Image(systemName: "xmark")
            .font(.headline)
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkLabel()
    }
}
