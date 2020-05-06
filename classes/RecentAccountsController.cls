/* Name: RecentAccountsController
*  Description: 
    1. HttpCalloRecentAccountsController used in the Aura component RecentAccounts.
    2. Return the 10 recently created Account records.
*/
public with sharing class RecentAccountsController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getRecentAccounts() {
        List<Account> accountList =
                [SELECT Id, Name, Phone, website, CreatedDate FROM Account ORDER BY createdDate DESC LIMIT 10];
        return accountList;
    }
}