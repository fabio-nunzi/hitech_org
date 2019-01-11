@isTest
private class DailyLeadProcessorTest {
    
    // Dummy CRON expression: midnight on March 15.
    // Because this is a test, job executes
    // immediately after Test.stopTest().
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    
    static testmethod void testScheduledJob() {
        
        // Create some out of date Opportunity records
        List<Lead> leads = new List<Lead>();
        
        for (Integer a = 0;a < 200;a++)
        {
            Lead leadEle = new Lead(FirstName='Gino_'+a, LastName='Pino_' + a,Company='TestCompany');
            leads.add(leadEle);
        }
        
        insert leads;
        
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledDailyLeadProcessor',
                                       CRON_EXP, 
                                       new DailyLeadProcessor());  
        // Stopping the test will run the job synchronously
        Test.stopTest();
        
        System.assertEquals(200,[SELECT count() FROM Lead WHERE LeadSource='DreamForce']);
        
    }
}