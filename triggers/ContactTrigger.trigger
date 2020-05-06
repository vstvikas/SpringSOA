Trigger ContactTrigger on Contact (After insert, After update, After delete, After undelete) {
    
    ContactTriggerHandler triggerHandler = new ContactTriggerHandler();
    if(Trigger.isAfter && ContactTriggerHandler.Execute_After_Context) {
        ContactTriggerHandler.Execute_After_Context = false;
        if(Trigger.isInsert) {
            triggerHandler.afterInsert(Trigger.new);
        }
        else if(Trigger.isUpdate) {
            triggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
        }
        else if(Trigger.isDelete) {
            triggerHandler.afterDelete(Trigger.old);
        }
        else if(Trigger.isUndelete){
            triggerHandler.afterUndelete(Trigger.new);
        }
        
    }
    
}