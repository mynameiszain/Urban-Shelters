//
//	RootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class HomeModel : NSObject, NSCoding{

	var agentId : String!
	var backgroundImage : String!
	var dealerName : String!
	var detail : String!
	var favorite : String!
	var id : String!
	var location : String!
	var title : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		agentId = dictionary["agent_id"] as? String
		backgroundImage = dictionary["background_image"] as? String
		dealerName = dictionary["dealer_name"] as? String
		detail = dictionary["detail"] as? String
		favorite = dictionary["favorite"] as? String
		id = dictionary["id"] as? String
		location = dictionary["location"] as? String
		title = dictionary["title"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if agentId != nil{
			dictionary["agent_id"] = agentId
		}
		if backgroundImage != nil{
			dictionary["background_image"] = backgroundImage
		}
		if dealerName != nil{
			dictionary["dealer_name"] = dealerName
		}
		if detail != nil{
			dictionary["detail"] = detail
		}
		if favorite != nil{
			dictionary["favorite"] = favorite
		}
		if id != nil{
			dictionary["id"] = id
		}
		if location != nil{
			dictionary["location"] = location
		}
		if title != nil{
			dictionary["title"] = title
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         agentId = aDecoder.decodeObject(forKey: "agent_id") as? String
         backgroundImage = aDecoder.decodeObject(forKey: "background_image") as? String
         dealerName = aDecoder.decodeObject(forKey: "dealer_name") as? String
         detail = aDecoder.decodeObject(forKey: "detail") as? String
         favorite = aDecoder.decodeObject(forKey: "favorite") as? String
         id = aDecoder.decodeObject(forKey: "id") as? String
         location = aDecoder.decodeObject(forKey: "location") as? String
         title = aDecoder.decodeObject(forKey: "title") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if agentId != nil{
			aCoder.encode(agentId, forKey: "agent_id")
		}
		if backgroundImage != nil{
			aCoder.encode(backgroundImage, forKey: "background_image")
		}
		if dealerName != nil{
			aCoder.encode(dealerName, forKey: "dealer_name")
		}
		if detail != nil{
			aCoder.encode(detail, forKey: "detail")
		}
		if favorite != nil{
			aCoder.encode(favorite, forKey: "favorite")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if location != nil{
			aCoder.encode(location, forKey: "location")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}

	}

}
