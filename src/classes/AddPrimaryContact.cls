public class AddPrimaryContact implements Queueable {
    
    private Contact cont;
    String stateAbbr;
    
    public AddPrimaryContact(Contact cont,String stateAbbr) {
        this.cont = cont;
        this.stateAbbr = stateAbbr;
    }
    
    public void execute(QueueableContext context) {
        
        //account to be edited
        List<Account> acc = [SELECT Id,Name,BillingState FROM Account WHERE BillingState=:stateAbbr LIMIT 200];
        
        //contacts to be inserted
        List<Contact> clonedContacts = new List<Contact>();
        
        for (Account account : acc)
        {
            Contact clone =  new Contact(FirstName = cont.FirstName,LastName=cont.LastName);
            clone.AccountId = account.Id;
            clonedContacts.add(clone);
        }
        
        insert clonedContacts;
    }
    
}