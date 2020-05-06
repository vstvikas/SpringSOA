@isTest
public class ContactTriggerHandlerTest {
    //create Test Data
    @testSetup static void setupData(){
        Account accountRec = new Account(Name = 'testAccount');
        insert accountRec;
        List<Contact> contactsToCreate = new List<Contact>();
        //create 10 contacts for account
        for(Integer i=0; i<10; i++) {
            Contact contactRec = new Contact();
            contactRec.firstName = 'Test '+ i;
            contactRec.lastName = 'Contact';
            contactRec.accountId = accountRec.Id;
            contactsToCreate.add(contactRec);
        }
        insert contactsToCreate;
    }

    @isTest static void TestTotalCountOnContactAdded() {
        Account accountRec = [SELECT Id FROM Account WHERE Name = 'testAccount'];
        //add contact to account
        Contact contactRec = new Contact(firstName = 'test', lastName = 'Contact', accountId = accountRec.Id);

        Test.StartTest();
        insert contactRec;
        Test.stopTest();

        //get the Account record
        Account updatedAccount = [SELECT Id, Number_of_Contacts__c FROM Account WHERE Id =: accountRec.Id];
        //assert the result
        System.assertEquals(11, updatedAccount.Number_of_Contacts__c, 'Total contacts count increased by 1');
    }

    @isTest static void TestTotalCountOnContactDelete() {
        Contact contactRec = [SELECT Id, accountId FROM Contact WHERE account.Name = 'testAccount' LIMIT 1];
        
        Test.StartTest();
        delete contactRec;
        Test.stopTest();
		
        //get the Account record after delete the contact
        Account updatedAccountOnDelete = [SELECT Id, Number_of_Contacts__c FROM Account WHERE Id =: contactRec.accountId];
        //assert the result
        System.assertEquals(9, updatedAccountOnDelete.Number_of_Contacts__c, 'Total contacts count decreased by 1');
    }

    @isTest static void TestTotalCountOnContactUpdate() {
        //create a new Account record
        Account secondAccount = new Account(Name = 'secondAccount');
        insert secondAccount;

        //change the account 
        Contact contactRec = [SELECT Id, accountId FROM Contact WHERE account.Name = 'testAccount' LIMIT 1];
        contactRec.accountId = secondAccount.Id;

        Test.StartTest();
        update contactRec;
        Test.stopTest();

        //get the Account records and assert the result
        for(Account accountRec: [SELECT Id, Name, Number_of_Contacts__c FROM Account WHERE Name = 'testAccount' OR Name = 'secondAccount']) {
            if(accountRec.Name.equals('testAccount')) {
                System.assertEquals(9, accountRec.Number_of_Contacts__c, 'Total contacts count decreased by 1');
            }
            else if(accountRec.Name.equals('secondAccount')) {
                System.assertEquals(1, accountRec.Number_of_Contacts__c, 'Total contacts count increased by 1');
            }
        }
    }
}