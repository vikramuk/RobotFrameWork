*** Settings ***
Library Selenium2Library
*** Variables ***
${APP} uftHelp
${URL} https://www.google.ca
${BROWSER} CHROME
*** Test Cases ***
[TC‐001]‐Launching the browser and search and launch the 'uftHelp' Application on Google.com
Launch Browser
Search Application On Google
Launch Application
*** Keywords ***
Launch Browser
Open Browser ${URL} ${BROWSER}
Maximize Browser Window
Search Application On Google
Input Text id=lst‐ib ${APP}
Click Button name=btnG
Launch Application
Wait Until Element Is Visible link=User‐Friendly Techy‐Help 20 Seconds
Click Element link=User‐Friendly Techy‐Help