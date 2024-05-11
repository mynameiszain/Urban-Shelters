//
//	RootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class GalleryModel : NSObject, NSCoding{

	var dateUpdated : String!
	var finalSubmission : String!
	var offerId : String!
	var submissionThumbnail : String!
	var thumbnail : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		dateUpdated = dictionary["date_updated"] as? String
		finalSubmission = dictionary["final_submission"] as? String
		offerId = dictionary["offer_id"] as? String
		submissionThumbnail = dictionary["submission_thumbnail"] as? String
		thumbnail = dictionary["thumbnail"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if dateUpdated != nil{
			dictionary["date_updated"] = dateUpdated
		}
		if finalSubmission != nil{
			dictionary["final_submission"] = finalSubmission
		}
		if offerId != nil{
			dictionary["offer_id"] = offerId
		}
		if submissionThumbnail != nil{
			dictionary["submission_thumbnail"] = submissionThumbnail
		}
		if thumbnail != nil{
			dictionary["thumbnail"] = thumbnail
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         dateUpdated = aDecoder.decodeObject(forKey: "date_updated") as? String
         finalSubmission = aDecoder.decodeObject(forKey: "final_submission") as? String
         offerId = aDecoder.decodeObject(forKey: "offer_id") as? String
         submissionThumbnail = aDecoder.decodeObject(forKey: "submission_thumbnail") as? String
         thumbnail = aDecoder.decodeObject(forKey: "thumbnail") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if dateUpdated != nil{
			aCoder.encode(dateUpdated, forKey: "date_updated")
		}
		if finalSubmission != nil{
			aCoder.encode(finalSubmission, forKey: "final_submission")
		}
		if offerId != nil{
			aCoder.encode(offerId, forKey: "offer_id")
		}
		if submissionThumbnail != nil{
			aCoder.encode(submissionThumbnail, forKey: "submission_thumbnail")
		}
		if thumbnail != nil{
			aCoder.encode(thumbnail, forKey: "thumbnail")
		}

	}

}
