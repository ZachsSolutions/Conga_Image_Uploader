public with sharing class FileUploadController {
    @AuraEnabled
    public static void updateContentDocumentTitle(Id contentDocumentId, String newTitle, Id accountId) {
        ContentDocument cd = [SELECT Id FROM ContentDocument WHERE Id = :contentDocumentId LIMIT 1];
        ContentVersion cv = [SELECT Id FROM ContentVersion WHERE ContentDocumentId = :cd.Id ORDER BY CreatedDate DESC LIMIT 1];
system.debug(contentdocumentid);
system.debug(cv);
system.debug(accountid);
        if (cd != null) {
            cd.Title = newTitle;
            update cd;

            List<ContentDistribution> condislist = new List<ContentDistribution>();
            ContentDistribution newDist = new ContentDistribution();
            newDist.ContentVersionId = cv.Id;
            newDist.Name = 'External Link';
            newDist.PreferencesNotifyOnVisit = false;
            newDist.PreferencesAllowViewInBrowser = true;
            newDist.PreferencesAllowOriginalDownload = true;

            insert newDist;

            ContentDistribution newcd = [SELECT Id, DistributionPublicUrl FROM ContentDistribution WHERE Id = :newDist.Id];
            
            Account oAcc = new Account();
            oAcc.Id = accountId;
            oAcc.Logo_Content_Version__c = cv.Id;
            oAcc.Logo_Content_Distribution__c = newDist.Id;

            String distributionPublicUrl = String.valueOf(newcd.DistributionPublicUrl);
            oAcc.Logo_End_URL__c = distributionPublicUrl.substringAfter('/a/');

            update oAcc;
        }
    }
}
