//
//  GCDBlackBox.swift
//  OnTheMap
//
//  Created by The book on 2018. 3. 18..
//  Copyright © 2018년 The book. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
