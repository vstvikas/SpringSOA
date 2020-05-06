({
    init: function (cmp, event, helper) {
            cmp.set('v.accountColumns', [
                { label: 'Account Name', fieldName: 'Name', type: 'text'},
                { label: 'Phone', fieldName: 'Phone', type: 'phone'},
                { label: 'Website', fieldName: 'Website', type: 'text'}, 
                { label: 'Created Date', fieldName: 'CreatedDate', type: 'date'}
            ]);
            helper.getRecentlyCreatedAccount(cmp);
        }
})