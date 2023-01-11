//
//  Profile.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 07.01.2023.
//

import UIKit

class Profile {
    var name: String
    var email: String
    var photo: UIImage?

    init(
        name: String,
        email: String,
        photo: UIImage?
    ){
        self.name = name
        self.email = email
        self.photo = photo
    }
}


