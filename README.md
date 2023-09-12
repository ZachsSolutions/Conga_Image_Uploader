# Conga_Image_Uploader
When merging files in Conga Compose, they need to be uploaded into salesforce in a particular way.  This tool creates an upload modal which uploads the file, shares as a public file, and accesses the public URL that can be used as a field value for merging in Conga documents.

This code provides a tool to upload images, and have them stored in a way which can be directly merged into any Conga document. 

The tool requires new fields to be created on Account: 

Field: Logo_URL__c (this is the field to merge from in conga)
Data Type	Formula	 	 
Value: "https://YOURINSTANCEHERE.file.force.com/sfc/dist/version/renditionDownload?rendition=ORIGINAL_Png&versionId="+Logo_Content_Version__c+"&operationContext=DELIVERY&contentId=" + Logo_Content_Distribution__c + "&page=0&d=/a/"+ Logo_End_URL__c +"&oid="+ Logo_Org_Id__c +"&dpt=null&viewId="

Logo_Content_Version__c
Data Type Text (18)
Value set during upload


Logo_Content_Distribution__c
Data Type Text(18)
Value set during Upload

Logo_End_URL__c
Data Type Text(255)
Value set during Upload

Logo_Org_ID__c
Data Type Formula:
Value: $Organization.Id

![image](https://github.com/ZachsSolutions/Conga_Image_Uploader/assets/52823904/20c2011a-76fa-4db0-8abc-3bbf533540b3)


