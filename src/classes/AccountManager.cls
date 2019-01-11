@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
        @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String accountId = request.requestURI.substring(
          request.requestURI.lastIndexOf('Accounts/')+9,request.requestURI.lastIndexOf('/'));
        System.debug('accountId ' + accountId);
        Account result =  [SELECT Id,Name,(SELECT Id,Name FROM Contacts)
                        FROM Account
                        WHERE Id = :accountId];
        return result;
    }
}