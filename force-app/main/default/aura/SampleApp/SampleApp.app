<aura:application extends="force:slds" controller="TriggerSupportedObjects">
      <aura:attribute name="options" type="List" default="[{'label':'Bob','value':'123'},
                                                           {'label':'Chrissey','value':'345'},
                                                           {'label':'Jessica','value':'456','disabled': true},
                                                           {'label':'Sunny','value':'567'}]" />
      <aura:attribute name="selectedValue" type="String" 
                      default="" description="Selected value in single Select" />
      <aura:attribute name="selectedValues" type="List" 
                      default="" description="Selected value in Multi Select" />

      <aura:attribute name="truthy" type="Boolean" 
                     default="false"     />

      <aura:handler name="init" value="{!this}" action="{!c.init}" />
 	   
      <aura:if isTrue="{!v.truthy}">
         <c:multiSelectCombobox options="{!v.options}" 
                                selectedValue="{!v.selectedValue}" 
                                label="Single Select Combobox">
         </c:multiSelectCombobox>
      </aura:if>
      <!-- <c:multiSelectCombobox multiSelect="true" options="{!v.options}" selectedValues="{!v.selectedValues}" label="Multi Select Combobox">
      </c:multiSelectCombobox> -->

</aura:application>	
