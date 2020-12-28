//
//  PermissionService.swift
//  Weather
//
//  Created by Alena Nesterkina on 24.12.20.
//

import Foundation

protocol PermissionService: AnyObject {
    func resolveStatus(for permission: Permission)
    func request(permission: Permission)
}
