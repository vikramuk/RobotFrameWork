*** Settings ***
Documentation     As a simulator GUI user,
...               I want to be able to enter simulated parameter values for supported parameters,
...               so that I can verify the values in host device.
Suite Teardown    Close All Browsers
Test Setup        User Opens Default View
Force Tags        simo_GUI
Resource          resource_simo.robot

*** Test Cases ***
Change Numeric Values As Group
    [Documentation]    As a simulator GUI user,
    ...    I want to be able to edit several parameter values and update them to the server with one action,
    ...    so that it is easier for me to setup different test cases.
    [Tags]    us15633
    [Template]    Update Parameter Values And Verify From Server
    #DeviceID    Device Server    Parameter Name    New Parameter Value    Param 2 name    New Param 2 Value    ...
    COM4    ACM    T2    35.5    T1    -0.1
    COM4    ACM    T2    0.0
    COM0    ACM    P1_sys    66    P1_dia    99
    COM0    ACM    P1_dia    -4    P1_sys    0
    COM1    ACM    T1    12345678.0
    /dev/usb6    ACM    T2    0.0
    /dev/usb5    ACM    P1 sys    66    P1 dia    99

Change Numeric Values One By One
    [Documentation]    As a simulator GUI user,
    ...    I want to be able to enter simulated parameter values for supported parameters,
    ...    So that I can verify the values in host device.
    [Tags]    us15093
    [Template]    Update One Parameter Value And Verify From Server
    #DeviceID    Device Server    Parameter Name    New Parameter Value
    COM4    ACM    T2    35.5
    /dev/usb6    ACM    T2    33.3
    COM4    ACM69    T1    0.1
    COM0    ACM    P1_sys    66
    COM0    ACM    P1_dia    99
    COM1    ACM    T1    -12345.3
    /dev/usb5    ACM69    P1 sys    111
    /dev/usb5    ACM    P1 mean    222
    COM1    STXX    T_12_MGAS_AVER_WORK_PRESSURE    2
    /dev/usb6    ACM    T1 Calibration Status Fail    1

Highlight Numeric Modifications
    [Documentation]    As a GUI user,
    ...    I want to be able to easily see which parameter values I have changed since last apply,
    ...    so that I don't accidentally edit values that I shouldn't nor expect something to be simulated when it's not.
    [Tags]    us15634
    [Template]    Update Parameter Values And Verify Highlight
    #DeviceID    Device Server    Parameter Name    New Parameter Value    Orig Parameter Value    Param 2 name New Param 2 Value Orig Param2 Value
    COM4    ACM    T2    35.5    36.8    T1    -0.1
    ...    37.1
    COM4    ACM69    T2    0.0    36.8
    COM0    ACM69    P1_sys    66    120    P1_dia    99
    ...    80
    COM0    ACM    P1_dia    -4    80    P1_sys    0
    ...    120
    COM1    ACM    T1    12345678    37.1
    COM1    STXX    T_12_MGAS_AVER_WORK_PRESSURE    2    0

Reset Highlight On Value Reset
    [Documentation]    As a simulator GUI user,
    ...    I want to be able to edit several parameter values and update them to the server with one action,
    ...    so that it is easier for me to setup different test cases.
    [Tags]    us15634
    [Template]    Change Parameters And Verify Highlight Reset
    #DeviceID    Parameter Name    New Parameter Value    Orig Parameter Value    Param 2 name    New Param 2 Value    Orig Param 2 Value
    COM4    ACM    T2    35.5    36.8    T1    -0.1
    ...    37.1
    COM0    ACM69    P1_sys    66    120    P1_dia    99
    ...    80

Change Custom Wave Form Values One By One
    [Documentation]    As a simulator user,
    ...    I want to enter free-form waveform data to be simulated,
    ...    So that I can verify waveform functionality at host device. I want also to be able to use different kinds of data separators.
    [Tags]    us15215
    [Setup]    Reset Default Devices
    [Template]    Update One Custom Wave Form Value And Verify From Server
    #DeviceID    Device Server    Parameter Name    New Parameter Value    New Parameter Value On Server As String
    /dev/usb5    ACM    P1 wave    23,34,45,56,456,123    23,34,45,56,456,123
    /dev/usb5    ACM69    P1 wave    23 34 45 56 456 123    23,34,45,56,456,123
    /dev/usb5    ACM    P1 wave    23\n34\n45\n56\n456\n123    23,34,45,56,456,123

