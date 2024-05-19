//
//  Promise+HttpProvider.swift
//  
//
//  Created by mathwallet on 2022/6/29.
//

import Foundation
import PromiseKit

extension TronWebHttpProvider {
    
    public func getChainParameters() -> Promise<Protocol_ChainParameters> {
        let providerURL = self.url.appending(.getChainParameters)
        return TronWebHttpProvider.GET(nil, providerURL: providerURL, session: self.session)
    }
    
    public func getNowBlock() -> Promise<Protocol_Block> {
        let providerURL = self.url.appending(.getNowBlock)
        return TronWebHttpProvider.POST(nil, providerURL: providerURL, session: self.session)
    }
    
    public func getAccount(_ address: TronAddress) -> Promise<Protocol_Account> {
        let parameters: [String: Encodable] = [
            "address": address.address,
            "visible": true
        ]
        let providerURL = self.url.appending(.getAccount)
        return TronWebHttpProvider.POST(parameters, providerURL: providerURL, session: self.session)
    }
    
    public func getAccountResource(_ address: TronAddress) -> Promise<Protocol_AccountResourceMessage> {
        let parameters: [String: Encodable] = [
            "address": address.address,
            "visible": true
        ]
        let providerURL = self.url.appending(.getAccountResource)
        return TronWebHttpProvider.POST(parameters, providerURL: providerURL, session: self.session)
    }
    
    public func createTransaction(_ contract: Protocol_TransferContract) -> Promise<Protocol_Transaction> {
        let parameters: [String: Encodable] = [
            "owner_address": contract.ownerAddress.toHexString(),
            "to_address": contract.toAddress.toHexString(),
            "amount": contract.amount,
            "visible": false
        ]
        let providerURL = self.url.appending(.createTransaction)
        return TronWebHttpProvider.POST(parameters, providerURL: providerURL, session: self.session)
    }
    
    public func transferAsset(_ contract: Protocol_TransferAssetContract) -> Promise<Protocol_Transaction> {
        let parameters: [String: Encodable] = [
            "owner_address": contract.ownerAddress.toHexString(),
            "to_address": contract.toAddress.toHexString(),
            "asset_name": contract.assetName.toHexString(),
            "amount": contract.amount,
            "visible": false
        ]
        let providerURL = self.url.appending(.transferAsset)
        return TronWebHttpProvider.POST(parameters, providerURL: providerURL, session: self.session)
    }
    
    public func triggerSmartContract(_ request: TronTriggerSmartContractExtension) -> Promise<Protocol_TransactionExtention> {
        let parameters: [String: Encodable] = [
            "owner_address": String(data: request.contract.ownerAddress, encoding: .utf8),
            "contract_address": String(data: request.contract.contractAddress, encoding: .utf8),
            "function_selector": request.functionSelector,
            "parameter": String(data: request.parameter, encoding: .utf8),
            "fee_limit": request.feeLimit,
            "call_value": request.contract.callValue,
            "token_id": request.contract.tokenID,
            "call_token_value": request.contract.callTokenValue,
            "visible": true
        ]
        let providerURL = self.url.appending(.triggerSmartContract)
        return TronWebHttpProvider.POST(parameters, providerURL: providerURL, session: self.session)
    }
    
    public func triggerConstantContract(_ request: TronTriggerSmartContractExtension) -> Promise<Protocol_TransactionExtention> {
        let parameters: [String: Encodable] = [
            "owner_address": request.contract.ownerAddress.toHexString(),
            "contract_address": request.contract.contractAddress.toHexString(),
            "function_selector": request.functionSelector,
            "parameter": request.parameter.toHexString(),
            "call_value": request.contract.callValue,
            "visible": false
        ]
        let providerURL = self.url.appending(.triggerConstantContract)
        return TronWebHttpProvider.POST(parameters, providerURL: providerURL, session: self.session)
    }
    
    public func broadcastTransaction(_ transaction: Protocol_Transaction) -> Promise<TronTransactionSendingResult> {
        let parameters: [String: Encodable] = [
            "transaction": try! transaction.serializedData().toHexString()
        ]
        let providerURL = self.url.appending(.broadcastTransaction)
        return TronWebHttpProvider.POST(parameters, providerURL: providerURL, session: self.session)
    }
}
