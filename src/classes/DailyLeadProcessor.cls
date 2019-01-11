global class DailyLeadProcessor implements Schedulable {

    global void execute(SchedulableContext ctx) {
        
	
        List<Lead> leads = [SELECT Id,LeadSource from Lead Where LeadSource='' LIMIT 200];
        for (Lead leadElement : leads)
        {
            leadElement.Leadsource = 'Dreamforce';
        }
        update leads;
        
    }
    
}