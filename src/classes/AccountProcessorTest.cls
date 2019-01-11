@isTest
public class AccountProcessorTest {
    
    @isTest
    public static void testCountContacts()
    {
        Account testAcc_1 = new Account(Name='Test Account');
        insert testAcc_1;
        Contact cont_1 = new Contact(FirstName='Pippo',LastName='Baudo;');
        cont_1.AccountId = testAcc_1.Id;
        insert cont_1;
        Contact cont_2 = new Contact(FirstName='Cippo',LastName='Lippi;');
        cont_2.AccountId = testAcc_1.Id;
        insert cont_2;
        
        Account testAcc_2 = new Account(Name='Test Account');
        insert testAcc_2;
        Contact cont_3 = new Contact(FirstName='Gino',LastName='Frollo;');
        cont_3.AccountId = testAcc_2.Id;
        insert cont_3;
        
        String[] testAccIds = new String[] {testAcc_1.Id,testAcc_2.Id};
            
            
            Test.startTest();
        
        AccountProcessor.countContacts(testAccIds);
        
        
        Test.stopTest();
        
        List<Account> accounts = [Select Id, Name,Number_of_Contacts__c,(Select Id,Name from Contacts) from Account Where Id IN :testAccIds];
        
        //System.assertEquals(0, accounts[0].Number_of_Contacts__c);
        //System.assertEquals(1, accounts[1].Number_of_Contacts__c);
        //System.assertEquals(2, accounts[2].Number_of_Contacts__c);
        Integer[] aspectedRes = new Integer[] {2,1};
            Integer a = 0;
        for(Account acc : accounts)
        { 
            System.debug('Aspected Number of contacts = ' + aspectedRes[a]); 
            System.debug('Number of contacts = ' + acc.Number_of_Contacts__c); 
            System.assertEquals(aspectedRes[a], acc.Number_of_Contacts__c);
            
            a++;
        }
    }
}