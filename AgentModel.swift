//
//	RootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class AgentModel : NSObject, NSCoding{

	var agentEmail : String!
	var agentId : String!
	var agentImage : String!
	var agentName : String!
	var createdAt : String!
	var phoneNo : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		agentEmail = dictionary["agent_email"] as? String
		agentId = dictionary["agent_id"] as? String
		agentImage = dictionary["agent_image"] as? String
		agentName = dictionary["agent_name"] as? String
		createdAt = dictionary["created_at"] as? String
		phoneNo = dictionary["phone_no"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if agentEmail != nil{
			dictionary["agent_email"] = agentEmail
		}
		if agentId != nil{
			dictionary["agent_id"] = agentId
		}
		if agentImage != nil{
			dictionary["agent_image"] = agentImage
		}
		if agentName != nil{
			dictionary["agent_name"] = agentName
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if phoneNo != nil{
			dictionary["phone_no"] = phoneNo
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         agentEmail = aDecoder.decodeObject(forKey: "agent_email") as? String
         agentId = aDecoder.decodeObject(forKey: "agent_id") as? String
         agentImage = aDecoder.decodeObject(forKey: "agent_image") as? String
         agentName = aDecoder.decodeObject(forKey: "agent_name") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         phoneNo = aDecoder.decodeObject(forKey: "phone_no") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if agentEmail != nil{
			aCoder.encode(agentEmail, forKey: "agent_email")
		}
		if agentId != nil{
			aCoder.encode(agentId, forKey: "agent_id")
		}
		if agentImage != nil{
			aCoder.encode(agentImage, forKey: "agent_image")
		}
		if agentName != nil{
			aCoder.encode(agentName, forKey: "agent_name")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if phoneNo != nil{
			aCoder.encode(phoneNo, forKey: "phone_no")
		}

	}

}
