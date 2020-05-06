@isTest
public class RecentAccountsControllerTest {
	//create Test Data
    @testSetup static void setupData(){
        List<Account> AccountsToCreate = new List<Account>();
        //create 20 accounts
        for(Integer i=0; i<20; i++) {
            Account accountRec = new Account();
            accountRec.Name = 'Test account'+ i;
            accountRec.Website = 'abe'+i+'.com';
            AccountsToCreate.add(accountRec);
        }
        insert AccountsToCreate;
    }
    @isTest static void TestTotalCountOnContactAdded() {
        //call the RecentAccountsController 
        Test.startTest();
        List<Account> recentAccountList = RecentAccountsController.getRecentAccounts();
        Test.stopTest();
        
        //assert the accounts record count
        System.assertEquals(10, recentAccountList.size(), 'Total Accounts count must be 10 as per SOQL query');
    }
}