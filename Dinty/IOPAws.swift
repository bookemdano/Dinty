//
//  IOPAws.swift
//  MacLab
//
//  Created by Daniel Francis on 1/4/25.
//
import AWSS3

struct IOPAws {
    let _app = "Dint"
    let _bucketName = "df-2021"
    init() {
        let credentialsProvider = AWSStaticCredentialsProvider(accessKey: AwsStash.AccessKey, secretKey: AwsStash.SecretKey)
        let configuration = AWSServiceConfiguration(region: .USEast1, credentialsProvider: credentialsProvider)

        AWSServiceManager.default().defaultServiceConfiguration = configuration
    }
    
    public func Read(dir: String, file: String) async -> String
    {
        // Data\Dint\file
        let keyName = dir + "/" + _app + "/" + file
        
        return await getObjectAsync(keyName: keyName)
    }
    func getObjectAsync(keyName: String) async -> String {
   
        return await withCheckedContinuation { continuation in
            getObject(keyName: keyName) { result in
                continuation.resume(returning: result)
            }
        }
    }
    
    func getObject(keyName: String, completion: @escaping (String) -> Void)
    {
        let s3 = AWSS3.default()
        let request = AWSS3GetObjectRequest()
        request?.bucket = _bucketName
        request?.key = keyName
        
        s3.getObject(request!) { response, error in
            if let error = error {
                print("Error reading from S3: \(error)")
            } else if let body = response?.body as? Data,
                      let content = String(data: body, encoding: .utf8) {
                //print("File content: \(content)")
                completion(content)
            } else {
                print("Failed to retrieve content.")
            }
        }
    }
    
    public func Test()
    {
        //configureAWS()
        let s3 = AWSS3.default()
        let bucketName = "df-2021"
        let keyName = "test.txt"
        
        let request = AWSS3GetObjectRequest()
        request?.bucket = bucketName
        request?.key = keyName
        
        s3.getObject(request!) { response, error in
            if let error = error {
                print("Error reading from S3: \(error)")
            } else if let body = response?.body as? Data,
                      let content = String(data: body, encoding: .utf8) {
                print("File content: \(content)")
            } else {
                print("Failed to retrieve content.")
            }
        }
    }
}