Use Log Type Parameters
    [Documentation]    As a simulator GUI user,
    ...    I want to be able to enter log entries as parameter values that are forgotten once applied,
    ...    So that I can verify the logging functionality of devices under test and don't need to always first remove the old value.
    [Tags]    us15093    de931
    [Template]    Update Log Parameter Value And Verify From Server And UI
    #DeviceID    Device Server    Parameter Name    New Parameter Value    Orig Parameter Value
    COM0    ACM    Log to monitor memory    20150117.100312: HW xyz is heating up    ${EMPTY}
    COM0    ACM    Log to monitor memory    20150117.100314: HW xyz is still heating - do something!    ${EMPTY}
    COM0    ACM69    Log to monitor memory    20150117.100315: Your module xyz is on fire, run for your life!    ${EMPTY}
    COM0    ACM    Log to printout    Life is too dangerous here, I'm quitting! Adios!    <replace with your test log>
    COM0    ACM    Log to monitor memory    foo<bar    ${EMPTY}
    COM0    ACM    Log to monitor memory    <f>oo<&>bar<    ${EMPTY}

Change Additional Boolean Parameters
    [Template]    Change Additional Boolean Value And Check Results
    #Device Server    #Device ID    Parameter Name    Boolen Field name on server    New Value
    STXX    COM1    T_02_ASX_PVX_OPER_STA    isAutoSend    ${True}
    STXX    COM1    T_02_GAS_REP_STA    isSimulated    ${False}
    STXX    COM1    T_02_ASX_PVX_OPER_STA    isAutoSend    ${False}
    STXX    COM1    T_02_GAS_REP_STA    isSimulated    ${True}
    ACM    COM1    Random Integer Field    3rd boolean    ${True}
    ACM    COM1    T2    4th longer extra    ${True}
    ACM69    COM1    T1    One but longer boolean    ${False}

Show Parameter Tooltips On Hover Or Click
    [Tags]    us16050
    [Template]    Show Parameter Tooltips On Hover Or Click
    #DeviceID    Device Server    Parameter Name    Tooltip description
    COM1    STXX    T_02_ASX_PVX_OPER_STA    A bit longer description with more bullet points\n*First bullet\n - subbullet\n - second subbullet\n*Second bullet\n\nSome final thoughts go here.
    COM1    ACM69    Random Integer Field    Simple and short parameter description
    COM1    ACM    T1    Simple and\nnarrow\nparameter\ndescription
    COM1    ACM    T2    Simple bullets\n* fist one\n* second one

Change Pre-defined Wave Form Values
    [Documentation]    As a simulator user,
    ...    I want to select pre-defined waveform data to be simulated,
    ...    So that I can verify waveform functionality at host device.
    [Tags]    us15092
    [Setup]    Reset Default Devices
    [Template]    Update One Wave Form Value And Verify From Server
    #DeviceID    Device Server    Parameter Name    New Wave Form Name
    /dev/usb5    ACM    P1 wave    sin_0_to_100_50Hz
    /dev/usb5    ACM    P1 wave    sahalaita
    /dev/usb5    ACM    P2 wave    kanttiaalto
    /dev/usb5    ACM69    P1 wave    sahalaita
    /dev/usb5    ACM69    P2 wave    kanttiaalto

Change Boolean Values
    [Documentation]    As a simulator GUI user,
    ...    I want to be able to enter simulated parameter values for supported parameters,
    ...    So that I can verify the values in host device.
    [Tags]    us18255
    [Template]    Update One Boolean Value And Verify From Server
    #DeviceID    Device Server    Parameter Name    New Parameter Value
    COM0    STXX    ent imp- param1    ${False}
    COM0    STXX    e- p2    ${True}
    COM0    STXX    ent imp minus parameter 3    ${True}

Change String Values One By One
    [Documentation]    As a simulator GUI user,
    ...    I want to be able to enter simulated parameter string values for supported parameters,
    ...    So that I can verify the values in host device.
    [Tags]    de1235
    [Template]    Update One Parameter String Value And Verify From Server
    #DeviceID    Device Server    Parameter Name    New Parameter Value
    /dev/usb6    ACM    Acquisition Processor Main SW Version    ----
    /dev/usb5    ACM    Acquisition Processor Main SW Version    foo
    /dev/usb5    ACM    Acquisition Processor Main SW Version    bar
    /dev/usb6    ACM    Acquisition Processor Main SW Version    foobar

