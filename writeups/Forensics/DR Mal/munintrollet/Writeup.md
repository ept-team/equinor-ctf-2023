By Oslolosen

This was a really cool challenge. Finally, a VBA challenge where you don't have to spend 100 hours trying to deobfuscate the VBA code.

We received a zip file that contained a .doc file. The initial reaction was that this was an Office file with some malicious VBA code. So, the first step was to use oletools, more precisely, olevba.
![[ole_vba.png]]

Here we saw some VBA code that creates a request to download a file from the URL defined in the snoopDogg variable. Then we thought we just needed to obtain that .msi file, and we probably had the flag, but on the website, we were faced with an invalid user agent.
![[invalid_useragent.png]]

After some digging around to find the office user agent we could not find the right one, but we got an idea. Lets just seperate we VBA code on an own VBA file, then set up a simple pyhton http web server and track the traffic with WireShark. That way we could find the packet and copy the user agent.  
![[valid_useragent.png]]
In the packet, it states Windows Installer as the user agent. Then, we simply changed the user agent with Burp and got the flag.

##### Flag: `EPT{mAlD0c_c0mIn_sTr4igHt_0utt4_jAEr3n}`
