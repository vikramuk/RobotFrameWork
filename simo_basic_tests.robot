*** Settings ***
Documentation     Basic tests for verifying the web-based GUI for TLD Generator
Suite Teardown    Close All Browsers
Force Tags        simo_GUI
Resource          resource_simo.robot

*** Variables ***

*** Test Cases ***
Default Configuration Works Properly
    [Documentation]    Test basic view after reload.
    ...
    ...    This test case will ensure that the GUI can communicate with many servers that are defined in the configuration file, use the Simo Control API, get basic information about the configured devices and present the basic information to user.
    [Tags]    SIMO_SRS_1    SIMO_TP_1    CSV
    Given Servers Are Alive
    When User Opens Default View
    Then Devices For ACM Should Be Shown Correctly
    And Devices For ACM69 Should Be Shown Correctly
    And Devices For STXX Should Be Shown Correctly

Large Amount Of Devices Displayed And Working
    [Tags]    long_lasting
    [Setup]    User Opens Default View
    Given There Are No Devices Configured
    When Adding 100 New Devices Of Type U-TT For Server ACM
    Then All ACM Devices Should Be Listed And Working

All Device Types Display And Work Properly
    [Documentation]    Test that all demoserver device types show up as expected.
    ...
    ...    This test case will check that all device types for ACM and STXX demoservers can be added and that they can be operated on from the UI.
    [Tags]    SIMO_SRS_6    SIMO_TP_4    CSV
    [Setup]    User Opens Default View
    Given There Are No Devices Configured
    When All Devtypes For ACM Are Added
    And All Devtypes For STXX Are Added
    Then All ACM Devices Should Be Listed And Working
    And All STXX Devices Should Be Listed And Working

All Parameter Groups Can Be Opened
    [Documentation]    Test that parameter groups work properly.
    ...
    ...    In default view device's first parametergroup is open and others are closed. In this test case user first clicks all but first parametergroups for selected device. After that all parametergroups should be open, which is confirmed by checking that all parameters are visible for that device. After this user click all parametergroups and then all parametergroups should be closed for this device. This is confirmed by checking that there is no visible parameter for this device.
    [Tags]    us16052
    Given User Opens Default View
    When User Clicks All But First Parametergroups for ACM device COM0
    ${retval}    Then Parameters for ACM device COM0 should be visible
    Verify True    ${retval}    All parameter groups were successfully opened
    When User Clicks All Parametergroups for ACM device COM0
    ${retval}    Then Parameters for ACM device COM0 should be hidden
    Verify True    ${retval}    All parameter groups were successfully closed

All Parameter Groups Are Displayed In Right Order
    [Documentation]    Test that parameter groups are displayed in right order.
    ...
    ...    The parameter grouping is defined by the server, as well as order of groups. UI shall obey this ordering, which this test case verfies.
    [Tags]    us16052    SIMO_SRS_8    SIMO_TP_6    CSV
    When User Opens Default View
    Then All Parameter Groups For ACM Are Displayed In Right Order
    Then All Parameter Groups For STXX Are Displayed In Right Order

*** Keywords ***
