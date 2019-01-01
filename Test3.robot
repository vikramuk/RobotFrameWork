*** Settings ***
*** Variables ***
${APP} uftHelp
${URL} https://www.google.ca
${BROWSER} CHROME
*** Test Cases ***
[TC‐001]‐Launching the browser and search and launch the “uftHelp” Application on Google.com
Launch Browser
Search Application On Google
Launch Application
*** Keywords ***