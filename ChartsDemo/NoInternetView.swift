//
//  NoInternetView.swift
//  ChartsDemo
//
//  Created by Next on 01/07/17.
//  Copyright © 2017 Next. All rights reserved.
//

import UIKit

class NoInternetView: UIView {

    @IBOutlet var mContentView: UIView!
    
    @IBOutlet weak var mMessageLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    /// Loading the the nib, registering cells, adding swipe gestures
    func loadNib() {
        UINib.init(nibName: "NoInternetView", bundle: nil).instantiate(withOwner: self, options: nil)
        mContentView.frame = bounds
        mContentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        addSubview(mContentView)
    }

}
