//
//	RootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class UserModel : NSObject, NSCoding{

	var address : String!
	var cnic : String!
	var email : String!
	var id : String!
	var password : String!
	var username : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		address = dictionary["address"] as? String
		cnic = dictionary["cnic"] as? String
		email = dictionary["email"] as? String
		id = dictionary["id"] as? String
		password = dictionary["password"] as? String
		username = dictionary["username"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if address != nil{
			dictionary["address"] = address
		}
		if cnic != nil{
			dictionary["cnic"] = cnic
		}
		if email != nil{
			dictionary["email"] = email
		}
		if id != nil{
			dictionary["id"] = id
		}
		if password != nil{
			dictionary["password"] = password
		}
		if username != nil{
			dictionary["username"] = username
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         address = aDecoder.decodeObject(forKey: "address") as? String
         cnic = aDecoder.decodeObject(forKey: "cnic") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         id = aDecoder.decodeObject(forKey: "id") as? String
         password = aDecoder.decodeObject(forKey: "password") as? String
         username = aDecoder.decodeObject(forKey: "username") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if address != nil{
			aCoder.encode(address, forKey: "address")
		}
		if cnic != nil{
			aCoder.encode(cnic, forKey: "cnic")
		}
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if password != nil{
			aCoder.encode(password, forKey: "password")
		}
		if username != nil{
			aCoder.encode(username, forKey: "username")
		}

	}

}
