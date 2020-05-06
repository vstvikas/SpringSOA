/* Name: ContactTriggerHandler
*  Description: ContactTriggerHandler is used to handle all the Operation for Contact Trigger
Functionality:
@ method updateTotalContactsOnAccount: Update the Number_of_Contacts on Account records
*/
public class ContactTriggerHandler {
    public static Boolean Execute_After_Context = true;
    //after insert operation
    public void afterInsert(List<Contact> newContacts) {
        Set<Id> accountsId = getParentAccountIds(newContacts);
        if(accountsId.size() >0) 	updateTotalContactsOnAccount(accountsId);
    }
    //after update operation
    public void afterUpdate(List<Contact> newContacts, Map<Id, Contact> oldContactsMap) {
        Set<Id> accountsId = new Set<Id>();
        for(Contact contactRec : newContacts){
            if(contactRec.AccountId != oldContactsMap.get(contactRec.Id).AccountId){   
                if(contactRec.AccountId != null) {
                    accountsId.add(contactRec.AccountId); 
                }
                if (oldContactsMap.get(contactRec.Id).AccountId != null) {
                    accountsId.add(oldContactsMap.get(contactRec.Id).AccountId); 
                }
            }
        }
        if(accountsId.size() >0) 	updateTotalContactsOnAccount(accountsId);
    }
    //after delete operation
    public void afterDelete(List<Contact> oldContacts) {
        Set<Id> accountsId = getParentAccountIds(oldContacts);
        if(accountsId.size() >0) 	updateTotalContactsOnAccount(accountsId);
    }
    //after undelete operation
    public void afterUndelete(List<Contact> unDeletedContacts) {
        Set<Id> accountsId = getParentAccountIds(unDeletedContacts);
        if(accountsId.size() >0) 	updateTotalContactsOnAccount(accountsId);
    }

    //@method getParentAccountIds: return a set of Account Id related to contacts
    //@param contactList: list of contacts in Trigger Context
    private Set<Id> getParentAccountIds(List<Contact> contactList) {
        Set<Id> accountIdSet = new Set<Id>();
        for(Contact contactRec : contactList){
            if(contactRec.AccountId != null){   
                accountIdSet.add(contactRec.AccountId); 
            }
        }
        return accountIdSet;
    }
    //@method updateTotalContactsOnAccount: update new Total Contacts count on Account records 
    //@param accountsId: set of accounts Id need to update
    private void updateTotalContactsOnAccount(Set<Id> accountsId) {
        
        List<Account> accountsToUpdate = new List<Account>();
        for(Account accountRec : [Select id ,Name, Number_of_Contacts__c, (Select id From Contacts) from Account Where id IN:accountsId]){
            accountRec.Number_of_Contacts__c = accountRec.Contacts.size();
            accountsToUpdate.add(accountRec);
        }
        try{
            update accountsToUpdate;
        }catch(System.Exception e){
            //Log_error
        }
    }

}