FasdUAS 1.101.10   ��   ��    k             l      ��  ��   qk
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

     � 	 	� 
 T h i s   s c r i p t   w a s   i n s p i r e d   b y   t h e   e x c e l l e n t   O u t l o o k   E x c h a n g e   S e t u p   4 . 0 . 1   b y   W i l l i a m   S m i t h :   b i l l @ o f f i c e f o r m a c h e l p . c o m 
 
 W e   n e e d e d   a   s c r i p t   t h a t   w a s   m o r e   A D   f o c u s e d   t o   p u l l   i n f o r m a t i o n   f r o m   o u r   A D   u s e r   r e c o r d   t h a t   i n c l u d e d   f u n k y   t h i n g s   l i k e   h y p h e n s   a n d   s p a c e s . 
 
 F o r   u s e   o n   O S   X   1 0 . 7   a n d   a b o v e . 
 
 A s   l o n g   a s   t h e   c u r r e n t   u s e r   i s   a   A c t i v e   D i r e c t o r y   u s e r ,   i t   w i l l   c r e a t e 
 a n   n e w   a c c o u n t   e n t r y   i n   O u t l o o k   2 0 1 1   u s i n g   t h a t   i n f o r m a t i o n . 
 
 A   d i a l o g   w i l l   a p p e a r ,   p a u s i n g   t h e   s c r i p t   w h i l e   O u t l o o k   w i l l   a s k   f o r   t h e   a c c o u n t   p a s s w o r d .   C l i c k   c o n t i n u e   a n d   y o u ' r e   d o n e ! 
 
 B E S T   P R A C T I C E   I S   T O   D E L E T E   A N Y   E X I S T I N G   E X C H A N G E   A C C O U N T S   B E F O R E   R U N N I N G . 
 
 C h a n g e l o g : 
 1 . 0 
 I m p r o v e d   d o c u m e n t a t i o n ,   f o r m a t t i n g 
 C l e a n e d   u p 
 
 0 . 4 
 A d d e d   d i a l o g   t o   p a u s e   s c r i p t   w h i l e   u s e r   e n t e r s   p a s s w o r d .   F i x e s   i s s u e   " H i d e   o n   m y   C o m p u t e r "   s e t t i n g   i s s u e 
 C o m m e n t e d   o u t   a   b u n c h   o f   e x t e r a n e o u s   s t u f f 
 
 0 . 3 
 C h a n g e d   d s c l   l o o k u p   t o   u s e   a   t e m o p r a r y   p l i s t   a n d   p u l l   k e y s   f r o m   t h a t   p l i s t   t o   a v o i d   i s s u e s   w i t h   s p e c i a l   c h a r a c t e r s   i n   n a m e   f i e l d s 
 
 0 . 2 
 U p d a t e d   d s c l   c o m m a n d s   f o r   A c t i v e   D i r e c t o r y 
 C h a n g e d   f u l l N a m e   t o   " F i r s t   L a s t "   f o r m a t 
 A d d e d   E x c h a n g e   D o m a i n   s u p p o r t 
 
 0 . 1 
 D e f a u l t   s c r i p t   w i t h   c u s t o m   s e t t i n g s 
 
   
  
 l     ��������  ��  ��        l     ��  ��    n h--------------------------------------------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -      l     ��  ��    0 * Settings: Edit these for your environment     �   T   S e t t i n g s :   E d i t   t h e s e   f o r   y o u r   e n v i r o n m e n t      l     ��������  ��  ��        j     �� �� 0 
