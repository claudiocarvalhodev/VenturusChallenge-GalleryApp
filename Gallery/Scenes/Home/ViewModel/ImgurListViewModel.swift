//
//  ImgurListViewModel.swift
//  Gallery
//
//  Created by claudiocarvalho on 21/01/20.
//  Copyright © 2020 claudiocarvalho. All rights reserved.
//

import Foundation
import Moya

protocol ImgurListProtocol: class {
    func didLoadList(list: ImgurModelData)
    func didFailed()
}

class ImgurListViewModel {
    weak var delegate: ImgurListProtocol?
    private let authPlugin = AccessTokenPlugin { "d42d77ef668c13867e54492a123343154038ccf2" }
    private (set) var service: MoyaProvider<Service>?
    
    init(delegate: ImgurListProtocol) {
        self.delegate = delegate
        self.service = MoyaProvider<Service>(plugins: [NetworkLoggerPlugin(verbose: false), authPlugin])
    }
    
    public func loadList() {
        service?.request(.getList(q: "cats", clientId: "Client-ID 1ceddedc03a5d71"), completion: { (result) in
            switch result {
            case .success(let moya):
                if let list = try? JSONDecoder().decode(ImgurModelData.self, from: moya.data) {
                    self.delegate?.didLoadList(list: list)
                } else {
                    self.delegate?.didFailed()
                }
            case .failure(let error):
                print("error: \(error)")
                self.delegate?.didFailed()
            }
        })
    }
}
