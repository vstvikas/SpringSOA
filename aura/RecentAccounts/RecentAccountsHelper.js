({
    getRecentlyCreatedAccount : function(cmp) {
        var action = cmp.get('c.getRecentAccounts');
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                debugger;
                cmp.set('v.accountRecords', response.getReturnValue());
            } else if (state === "ERROR") {
                var errors = response.getError();
                console.error(errors);
            }
        }));
        $A.enqueueAction(action);
    }
})