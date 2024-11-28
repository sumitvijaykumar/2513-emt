*** Settings ***

Resource   common.resource
Resource   ../Variables/config.resource
Resource   ../Variables/language/${language}.resource



*** Keywords ***



Get expected sleeper count  
   

      ${actual_count}    Get Element Count  //p[contains(text(),'Sleeper') and not(contains(text(),'Semi'))]

       [Return]   ${actual_count}
       






















