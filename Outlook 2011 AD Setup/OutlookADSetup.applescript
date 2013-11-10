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

property domainName : "domain.com"
-- example: "domain.com"

property ExchangeServer : "mail.domain.com"
-- example: "mail.domain.com"

property ExchangeDomain : ""
-- if you need to type a domain and backslash before your login name for the Exchange server.
-- escape the backslash with another:	"DOMAIN\\"

property ExchangeServerRequiresSSL : true

property ExchangeServerSSLPort : 443
-- If ExchangeServerSSL is true set the port to 443
-- If ExchangeServerSSL is false set the port to 80

property directoryServer : "ldap.domain.com"
-- example: "ldap.domain.com"

property directoryServerRequiresAuthentication : true

property directoryServerRequiresSSL : false

property directoryServerSSLPort : 3268
-- If directoryServerRequiresSSL is false set the port to 3268
-- If directoryServerRequiresSSL is true set the port to 3269

property directoryServerMaximumResults : 6000

property directoryServerSearchBase : ""
-- example: "cn=users,dc=domain,dc=com"

-- Search base will be optional in many environments and its
-- format will vary greatly. Experiment first connecting without
-- entering the search base information.

property getUserInfoUsingDSCL : true
-- If the Macs are connected to a directory service such as
-- Active Directory, then they can probably use dscl to return
-- the current user's E-mail address instead of trying to parse it
-- from the display name. 

-- Using dscl is preferred. Otherwise, set this to false
-- and set the next property to the appropriate number.

property dsclDomain : "/Active Directory/DOMAIN/All Domains/"
-- The specific domain for use by dscl

property displayName : 1
-- Assuming the name comes from AD as: "Last, First"
-- This may need some tweaking otherwise
-- 1: Display name displays as "Last, First"
-- 2: Display name displays as "First Last"

property mailboxPrefix : ""
-- Enter a prefix to the mailbox name if desired
-- example: "Mailbox - " with displayName set to 2 would name the account "Mailbox - Jane User"

property scheduled : false
-- Exchange accounts don't require that
-- the "Send & Receive All" schedule be enabled.
-- Change this setting to true if the user
-- will also be connecting to POP or IMAP accounts.

property errorMessage : "Your account may not have set up correctly. Please contact tech support with questions."
-- Customize this error message for your users
-- if their account setup fails

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
