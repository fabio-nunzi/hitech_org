global class LeadProcessor implements 
Database.Batchable<sObject>, Database.Stateful {
    
    global Integer recordsProcessed = 0;
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT ID, LeadSource FROM Lead'
        );
    }
    
    global void execute(Database.BatchableContext bc, List<Lead> scope){
        // process each batch of records
        List<Lead> leadsToUpdate = new List<Lead>();
        for (Lead lead : scope) {
            
            lead.LeadSource = 'Dreamforce';
            recordsProcessed = recordsProcessed + 1;
            leadsToUpdate.add(lead);
        }
        update leadsToUpdate;
    }    
    
    global void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Voila!');
    }    
    
}