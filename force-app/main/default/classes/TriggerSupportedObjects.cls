public without sharing class TriggerSupportedObjects {
    
    
    @AuraEnabled(cacheable=true)
    public static List<objectWrapper> getObjectNames(){
        List<objectWrapper> objectWrapperList = new List<objectWrapper>();
        for ( Schema.SObjectType  sobjtyp : Schema.getGlobalDescribe().values() ) {     
            Schema.DescribeSObjectResult objResult = sobjtyp.getDescribe();
                objectWrapper objWrap   = new objectWrapper();                   
                if( isTriggerSupported( objResult )){
                    objWrap.ApiName         = objResult.getName();
                    objWrap.LabelName       = objResult.getLabel();
                    objectWrapperList.add(objWrap); 
                }                          
        }
        objectWrapperList.sort();
        return  objectWrapperList;              
    }
    public static Boolean isTriggerSupported(Schema.DescribeSObjectResult result){
        if(! result.isCustom()){
            if( ! ( result.getName().containsignorecase('Share') ||
                    result.getName().containsignorecase('Feed') ||
                    result.getName().containsignorecase('History') ||
                    result.getName().containsignorecase('Tag') ||
                    result.getName().containsignorecase('ChangeEvent') ||
                    result.isCustomSetting() ) 
                    && 
                ( result.isQueryable() &&
                  result.isCreateable() &&
                  result.isUpdateable()
                )
                       
            )
            {
                return true;
            }
            else{
                return false;
            }
        }
        else {
            if( ( !(    result.getName().containsignorecase('__Share') ||
                        result.getName().containsignorecase('__Feed') ||
                        result.getName().containsignorecase('__History') ||
                        result.getName().containsignorecase('__Tag') ||
                        result.getName().containsignorecase('__ChangeEvent')  || 
                        result.isCustomSetting() 
                   )
                ) && 
                ( result.isQueryable() &&
                  result.isCreateable() &&
                  result.isUpdateable()
                )
            )
            {
                return true;
            }
            else{
                return false;
            }

        }
        
    }
        

    public class ObjectWrapper implements Comparable{       
        @AuraEnabled public String ApiName  {get;set;}
        @AuraEnabled public String LabelName{get;set;}
        //constructor
        objectWrapper(){
        }
   
        //For sorting wrapper list
        public Integer compareTo(Object compareTo) {
                objectWrapper compareToObj = (objectWrapper)compareTo;
                if (LabelName == compareToObj.LabelName) return 0;
                if (LabelName > compareToObj.LabelName) return 1;
                return -1;        
        }

    }

}
