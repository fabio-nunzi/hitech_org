public class AccountProcessor {
    
    @future
    public static void countContacts(String[] recordIds)
    {
        List<Account> accounts = [Select Id, Name,(Select Id,Name from Contacts) from Account Where Id IN :recordIds];
        for(Account acc : accounts)
        {
            acc.Number_of_Contacts__c = acc.Contacts.size();
            update acc;
        }
    }
    
}