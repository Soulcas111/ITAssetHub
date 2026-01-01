public with sharing class ITAssetController {
    
    @AuraEnabled(cacheable=true)
    public static List<IT_Asset__c> getMyAssets() {
        // 获取当前用户 ID
        String userId = UserInfo.getUserId();
        
        // 查询属于当前登录用户的资产
        return [
            SELECT Id, Name, Serial_Number__c, Status__c, Purchase_Date__c 
            FROM IT_Asset__c 
            WHERE OwnerId = :userId
            ORDER BY CreatedDate DESC
        ];
    }
}