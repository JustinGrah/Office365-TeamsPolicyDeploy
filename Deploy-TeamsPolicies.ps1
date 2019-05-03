#╔══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
#║ Script for automaticly assigning Teams Policies to all users                                                                 ║
#║ Author: Justin Grah                                                                                                          ║
#║ Depencies: https://docs.microsoft.com/en-us/powershell/module/skype/?view=skype-ps (Powershell Module: Skype For Business)   ║
#╚══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝

#Configuration
$TeamsPolicyName = "Enable-GuestJoin"   # Name of the previously created Policy
$PolicyType = "MeetingPolicy"           # Policy Types
$RealUsersPath = "<PATH_TO_CSV>"        # List of users that are 

# Connect to Office365 Teams
Import-Module SkypeOnlineConnector
$Credentials = Get-Credential
$TeamsSession = New-CsOnlineSession -Credential $Credentials
Import-PSSession $TeamsSession

#Supported Policy Types
#[AppSetupPolicy;CallingPolicy;CallingParkPolicy;ChannelsPolicy;MeetingBroadcastPolicy;MeetingPolicy;MessagingPolicy;UpgradePolicy;VideoInteropServicePolicy]

#Logic-Section
$RealUsers = Import-Csv -Path $RealUsersPath -Delimiter ";"

foreach($User in $RealUsers) {
    switch($PolicyType) {
        "AppSetupPolicy" {Grant-CsTeamsAppSetupPolicy -Identity $User -PolicyName $TeamsPolicyName -ErrorAction SilentlyContinue}
        "CallingPolicy" {Grant-CsTeamsCallingPolicy -Identity $User -PolicyName $TeamsPolicyName -ErrorAction SilentlyContinue}
        "CallingParkPolicy" {Grant-CsTeamsCallParkPolicy -Identity $User -PolicyName $TeamsPolicyName -ErrorAction SilentlyContinue}
        "ChannelsPolicy" {Grant-CsTeamsChannelsPolicy -Identity $User -PolicyName $TeamsPolicyName -ErrorAction SilentlyContinue}
        "MeetingBroadcastPolicy" {Grant-CsTeamsMeetingBroadcastPolicy -Identity $User -PolicyName $TeamsPolicyName -ErrorAction SilentlyContinue}
        "MeetingPolicy" {Grant-CsTeamsMeetingPolicy -Identity $User -PolicyName $TeamsPolicyName -ErrorAction SilentlyContinue}
        "MessagingPolicy" {Grant-CsTeamsMessagingPolicy -Identity $User -PolicyName $TeamsPolicyName -ErrorAction SilentlyContinue}
        "UpgradePolicy" {Grant-CsTeamsUpgradePolicy -Identity $User -PolicyName $TeamsPolicyName -ErrorAction SilentlyContinue}
        "VideoInteropServicePolicy" {Grant-CsTeamsVideoInteropServicePolicy -Identity $User -PolicyName $TeamsPolicyName -ErrorAction SilentlyContinue}
        default {"The Policy you enterd is either not Supported by this script or not existent!"}
    }
    
    
}

Write-Host("The Policy " + $TeamsPolicyName + " was deployed for all Users");