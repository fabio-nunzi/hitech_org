@IsTest
private class AccountManagerTest {

    @isTest static void testGetAccount() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://ritenta-dev-ed.my.salesforce.com/services/apexrest/Accounts/' + recordId + '/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAcc = AccountManager.getAccount();
        // Verify results
        System.assert(thisAcc != null);
        System.assertEquals('Test record', thisAcc.Name);
        System.assert(thisAcc.Contacts!= null);
        //System.assertEquals('Test',thisAcc.Contacts[0].FirstName);
    }
    
    // Helper method
    static Id createTestRecord() {
        // Create test record
        Account accountTest = new Account(
            Name='Test record');
        insert accountTest;
        Contact contactTest = new Contact(FirstName='Test',LastName='Contact',AccountId=accountTest.Id);
        insert contactTest;
        return accountTest.Id;
    } 
}