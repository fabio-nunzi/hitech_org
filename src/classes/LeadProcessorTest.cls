@isTest
private class LeadProcessorTest {

    @testSetup 
    static void setup() {
        List<Lead> leads = new List<Lead>();
        
        // insert 200 leads
        for (Integer i=0;i<200;i++) {
            leads.add(new Lead(FirstName='Test Lead '+i,LastName='Test',Company='TestCompany', Description='This Lead is for test pourpose'));
        }
        
        insert leads;
    }

    static testmethod void test() {        
        Test.startTest();
        LeadProcessor lpBatch = new LeadProcessor();
        Id batchId = Database.executeBatch(lpBatch);
        Test.stopTest();

        // after the testing stops, assert records were updated properly
        System.assertEquals(200, [select count() from Lead where LeadSource = 'Dreamforce']);
    }
    
}