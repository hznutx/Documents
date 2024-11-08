*** Settings ***
Library    Browser
Library    Dialogs
Library    OperatingSystem
Library    Collections
Library    String

*** Test Cases ***
Open Browser And Search
    New Browser    headless=False
    Set Browser Timeout    timeout=150s
    New Page    https://lottery.kapook.com/view286136.html    wait_until=domcontentloaded
    # ${number}    Get Value From User    pls input number prediction
    # Focus    div.content.lead-tracker > div:nth-child(21)
    ${text}    Get Property     div.content.lead-tracker > div:nth-child(21)    property=innerText

    ${text}    Get Regexp Matches   ${text.strip()}    \\b(\\d{2})\\b
    Log To Console    ${text}
    
    FOR    ${item}    IN    @{text}
        
        
        Go To    https://astro.meemodel.com/%E0%B8%A7%E0%B8%B4%E0%B9%80%E0%B8%84%E0%B8%A3%E0%B8%B2%E0%B8%B0%E0%B8%AB%E0%B9%8C%E0%B9%80%E0%B8%A5%E0%B8%82%E0%B8%AB%E0%B8%A7%E0%B8%A2/    
        ...    wait_until=domcontentloaded
        Fill Text    input.form-control    ${item}    #${text}[0]
        Click    button.btn >> text="วิเคราะห์เลขหวยนี้"
        Wait For Elements State    div:nth-child(3) > div:nth-child(2)> div > div:nth-child(1) > strong >> text="${item} ออกล่าสุดเมื่อ"    timeout=15s

        ${percen}    Get Text    div.resultlotto.pd-2 > div:nth-child(3) > div:nth-child(2) > div:nth-child(3) > div:nth-child(6)
        Log To Console    หมายเลข${item} คิดเป็น(%)ของงวดทั้งหมด:${percen}
    END
    # Pause Execution    คิดเป็น(%)ของงวดทั้งหมด:${percen}
    Close Browser
