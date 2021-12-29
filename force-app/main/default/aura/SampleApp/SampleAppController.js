({
    init : function(component, event, helper) {
        var action = component.get("c.getObjectNames");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('response',response.getReturnValue());
                let mapArray =response.getReturnValue().map(  item => {
                    let obj ={};
                    obj.label = item['LabelName'];
                    obj.value = item['ApiName'];
                    return obj;
                });
                console.log("mapArray",mapArray);
                component.set('v.options',mapArray);
                component.set('v.truthy',true);
            }
            else if (state === "INCOMPLETE") {
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    }
})