domainname 
domainName  m        �    d o m a i n . c o m      l     ��   ��      example: "domain.com"      � ! ! ,   e x a m p l e :   " d o m a i n . c o m "   " # " l     ��������  ��  ��   #  $ % $ j    �� &��  0 exchangeserver ExchangeServer & m     ' ' � ( (  m a i l . d o m a i n . c o m %  ) * ) l     �� + ,��   + !  example: "mail.domain.com"    , � - - 6   e x a m p l e :   " m a i l . d o m a i n . c o m " *  . / . l     ��������  ��  ��   /  0 1 0 j    �� 2��  0 exchangedomain ExchangeDomain 2 m     3 3 � 4 4   1  5 6 5 l     �� 7 8��   7 a [ if you need to type a domain and backslash before your login name for the Exchange server.    8 � 9 9 �   i f   y o u   n e e d   t o   t y p e   a   d o m a i n   a n d   b a c k s l a s h   b e f o r e   y o u r   l o g i n   n a m e   f o r   t h e   E x c h a n g e   s e r v e r . 6  : ; : l     �� < =��   < 4 . escape the backslash with another:	"DOMAIN\\"    = � > > \   e s c a p e   t h e   b a c k s l a s h   w i t h   a n o t h e r : 	 " D O M A I N \ \ " ;  ? @ ? l     ��������  ��  ��   @  A B A j   	 �� C�� 60 exchangeserverrequiresssl ExchangeServerRequiresSSL C m   	 
��
�� boovtrue B  D E D l     ��������  ��  ��   E  F G F j    �� H�� .0 exchangeserversslport ExchangeServerSSLPort H m    ����� G  I J I l     �� K L��   K 7 1 If ExchangeServerSSL is true set the port to 443    L � M M b   I f   E x c h a n g e S e r v e r S S L   i s   t r u e   s e t   t h e   p o r t   t o   4 4 3 J  N O N l     �� P Q��   P 7 1 If ExchangeServerSSL is false set the port to 80    Q � R R b   I f   E x c h a n g e S e r v e r S S L   i s   f a l s e   s e t   t h e   p o r t   t o   8 0 O  S T S l     ��������  ��  ��   T  U V U j    �� W�� "0 directoryserver directoryServer W m     X X � Y Y  l d a p . d o m a i n . c o m V  Z [ Z l     �� \ ]��   \ !  example: "ldap.domain.com"    ] � ^ ^ 6   e x a m p l e :   " l d a p . d o m a i n . c o m " [  _ ` _ l     ��������  ��  ��   `  a b a j    �� c�� N0 %directoryserverrequiresauthentication %directoryServerRequiresAuthentication c m    ��
�� boovtrue b  d e d l     ��������  ��  ��   e  f g f j    �� h�� 80 directoryserverrequiresssl directoryServerRequiresSSL h m    ��
�� boovfals g  i j i l     ��������  ��  ��   j  k l k j    �� m�� 00 directoryserversslport directoryServerSSLPort m m    ����� l  n o n l     �� p q��   p B < If directoryServerRequiresSSL is false set the port to 3268    q � r r x   I f   d i r e c t o r y S e r v e r R e q u i r e s S S L   i s   f a l s e   s e t   t h e   p o r t   t o   3 2 6 8 o  s t s l     �� u v��   u A ; If directoryServerRequiresSSL is true set the port to 3269    v � w w v   I f   d i r e c t o r y S e r v e r R e q u i r e s S S L   i s   t r u e   s e t   t h e   p o r t   t o   3 2 6 9 t  x y x l     ��������  ��  ��   y  z { z j    �� |�� >0 directoryservermaximumresults directoryServerMaximumResults | m    ����p {  } ~ } l     ��������  ��  ��   ~   �  j    "�� ��� 60 directoryserversearchbase directoryServerSearchBase � m    ! � � � � �   �  � � � l     �� � ���   � + % example: "cn=users,dc=domain,dc=com"    � � � � J   e x a m p l e :   " c n = u s e r s , d c = d o m a i n , d c = c o m " �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � @ : Search base will be optional in many environments and its    � � � � t   S e a r c h   b a s e   w i l l   b e   o p t i o n a l   i n   m a n y   e n v i r o n m e n t s   a n d   i t s �  � � � l     �� � ���   � D > format will vary greatly. Experiment first connecting without    � � � � |   f o r m a t   w i l l   v a r y   g r e a t l y .   E x p e r i m e n t   f i r s t   c o n n e c t i n g   w i t h o u t �  � � � l     �� � ���   � , & entering the search base information.    � � � � L   e n t e r i n g   t h e   s e a r c h   b a s e   i n f o r m a t i o n . �  � � � l     ��������  ��  ��   �  � � � j   # %�� ��� ,0 getuserinfousingdscl getUserInfoUsingDSCL � m   # $��
�� boovtrue �  � � � l     �� � ���   � ? 9 If the Macs are connected to a directory service such as    � � � � r   I f   t h e   M a c s   a r e   c o n n e c t e d   t o   a   d i r e c t o r y   s e r v i c e   s u c h   a s �  � � � l     �� � ���   � B < Active Directory, then they can probably use dscl to return    � � � � x   A c t i v e   D i r e c t o r y ,   t h e n   t h e y   c a n   p r o b a b l y   u s e   d s c l   t o   r e t u r n �  � � � l     �� � ���   � F @ the current user's E-mail address instead of trying to parse it    � � � � �   t h e   c u r r e n t   u s e r ' s   E - m a i l   a d d r e s s   i n s t e a d   o f   t r y i n g   t o   p a r s e   i t �  � � � l     �� � ���   �   from the display name.     � � � � 0   f r o m   t h e   d i s p l a y   n a m e .   �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � < 6 Using dscl is preferred. Otherwise, set this to false    � � � � l   U s i n g   d s c l   i s   p r e f e r r e d .   O t h e r w i s e ,   s e t   t h i s   t o   f a l s e �  � � � l     �� � ���   � ; 5 and set the next property to the appropriate number.    � � � � j   a n d   s e t   t h e   n e x t   p r o p e r t y   t o   t h e   a p p r o p r i a t e   n u m b e r . �  � � � l     ��������  ��  ��   �  � � � j   & *�� ��� 0 
dscldomain 
dsclDomain � m   & ) � � � � � J / A c t i v e   D i r e c t o r y / D O M A I N / A l l   D o m a i n s / �  � � � l     �� � ���   � * $ The specific domain for use by dscl    � � � � H   T h e   s p e c i f i c   d o m a i n   f o r   u s e   b y   d s c l �  � � � l     ��������  ��  ��   �  � � � j   + -�� ��� 0 displayname displayName � m   + ,����  �  � � � l     �� � ���   � 8 2 Assuming the name comes from AD as: "Last, First"    � � � � d   A s s u m i n g   t h e   n a m e   c o m e s   f r o m   A D   a s :   " L a s t ,   F i r s t " �  � � � l     �� � ���   � , & This may need some tweaking otherwise    � � � � L   T h i s   m a y   n e e d   s o m e   t w e a k i n g   o t h e r w i s e �  � � � l     �� � ���   � 0 * 1: Display name displays as "Last, First"    � � � � T   1 :   D i s p l a y   n a m e   d i s p l a y s   a s   " L a s t ,   F i r s t " �  � � � l     �� � ���   � / ) 2: Display name displays as "First Last"    � � � � R   2 :   D i s p l a y   n a m e   d i s p l a y s   a s   " F i r s t   L a s t " �  � � � l     ��������  ��  ��   �  � � � j   . 2�� ��� 0 mailboxprefix mailboxPrefix � m   . 1 � � � � �   �  � � � l     �� � ���   � 4 . Enter a prefix to the mailbox name if desired    � � � � \   E n t e r   a   p r e f i x   t o   t h e   m a i l b o x   n a m e   i f   d e s i r e d �  � � � l     �� � ���   � c ] example: "Mailbox - " with displayName set to 2 would name the account "Mailbox - Jane User"    � � � � �   e x a m p l e :   " M a i l b o x   -   "   w i t h   d i s p l a y N a m e   s e t   t o   2   w o u l d   n a m e   t h e   a c c o u n t   " M a i l b o x   -   J a n e   U s e r " �  � � � l     ��������  ��  ��   �  � � � j   3 5�� ��� 0 	scheduled   � m   3 4��
�� boovfals �  � � � l     �� � ���   � + % Exchange accounts don't require that    � � � � J   E x c h a n g e   a c c o u n t s   d o n ' t   r e q u i r e   t h a t �  �  � l     ����   4 . the "Send & Receive All" schedule be enabled.    � \   t h e   " S e n d   &   R e c e i v e   A l l "   s c h e d u l e   b e   e n a b l e d .   l     ����   . ( Change this setting to true if the user    � P   C h a n g e   t h i s   s e t t i n g   t o   t r u e   i f   t h e   u s e r 	
	 l     ����   7 1 will also be connecting to POP or IMAP accounts.    � b   w i l l   a l s o   b e   c o n n e c t i n g   t o   P O P   o r   I M A P   a c c o u n t s .
  l     ��������  ��  ��    j   6 <���� 0 errormessage errorMessage m   6 9 � � Y o u r   a c c o u n t   m a y   n o t   h a v e   s e t   u p   c o r r e c t l y .   P l e a s e   c o n t a c t   t e c h   s u p p o r t   w i t h   q u e s t i o n s .  l     ����   2 , Customize this error message for your users    � X   C u s t o m i z e   t h i s   e r r o r   m e s s a g e   f o r   y o u r   u s e r s  l     ����   #  if their account setup fails    � :   i f   t h e i r   a c c o u n t   s e t u p   f a i l s   l     ��������  ��  ��    !"! l     ��#$��  #   End settings   $ �%%    E n d   s e t t i n g s" &'& l     ��()��  ( n h--------------------------------------------------------------------------------------------------------   ) �** � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' +,+ l     ����~��  �  �~  , -.- l     �}/0�}  / Y S User information is pulled from the account settings of the current user's account   0 �11 �   U s e r   i n f o r m a t i o n   i s   p u l l e d   f r o m   t h e   a c c o u n t   s e t t i n g s   o f   t h e   c u r r e n t   u s e r ' s   a c c o u n t. 232 l    4�|�{4 O     565 k    77 898 r    :;: n    	<=< 1    	�z
�z 
pnam= 1    �y
�y 
curu; o      �x�x 0 	shortname 	shortName9 >?> r    @A@ n    BCB 1    �w
�w 
fnamC 1    �v
�v 
curuA o      �u�u 0 fullname fullName? D�tD l   �sEF�s  E H B we need to set full name to be "First Last" a little bit later...   F �GG �   w e   n e e d   t o   s e t   f u l l   n a m e   t o   b e   " F i r s t   L a s t "   a   l i t t l e   b i t   l a t e r . . .�t  6 m     HH�                                                                                  sevs  alis    �  Macintosh HD               Π�H+     MSystem Events.app                                               7*���        ����  	                CoreServices    Πi3      ��`�       M   G   F  =Macintosh HD:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  �|  �{  3 IJI l     �r�q�p�r  �q  �p  J KLK l     �oMN�o  M s m More user info is pulled from the user's AD information and stored in a temporary plist file for easy access   N �OO �   M o r e   u s e r   i n f o   i s   p u l l e d   f r o m   t h e   u s e r ' s   A D   i n f o r m a t i o n   a n d   s t o r e d   i n   a   t e m p o r a r y   p l i s t   f i l e   f o r   e a s y   a c c e s sL PQP l   R�n�mR r    STS m    UU �VV 6 / p r i v a t e / t m p / U s e r I n f o . p l i s tT o      �l�l 0 userinfoplist userInfoPList�n  �m  Q WXW l   .Y�k�jY I   .�iZ�h
�i .sysoexecTEXT���     TEXTZ b    *[\[ b    (]^] b    &_`_ b    $aba b    "cdc m    ee �ff  d s c l   - p l i s t   "d o    !�g�g 0 
dscldomain 
dsclDomainb m   " #gg �hh  "   - r e a d   / U s e r s /` o   $ %�f�f 0 	shortname 	shortName^ m   & 'ii �jj F   F i r s t N a m e   L a s t N a m e   E M a i l A d d r e s s   >  \ o   ( )�e�e 0 userinfoplist userInfoPList�h  �k  �j  X klk l  / mm�d�cm O   / mnon O   3 lpqp O   : krsr k   @ jtt uvu r   @ Lwxw n   @ Hyzy 1   D H�b
�b 
valLz 4   @ D�a{
�a 
plii{ m   B C|| �}} 8 d s A t t r T y p e S t a n d a r d : F i r s t N a m ex o      �`�` 0 	firstname 	firstNamev ~~ r   M [��� n   M W��� 1   S W�_
�_ 
valL� 4   M S�^�
�^ 
plii� m   O R�� ��� 6 d s A t t r T y p e S t a n d a r d : L a s t N a m e� o      �]�] 0 lastname lastName ��\� r   \ j��� n   \ f��� 1   b f�[
�[ 
valL� 4   \ b�Z�
�Z 
plii� m   ^ a�� ��� > d s A t t r T y p e S t a n d a r d : E M a i l A d d r e s s� o      �Y�Y 0 emailaddress emailAddress�\  s 1   : =�X
�X 
pcntq 4   3 7�W�
�W 
plif� o   5 6�V�V 0 userinfoplist userInfoPListo m   / 0���                                                                                  sevs  alis    �  Macintosh HD               Π�H+     MSystem Events.app                                               7*���        ����  	                CoreServices    Πi3      ��`�       M   G   F  =Macintosh HD:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  �d  �c  l ��� l     �U�T�S�U  �T  �S  � ��� l     �R���R  � + % use First Last format for full name:   � ��� J   u s e   F i r s t   L a s t   f o r m a t   f o r   f u l l   n a m e :� ��� l  n {��Q�P� r   n {��� b   n y��� b   n u��� o   n q�O�O 0 	firstname 	firstName� m   q t�� ���   � o   u x�N�N 0 lastname lastName� o      �M�M 0 fullname fullName�Q  �P  � ��� l     �L�K�J�L  �K  �J  � ��� l     �I���I  �   Account setup stage   � ��� (   A c c o u n t   s e t u p   s t a g e� ��� l  |���H�G� Q   |����� k   ��� ��� l   �F�E�D�F  �E  �D  � ��� O   ���� k   ���� ��� I  � ��C�B�A
�C .miscactvnull��� ��� null�B  �A  � ��� r   ���� I  � ��@�?�
�@ .corecrel****      � null�?  � �>��
�> 
kocl� m   � ��=
�= 
Eact� �<��;
�< 
prdt� l 	 � ���:�9� K   � ��� �8��
�8 
pnam� b   � ���� o   � ��7�7 0 mailboxprefix mailboxPrefix� o   � ��6�6 0 fullname fullName� �5��
�5 
unme� b   � ���� o   � ��4�4  0 exchangedomain ExchangeDomain� o   � ��3�3 0 	shortname 	shortName� �2��
�2 
fnam� b   � ���� m   � ��� ���  � o   � ��1�1 0 fullname fullName� �0��
�0 
emad� o   � ��/�/ 0 emailaddress emailAddress� �.��
�. 
host� o   � ��-�-  0 exchangeserver ExchangeServer� �,��
�, 
usss� o   � ��+�+ 60 exchangeserverrequiresssl ExchangeServerRequiresSSL� �*��
�* 
port� o   � ��)�) .0 exchangeserversslport ExchangeServerSSLPort� �(��
�( 
ExLS� o   � ��'�' "0 directoryserver directoryServer� �&��
�& 
LDAu� o   � ��%�% N0 %directoryserverrequiresauthentication %directoryServerRequiresAuthentication� �$��
�$ 
LDSL� o   � ��#�# 80 directoryserverrequiresssl directoryServerRequiresSSL� �"��
�" 
LDMX� o   � ��!�! >0 directoryservermaximumresults directoryServerMaximumResults� � ��
�  
LDSB� o   � ��� 60 directoryserversearchbase directoryServerSearchBase�  �:  �9  �;  � o      �� (0 newexchangeaccount newExchangeAccount� ��� l ����  �  �  � ��� l ����  � H B Set the first name, last name and email of the Me Contact record.   � ��� �   S e t   t h e   f i r s t   n a m e ,   l a s t   n a m e   a n d   e m a i l   o f   t h e   M e   C o n t a c t   r e c o r d .� ��� r  ��� o  �� 0 	firstname 	firstName� n      ��� 1  
�
� 
pFrN� 1  
�
� 
meCn� ��� r  ��� o  �� 0 lastname lastName� n      ��� 1  �
� 
pLsN� 1  �
� 
meCn� ��� r  8��� K  .�� ���
� 
radd� o  !$�� 0 emailaddress emailAddress� ���
� 
type� m  '*�
� EATyeWrk�  � n      ��� 1  37�
� 
EmAd� 1  .3�
� 
meCn�    l 99��   D > Possible enhancement: Add more data fields to the Me Contact.    � |   P o s s i b l e   e n h a n c e m e n t :   A d d   m o r e   d a t a   f i e l d s   t o   t h e   M e   C o n t a c t .  l 99�
�	��
  �	  �    r  9K	
	 o  9>�� 0 	scheduled  
 n       1  FJ�
� 
ScEn 4  >F�
� 
cSch m  BE � $ S e n d   &   R e c e i v e   A l l  r  LS m  LM�
� boovfals 1  MR�
� 
wkOf  l TT��� �  �  �     l TT����   N H Wait for user to enter password before continuing with settings changes    � �   W a i t   f o r   u s e r   t o   e n t e r   p a s s w o r d   b e f o r e   c o n t i n u i n g   w i t h   s e t t i n g s   c h a n g e s  I Tc��
�� .sysodlogaskr        TEXT m  TW �   r E n t e r   a c c o u n t   p a s s w o r d   i n   O u t l o o k   t h e n   c l i c k   t o   c o n t i n u e . ��!��
�� 
btns! J  Z_"" #��# m  Z]$$ �%%  C o n t i n u e��  ��   &'& l dd��������  ��  ��  ' ()( l dd��*+��  *   Additional Settings   + �,, (   A d d i t i o n a l   S e t t i n g s) -.- l dk/01/ r  dk232 m  de��
�� boovfals3 1  ej��
�� 
hOMC0 A ; may not work if account folders have not been created yet.   1 �44 v   m a y   n o t   w o r k   i f   a c c o u n t   f o l d e r s   h a v e   n o t   b e e n   c r e a t e d   y e t .. 565 r  ls787 m  lm��
�� boovfals8 1  mr��
�� 
GrpF6 9:9 r  t{;<; m  tu��
�� boovtrue< 1  uz��
�� 
pMSD: =>= r  |�?@? m  |}��
�� boovtrue@ 1  }���
�� 
pCSD> ABA r  ��CDC m  ����
�� boovtrueD 1  ����
�� 
pABDB E��E l ����������  ��  ��  ��  � m    �FF                                                                                  OPIM  alis    �  Macintosh HD               Π�H+   	�JMicrosoft Outlook.app                                           	��/ǹ        ����  	                Microsoft Office 2011     Πi3      �0	     	�J   j  GMacintosh HD:Applications: Microsoft Office 2011: Microsoft Outlook.app   ,  M i c r o s o f t   O u t l o o k . a p p    M a c i n t o s h   H D  8Applications/Microsoft Office 2011/Microsoft Outlook.app  / ��  � GHG l ����������  ��  ��  H IJI Q  ��KL��K I ����M��
�� .sysoexecTEXT���     TEXTM b  ��NON m  ��PP �QQ  r m  O o  ������ 0 userinfoplist userInfoPList��  L R      ������
�� .ascrerr ****      � ****��  ��  ��  J R��R l ����������  ��  ��  ��  � R      ������
�� .ascrerr ****      � ****��  ��  � k  ��SS TUT l ����������  ��  ��  U VWV I ����XY
�� .sysodlogaskr        TEXTX o  ������ 0 errormessage errorMessageY ��Z[
�� 
dispZ m  ������ [ ��\]
�� 
btns\ J  ��^^ _��_ m  ��`` �aa  O K��  ] ��b��
�� 
dfltb J  ��cc d��d m  ��ee �ff  O K��  ��  W g��g l ����������  ��  ��  ��  �H  �G  � h��h l     ��������  ��  ��  ��       ��i  ' 3���� X�������� ��� ��� ���j��  i �������������������������������������� 0 
domainname 
domainName��  0 exchangeserver ExchangeServer��  0 exchangedomain ExchangeDomain�� 60 exchangeserverrequiresssl ExchangeServerRequiresSSL�� .0 exchangeserversslport ExchangeServerSSLPort�� "0 directoryserver directoryServer�� N0 %directoryserverrequiresauthentication %directoryServerRequiresAuthentication�� 80 directoryserverrequiresssl directoryServerRequiresSSL�� 00 directoryserversslport directoryServerSSLPort�� >0 directoryservermaximumresults directoryServerMaximumResults�� 60 directoryserversearchbase directoryServerSearchBase�� ,0 getuserinfousingdscl getUserInfoUsingDSCL�� 0 
dscldomain 
dsclDomain�� 0 displayname displayName�� 0 mailboxprefix mailboxPrefix�� 0 	scheduled  �� 0 errormessage errorMessage
�� .aevtoappnull  �   � ****
�� boovtrue���
�� boovtrue
�� boovfals�����p
�� boovtrue�� 
�� boovfalsj ��k����lm��
�� .aevtoappnull  �   � ****k k    �nn 2oo Ppp Wqq krr �ss �����  ��  ��  l  m GH����������U��egi��������|�����������F���������������������������������������������~�}�|�{�z�y�x$�w�v�u�t�s�rP�q�p�o`�ne�m
�� 
curu
�� 
pnam�� 0 	shortname 	shortName
�� 
fnam�� 0 fullname fullName�� 0 userinfoplist userInfoPList
�� .sysoexecTEXT���     TEXT
�� 
plif
�� 
pcnt
�� 
plii
�� 
valL�� 0 	firstname 	firstName�� 0 lastname lastName�� 0 emailaddress emailAddress
�� .miscactvnull��� ��� null
�� 
kocl
�� 
Eact
�� 
prdt
�� 
unme
�� 
emad
�� 
host
�� 
usss
�� 
port
�� 
ExLS
�� 
LDAu
�� 
LDSL
�� 
LDMX
�� 
LDSB�� �� 
�� .corecrel****      � null�� (0 newexchangeaccount newExchangeAccount
�� 
meCn
�� 
pFrN
�� 
pLsN
� 
radd
�~ 
type
�} EATyeWrk
�| 
EmAd
�{ 
cSch
�z 
ScEn
�y 
wkOf
�x 
btns
�w .sysodlogaskr        TEXT
�v 
hOMC
�u 
GrpF
�t 
pMSD
�s 
pCSD
�r 
pABD�q  �p  
�o 
disp
�n 
dflt�m ���� *�,�,E�O*�,�,E�OPUO�E�O�b  %�%�%�%�%j O� ;*��/ 3*�, ,*��/a ,E` O*�a /a ,E` O*�a /a ,E` UUUO_ a %_ %E�O,a 
*j O*a a a �b  �%a b  �%�a �%a _ a b  a  b  a !b  a "b  a #b  a $b  a %b  	a &b  
a 'a ( )E` *O_ *a +,a ,,FO_ *a +,a -,FOa ._ a /a 0a (*a +,a 1,FOb  *a 2a 3/a 4,FOf*a 5,FOa 6a 7a 8kvl 9Of*a :,FOf*a ;,FOe*a <,FOe*a =,FOe*a >,FOPUO a ?�%j W X @ AhOPW (X @ Ab  a Bla 7a Ckva Da Ekva F 9OP ascr  ��ޭ