*** Keywords ***
Change Additional Boolean Value And Check Results
    [Arguments]    ${devServer}    ${dev}    ${param}    ${srv_name}    ${newValue}
    Given User Opens Default View
    When User Changes An Additional Boolean Value    ${devServer}    ${dev}    ${param}    ${srv_name}    ${newValue}
    Then Parameter Atribute On Server Should Be    ${devServer}    ${dev}    ${srv_name}    ${newValue}    ${param}

Change Parameters And Verify Highlight Reset
    [Arguments]    ${dev}    ${devServer}    @{param-val}
    Given User Opens Default View
    When User Modifies Parameter Values    ${dev}    ${devServer}    @{param-val}
    Then Modified Values Are Highlighted    ${dev}    ${devServer}    @{param-val}
    When User Resets Parameter Values    ${dev}    ${devServer}    @{param-val}
    Then Modified Values Are Not Highlighted    ${dev}    ${devServer}    @{param-val}

Show Parameter Tooltips On Hover Or Click
    [Arguments]    ${dev}    ${devServer}    ${param}    ${tooltip}
    Given User Opens Default View
    Then Parameter Descriptions Work Correctly

Update Log Parameter Value And Verify From Server And UI
    [Arguments]    ${dev}    ${devServer}    ${param}    ${value}    ${orig_value}
    Given User Opens Default View
    When User Changes A Parameter Value    ${dev}    ${devServer}    ${param}    ${value}
    Then The New Log Value Is Found From Server And UI Is Reset    ${dev}    ${devServer}    ${param}    ${value}    ${orig_value}

Update One Boolean Value And Verify From Server
    [Arguments]    ${dev}    ${devServer}    ${param}    ${value}
    Given User Opens Default View
    When User Changes A Boolean Value    ${devServer}    ${dev}    ${param}    ${value}
    Then Parameter Atribute On Server Should Be    ${devServer}    ${dev}    value    ${value}    ${param}

Update One Custom Wave Form Value And Verify From Server
    [Arguments]    ${dev}    ${devServer}    ${param}    ${value}    ${serverValue}
    Given User Opens Default View
    When User Changes A Custom Waveform Parameter Value    ${dev}    ${devServer}    ${param}    ${value}
    Then The New Wave Form Value Is Updated On Server And UI    ${dev}    ${devServer}    ${param}    ${serverValue}

Update One Parameter Value And Verify From Server
    [Arguments]    ${dev}    ${devServer}    ${param}    ${value}
    Given User Opens Default View
    When User Changes A Parameter Value    ${dev}    ${devServer}    ${param}    ${value}
    Then The New Numeric Value Is Updated On Server And UI    ${dev}    ${devServer}    ${param}    ${value}

Update One Wave Form Value And Verify From Server
    [Arguments]    ${dev}    ${devServer}    ${param}    ${value}
    Given User Opens Default View
    When User Changes A Pre-defined Waveform Value For Parameter    ${dev}    ${devServer}    ${param}    ${value}
    Then The New Wave Form Value Is Updated On Server And UI    ${dev}    ${devServer}    ${param}    ${value}

Update Parameter Values And Verify From Server
    [Arguments]    ${dev}    ${devServer}    @{param-val}
    Given User Opens Default View
    When User Changes Parameter Values    ${dev}    ${devServer}    @{param-val}
    Then The New Numeric Values Are Updated On Server And UI    ${dev}    ${devServer}    @{param-val}

Update Parameter Values And Verify Highlight
    [Arguments]    ${dev}    ${devServer}    @{param-val}
    Given User Opens Default View
    When User Modifies Parameter Values    ${dev}    ${devServer}    @{param-val}
    Then Modified Values Are Highlighted    ${dev}    ${devServer}    @{param-val}

Update One Parameter String Value And Verify From Server
    [Arguments]    ${dev}    ${devServer}    ${param}    ${value}
    Given User Opens Default View
    When User Changes A Parameter Value    ${dev}    ${devServer}    ${param}    ${value}
    Then The New String Value Is Updated On Server And UI    ${dev}    ${devServer}    ${param}    ${value}
