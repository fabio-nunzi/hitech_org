@isTest
public class AddPrimaryContactTest {
    
    @testSetup 
    static void setup() {
        
        List<Account> accounts = new List<Account>();
        for (Integer a = 0;a<50;a++)
        {
            Account acc = new Account(Name='Test002_' + a,BillingState='NY');
            accounts.add(acc);
        }
        
        for (Integer a = 50;a<100;a++)
        {
            Account acc = new Account(Name='Test002_' + a,BillingState='CA');
            accounts.add(acc);
        }
        
        insert accounts;
        
        Contact testContact = new Contact(FirstName='Pippo', LastName='Pappo');
        insert testContact;
    }
    
    static testmethod void testQueueable() {
        
        Contact cont = [SELECT Id,Name,FirstName,LastName FROM Contact WHERE FirstName='Pippo' And LastName = 'Pappo']; //Pippo Pappo contact
        // Create our Queueable instance
        AddPrimaryContact updater = new AddPrimaryContact(cont, 'CA');
        // startTest/stopTest block to force async processes to run
        Test.startTest();        
        System.enqueueJob(updater);
        Test.stopTest();        
        // Validate the job ran. Check if record have correct parentId now
        System.assertEquals(50, [select count() from account where Name LIKE 'Test002%' AND BillingState='CA']);
        System.assertEquals(50, [select count() from account where Name LIKE 'Test002%' AND BillingState='NY']);
        System.assertEquals(50, [select count() from Contact where Name = 'Pippo Pappo' AND Account.BillingState='CA']);
        System.assertEquals(0, [select count() from Contact where Name = 'Pippo Pappo' AND Account.BillingState='NY']);
        
    }
    
}