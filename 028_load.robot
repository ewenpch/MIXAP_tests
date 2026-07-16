*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource       ./ressources.robot

*** Test Cases ***
create 8 activities and 1 path
    Open Web Application without closing
    FOR    ${i}    IN RANGE    1    9
        Create empty augmented activity    activité numéro ${i}
    END
    Create empty path

put 8 activities in path
    FOR    ${i}    IN RANGE    1    9
        Add Activity to Path    activité numéro ${i}
    END

create 8 activities and 1 path - Slow 3G
    Open Web Application without closing
    Set Network Speed
    FOR    ${i}    IN RANGE    1    9
        Create empty augmented activity    activité numéro ${i}
    END
    Create empty path

put 8 activities in path - Slow 3G
    FOR    ${i}    IN RANGE    1    9
        Add Activity to Path    activité numéro ${i}
    END
