(*
This script was inspired by the excellent Outlook Exchange Setup 4.0.1 by William Smith: bill@officeformachelp.com

We needed a script that was more AD focused to pull information from our AD user record that included funky things like hyphens and spaces.

For use on OS X 10.7 and above.

As long as the current user is a Active Directory user, it will create
an new account entry in Outlook 2011 using that information.

A dialog will appear, pausing the script while Outlook will ask for the account password. Click continue and you're done!

BEST PRACTICE IS TO DELETE ANY EXISTING EXCHANGE ACCOUNTS BEFORE RUNNING.

Changelog:
1.0
Improved documentation, formatting
Cleaned up

0.4
Added dialog to pause script while user enters password. Fixes issue "Hide on my Computer" setting issue
Commented out a bunch of exteraneous stuff

0.3
Changed dscl lookup to use a temoprary plist and pull keys from that plist to avoid issues with special characters in name fields

0.2
Updated dscl commands for Active Directory
Changed fullName to "First Last" format
Added Exchange Domain support

0.1
Default script with custom settings

*)

----------------------------------------------------------------------------------------------------------
-- Settings: Edit these for your environment

property domainName : "domain.com" -- example: "domain.com"

property ExchangeServer : "mail.domain.com" -- example: "mail.domain.com"
property ExchangeServerRequiresSSL : true
property ExchangeServerSSLPort : 443 -- if ExchangeServerSSL is true: 443; false: 80

property directoryServer : "ldap.domain.com" -- example: "ldap.domain.com"
property directoryServerRequiresAuth : true
property directoryServerRequiresSSL : false
property directoryServerSSLPort : 3268 -- if directoryServerRequiresSSL is false: 3268; true: 3269
property directoryServerMaximumResults : 6000
property directoryServerSearchBase : "" -- example: "cn=users,dc=domain,dc=com" -- search base will be optional in many environments and its format will vary greatly. Experiment first connecting without entering the search base information.

property dsclDomain : "/Active Directory/DOMAIN/All Domains/" -- The specific domain for use by dscl

property displayName : 1 -- Assuming the name comes from AD as: "Last, First", this may need some tweaking otherwise
-- 1: Display name displays as "Last, First"
-- 2: Display name displays as "First Last"

property mailboxPrefix : "" -- example: "Mailbox - " with displayName set to 2 would name the account "Mailbox - Jane User"
property scheduled : false -- Exchange accounts don't require that the "Send & Receive All" schedule be enabled.
property errorMessage : "Your account may not have set up correctly. Please contact tech support with questions."

-- End settings
----------------------------------------------------------------------------------------------------------

-- User information is pulled from the account settings of the current user's account
tell application "System Events"
	set shortName to name of current user
	set fullName to full name of current user
	-- we need to set full name to be "First Last" a little bit later...
end tell

-- More user info is pulled from the user's AD information and stored in a temporary plist file for easy access
set userInfoPList to "/private/tmp/UserInfo.plist"
do shell script "dscl -plist \"" & dsclDomain & "\" -read /Users/" & shortName & " FirstName LastName EMailAddress > " & userInfoPList
tell application "System Events"
	tell property list file userInfoPList
		tell contents
			set firstName to value of property list item "dsAttrTypeStandard:FirstName"
			set lastName to value of property list item "dsAttrTypeStandard:LastName"
			set emailAddress to value of property list item "dsAttrTypeStandard:EMailAddress"
		end tell
	end tell
end tell

-- use First Last format for full name:
set fullName to firstName & " " & lastName

-- Account setup stage
try
	
	tell application "Microsoft Outlook"
		activate
		set newExchangeAccount to make new exchange account with properties Â
			{name:mailboxPrefix & fullName, user name:ExchangeDomain & shortName, full name:"" & fullName, email address:emailAddress, server:ExchangeServer, use ssl:ExchangeServerRequiresSSL, port:ExchangeServerSSLPort, ldap server:directoryServer, ldap needs authentication:directoryServerRequiresAuthentication, ldap use ssl:directoryServerRequiresSSL, ldap max entries:directoryServerMaximumResults, ldap search base:directoryServerSearchBase}
		
		-- Set the first name, last name and email of the Me Contact record.
		set first name of me contact to firstName
		set last name of me contact to lastName
		set email addresses of me contact to {address:emailAddress, type:work}
		-- Possible enhancement: Add more data fields to the Me Contact.
		
		set enabled of schedule "Send & Receive All" to scheduled
		set working offline to false
		
		-- Wait for user to enter password before continuing with settings changes
		display dialog "Enter account password in Outlook then click to continue." buttons {"Continue"}
		
		-- Additional Settings
		set hide on my computer folders to false -- may not work if account folders have not been created yet.
		set group similar folders to false
		set system default mail application to true
		set system default calendar application to true
		set system default address book application to true
		
	end tell
	
	try
		do shell script "rm " & userInfoPList
	end try
	
on error
	
	display dialog errorMessage with icon 2 buttons {"OK"} default button {"OK"}
	
end try
