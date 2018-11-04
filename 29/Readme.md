1. Роль качает несуществующие исходники. Поправил.
2. Зоипер в бесплатной версии не разрешает тлс. Поправил конфиг pjsip на
```
[transport-udp]
type=transport
protocol=udp
bind=0.0.0.0
```

В базе в ps_endpoints поменял протокол на transport-udp. Убрал все кодеки, кроме G722. Так как иначе вылетала 488.

После этих манипуляция наконец пошел прозвон

```

<--- Received SIP request (897 bytes) from UDP:192.168.100.11:54069 --->
REGISTER sip:192.168.100.10:5060;transport=UDP SIP/2.0
Via: SIP/2.0/UDP 192.168.100.11:54069;branch=z9hG4bK-524287-1---418874abc2af6515;rport
Max-Forwards: 70
Contact: <sip:1101@192.168.100.11:54069;rinstance=f64697083f6591db;transport=UDP>
To: <sip:1101@192.168.100.10:5060;transport=UDP>
From: <sip:1101@192.168.100.10:5060;transport=UDP>;tag=3e2a8956
Call-ID: q_9YrMG1zXmEvXqVIuALxw..
CSeq: 46 REGISTER
Expires: 30
Allow: INVITE, ACK, CANCEL, BYE, NOTIFY, REFER, MESSAGE, OPTIONS, INFO, SUBSCRIBE
User-Agent: Z 5.2.19 rv2.8.99
Authorization: Digest username="1101",realm="asterisk",nonce="1541329981/c13f0eef46bf9a5280fa37f76ace69be",uri="sip:192.168.100.10:5060;transport=UDP",response="cc7e4c5406cef0783b7d5b93a97313b2",cnonce="de5d15d7469261c9cb71f6c609bf3265",nc=00000001,qop=auth,algorithm=md5,opaque="51ad96470961707f"
Allow-Events: presence, kpml, talk
Content-Length: 0


<--- Transmitting SIP response (486 bytes) to UDP:192.168.100.11:54069 --->
SIP/2.0 200 OK
Via: SIP/2.0/UDP 192.168.100.11:54069;rport=54069;received=192.168.100.11;branch=z9hG4bK-524287-1---418874abc2af6515
Call-ID: q_9YrMG1zXmEvXqVIuALxw..
From: <sip:1101@192.168.100.10>;tag=3e2a8956
To: <sip:1101@192.168.100.10>;tag=z9hG4bK-524287-1---418874abc2af6515
CSeq: 46 REGISTER
Date: Sun, 04 Nov 2018 11:13:01 GMT
Contact: <sip:1101@192.168.100.11:54069;rinstance=f64697083f6591db>;expires=59
Expires: 60
Server: Asterisk PBX 15.6.1
Content-Length:  0


<--- Received SIP request (700 bytes) from UDP:192.168.100.11:54069 --->
INVITE sip:1102@192.168.100.10:5060;transport=UDP SIP/2.0
Via: SIP/2.0/UDP 192.168.100.11:54069;branch=z9hG4bK-524287-1---5d247dfae35c6a07;rport
Max-Forwards: 70
Contact: <sip:1101@192.168.100.11:54069;transport=UDP>
To: <sip:1102@192.168.100.10:5060;transport=UDP>
From: <sip:1101@192.168.100.10:5060;transport=UDP>;tag=70578e12
Call-ID: SphBTlUwKgmR_W0glZrJZQ..
CSeq: 1 INVITE
Allow: INVITE, ACK, CANCEL, BYE, NOTIFY, REFER, MESSAGE, OPTIONS, INFO, SUBSCRIBE
Content-Type: application/sdp
User-Agent: Z 5.2.19 rv2.8.99
Allow-Events: presence, kpml, talk
Content-Length: 109

v=0
o=Z 0 0 IN IP4 192.168.100.11
s=Z
c=IN IP4 192.168.100.11
t=0 0
m=audio 8000 RTP/AVP 9
a=sendrecv

<--- Transmitting SIP response (510 bytes) to UDP:192.168.100.11:54069 --->
SIP/2.0 401 Unauthorized
Via: SIP/2.0/UDP 192.168.100.11:54069;rport=54069;received=192.168.100.11;branch=z9hG4bK-524287-1---5d247dfae35c6a07
Call-ID: SphBTlUwKgmR_W0glZrJZQ..
From: <sip:1101@192.168.100.10>;tag=70578e12
To: <sip:1102@192.168.100.10>;tag=z9hG4bK-524287-1---5d247dfae35c6a07
CSeq: 1 INVITE
WWW-Authenticate: Digest  realm="asterisk",nonce="1541329982/97eba7a1aa8bfdea720a90f5e4f076d1",opaque="4e73d1de56e180d4",algorithm=md5,qop="auth"
Server: Asterisk PBX 15.6.1
Content-Length:  0


<--- Received SIP request (367 bytes) from UDP:192.168.100.11:54069 --->
ACK sip:1102@192.168.100.10:5060;transport=UDP SIP/2.0
Via: SIP/2.0/UDP 192.168.100.11:54069;branch=z9hG4bK-524287-1---5d247dfae35c6a07;rport
Max-Forwards: 70
To: <sip:1102@192.168.100.10>;tag=z9hG4bK-524287-1---5d247dfae35c6a07
From: <sip:1101@192.168.100.10:5060;transport=UDP>;tag=70578e12
Call-ID: SphBTlUwKgmR_W0glZrJZQ..
CSeq: 1 ACK
Content-Length: 0


<--- Received SIP request (1004 bytes) from UDP:192.168.100.11:54069 --->
INVITE sip:1102@192.168.100.10:5060;transport=UDP SIP/2.0
Via: SIP/2.0/UDP 192.168.100.11:54069;branch=z9hG4bK-524287-1---3644c018964c9490;rport
Max-Forwards: 70
Contact: <sip:1101@192.168.100.11:54069;transport=UDP>
To: <sip:1102@192.168.100.10:5060;transport=UDP>
From: <sip:1101@192.168.100.10:5060;transport=UDP>;tag=70578e12
Call-ID: SphBTlUwKgmR_W0glZrJZQ..
CSeq: 2 INVITE
Allow: INVITE, ACK, CANCEL, BYE, NOTIFY, REFER, MESSAGE, OPTIONS, INFO, SUBSCRIBE
Content-Type: application/sdp
User-Agent: Z 5.2.19 rv2.8.99
Authorization: Digest username="1101",realm="asterisk",nonce="1541329982/97eba7a1aa8bfdea720a90f5e4f076d1",uri="sip:1102@192.168.100.10:5060;transport=UDP",response="af9af4fe86ef4a17c33a5e43575be70f",cnonce="33c087b63e55c746b59f68c95820d13f",nc=00000001,qop=auth,algorithm=md5,opaque="4e73d1de56e180d4"
Allow-Events: presence, kpml, talk
Content-Length: 109

v=0
o=Z 0 0 IN IP4 192.168.100.11
s=Z
c=IN IP4 192.168.100.11
t=0 0
m=audio 8000 RTP/AVP 9
a=sendrecv

  == Setting global variable 'SIPDOMAIN' to '192.168.100.10'
<--- Transmitting SIP response (317 bytes) to UDP:192.168.100.11:54069 --->
SIP/2.0 100 Trying
Via: SIP/2.0/UDP 192.168.100.11:54069;rport=54069;received=192.168.100.11;branch=z9hG4bK-524287-1---3644c018964c9490
Call-ID: SphBTlUwKgmR_W0glZrJZQ..
From: <sip:1101@192.168.100.10>;tag=70578e12
To: <sip:1102@192.168.100.10>
CSeq: 2 INVITE
Server: Asterisk PBX 15.6.1
Content-Length:  0


    -- Executing [1102@default:1] Dial("PJSIP/1101-00000006", "PJSIP/1102") in new stack
    -- Called PJSIP/1102
<--- Transmitting SIP request (950 bytes) to UDP:192.168.100.10:35682 --->
INVITE sip:1102@192.168.100.10:35682;rinstance=337737f4f2889ea8 SIP/2.0
Via: SIP/2.0/UDP 192.168.100.10:5060;rport;branch=z9hG4bKPje25a6607-ee3e-431d-84ef-4bea71b73670
From: <sip:1101@10.0.2.15>;tag=096c61ee-0a03-4a79-adfa-36429ff2ad06
To: <sip:1102@192.168.100.10;rinstance=337737f4f2889ea8>
Contact: <sip:asterisk@192.168.100.10:5060>
Call-ID: 40984dec-06ee-438d-91e2-72dc6d0e361a
CSeq: 2448 INVITE
Allow: OPTIONS, SUBSCRIBE, NOTIFY, PUBLISH, INVITE, ACK, BYE, CANCEL, UPDATE, PRACK, REGISTER, MESSAGE, REFER
Supported: 100rel, timer, replaces, norefersub
Session-Expires: 1800
Min-SE: 90
Max-Forwards: 70
User-Agent: Asterisk PBX 15.6.1
Content-Type: application/sdp
Content-Length:   241

v=0
o=- 1097166238 1097166238 IN IP4 192.168.100.10
s=Asterisk
c=IN IP4 192.168.100.10
t=0 0
m=audio 27470 RTP/AVP 9 101
a=rtpmap:9 G722/8000
a=rtpmap:101 telephone-event/8000
a=fmtp:101 0-16
a=ptime:20
a=maxptime:150
a=sendrecv

<--- Received SIP response (336 bytes) from UDP:192.168.100.10:35682 --->
SIP/2.0 100 Trying
Via: SIP/2.0/UDP 192.168.100.10:5060;rport=5060;branch=z9hG4bKPje25a6607-ee3e-431d-84ef-4bea71b73670
To: <sip:1102@192.168.100.10;rinstance=337737f4f2889ea8>
From: <sip:1101@10.0.2.15>;tag=096c61ee-0a03-4a79-adfa-36429ff2ad06
Call-ID: 40984dec-06ee-438d-91e2-72dc6d0e361a
CSeq: 2448 INVITE
Content-Length: 0


<--- Received SIP response (542 bytes) from UDP:192.168.100.10:35682 --->
SIP/2.0 180 Ringing
Via: SIP/2.0/UDP 192.168.100.10:5060;rport=5060;branch=z9hG4bKPje25a6607-ee3e-431d-84ef-4bea71b73670
Contact: <sip:1102@192.168.100.10:35682>
To: <sip:1102@192.168.100.10;rinstance=337737f4f2889ea8>;tag=ff7abd7c
From: <sip:1101@10.0.2.15>;tag=096c61ee-0a03-4a79-adfa-36429ff2ad06
Call-ID: 40984dec-06ee-438d-91e2-72dc6d0e361a
CSeq: 2448 INVITE
Allow: INVITE, ACK, CANCEL, BYE, NOTIFY, REFER, MESSAGE, OPTIONS, INFO, SUBSCRIBE
User-Agent: Z 5.2.19 rv2.8.99
Allow-Events: presence, kpml, talk
Content-Length: 0


    -- PJSIP/1102-00000007 is ringing
    -- PJSIP/1102-00000007 is ringing
<--- Transmitting SIP response (506 bytes) to UDP:192.168.100.11:54069 --->
SIP/2.0 180 Ringing
Via: SIP/2.0/UDP 192.168.100.11:54069;rport=54069;received=192.168.100.11;branch=z9hG4bK-524287-1---3644c018964c9490
Call-ID: SphBTlUwKgmR_W0glZrJZQ..
From: <sip:1101@192.168.100.10>;tag=70578e12
To: <sip:1102@192.168.100.10>;tag=c095ef7c-df52-4402-9f27-d6375dfdf79d
CSeq: 2 INVITE
Server: Asterisk PBX 15.6.1
Contact: <sip:192.168.100.10:5060>
Allow: OPTIONS, SUBSCRIBE, NOTIFY, PUBLISH, INVITE, ACK, BYE, CANCEL, UPDATE, PRACK, REGISTER, MESSAGE, REFER
Content-Length:  0


<--- Received SIP request (897 bytes) from UDP:192.168.100.10:35682 --->
REGISTER sip:192.168.100.10:5060;transport=UDP SIP/2.0
Via: SIP/2.0/UDP 192.168.100.10:35682;branch=z9hG4bK-524287-1---45f127da523de9bc;rport
Max-Forwards: 70
Contact: <sip:1102@192.168.100.10:35682;rinstance=337737f4f2889ea8;transport=UDP>
To: <sip:1102@192.168.100.10:5060;transport=UDP>
From: <sip:1102@192.168.100.10:5060;transport=UDP>;tag=63dd660a
Call-ID: rSgeyzyjtNn0wjZ3mqUPhA..
CSeq: 39 REGISTER
Expires: 30
Allow: INVITE, ACK, CANCEL, BYE, NOTIFY, REFER, MESSAGE, OPTIONS, INFO, SUBSCRIBE
User-Agent: Z 5.2.19 rv2.8.99
Authorization: Digest username="1102",realm="asterisk",nonce="1541329932/f47ab0bfb85c0afd0dc57b8fadadafad",uri="sip:192.168.100.10:5060;transport=UDP",response="a692de067321f2c5e432d8283a7cd94d",cnonce="0ccc4d11e016c6574d2e6bd417a091ba",nc=00000002,qop=auth,algorithm=md5,opaque="310d76af1d3dfcb2"
Allow-Events: presence, kpml, talk
Content-Length: 0


<--- Transmitting SIP response (524 bytes) to UDP:192.168.100.10:35682 --->
SIP/2.0 401 Unauthorized
Via: SIP/2.0/UDP 192.168.100.10:35682;rport=35682;received=192.168.100.10;branch=z9hG4bK-524287-1---45f127da523de9bc
Call-ID: rSgeyzyjtNn0wjZ3mqUPhA..
From: <sip:1102@192.168.100.10>;tag=63dd660a
To: <sip:1102@192.168.100.10>;tag=z9hG4bK-524287-1---45f127da523de9bc
CSeq: 39 REGISTER
WWW-Authenticate: Digest  realm="asterisk",nonce="1541329985/27023fc3703631f2d8d8c10105aba2b9",opaque="61c7383c1db23056",stale=true,algorithm=md5,qop="auth"
Server: Asterisk PBX 15.6.1
Content-Length:  0


<--- Received SIP request (897 bytes) from UDP:192.168.100.10:35682 --->
REGISTER sip:192.168.100.10:5060;transport=UDP SIP/2.0
Via: SIP/2.0/UDP 192.168.100.10:35682;branch=z9hG4bK-524287-1---80b8978767b33496;rport
Max-Forwards: 70
Contact: <sip:1102@192.168.100.10:35682;rinstance=337737f4f2889ea8;transport=UDP>
To: <sip:1102@192.168.100.10:5060;transport=UDP>
From: <sip:1102@192.168.100.10:5060;transport=UDP>;tag=63dd660a
Call-ID: rSgeyzyjtNn0wjZ3mqUPhA..
CSeq: 40 REGISTER
Expires: 30
Allow: INVITE, ACK, CANCEL, BYE, NOTIFY, REFER, MESSAGE, OPTIONS, INFO, SUBSCRIBE
User-Agent: Z 5.2.19 rv2.8.99
Authorization: Digest username="1102",realm="asterisk",nonce="1541329985/27023fc3703631f2d8d8c10105aba2b9",uri="sip:192.168.100.10:5060;transport=UDP",response="85c9ffce65b15239c21546fed5aa32ad",cnonce="d364206a476581e0a8f6ee1af43c4798",nc=00000001,qop=auth,algorithm=md5,opaque="61c7383c1db23056"
Allow-Events: presence, kpml, talk
Content-Length: 0


<--- Transmitting SIP response (486 bytes) to UDP:192.168.100.10:35682 --->
SIP/2.0 200 OK
Via: SIP/2.0/UDP 192.168.100.10:35682;rport=35682;received=192.168.100.10;branch=z9hG4bK-524287-1---80b8978767b33496
Call-ID: rSgeyzyjtNn0wjZ3mqUPhA..
From: <sip:1102@192.168.100.10>;tag=63dd660a
To: <sip:1102@192.168.100.10>;tag=z9hG4bK-524287-1---80b8978767b33496
CSeq: 40 REGISTER
Date: Sun, 04 Nov 2018 11:13:05 GMT
Contact: <sip:1102@192.168.100.10:35682;rinstance=337737f4f2889ea8>;expires=59
Expires: 60
Server: Asterisk PBX 15.6.1
Content-Length:  0


<--- Received SIP response (744 bytes) from UDP:192.168.100.10:35682 --->
SIP/2.0 200 OK
Via: SIP/2.0/UDP 192.168.100.10:5060;rport=5060;branch=z9hG4bKPje25a6607-ee3e-431d-84ef-4bea71b73670
Require: timer
Contact: <sip:1102@192.168.100.10:35682>
To: <sip:1102@192.168.100.10;rinstance=337737f4f2889ea8>;tag=ff7abd7c
From: <sip:1101@10.0.2.15>;tag=096c61ee-0a03-4a79-adfa-36429ff2ad06
Call-ID: 40984dec-06ee-438d-91e2-72dc6d0e361a
CSeq: 2448 INVITE
Session-Expires: 1800;refresher=uac
Min-SE: 90
Allow: INVITE, ACK, CANCEL, BYE, NOTIFY, REFER, MESSAGE, OPTIONS, INFO, SUBSCRIBE
Content-Type: application/sdp
User-Agent: Z 5.2.19 rv2.8.99
Allow-Events: presence, kpml, talk
Content-Length: 109

v=0
o=Z 0 1 IN IP4 192.168.100.10
s=Z
c=IN IP4 192.168.100.10
t=0 0
m=audio 8000 RTP/AVP 9
a=sendrecv

       > 0x7f315c041550 -- Strict RTP learning after remote address set to: 192.168.100.10:8000
<--- Transmitting SIP request (416 bytes) to UDP:192.168.100.10:35682 --->
ACK sip:1102@192.168.100.10:35682 SIP/2.0
Via: SIP/2.0/UDP 192.168.100.10:5060;rport;branch=z9hG4bKPj44fcdc67-7bb6-432f-9ffd-1cae69ca0402
From: <sip:1101@10.0.2.15>;tag=096c61ee-0a03-4a79-adfa-36429ff2ad06
To: <sip:1102@192.168.100.10;rinstance=337737f4f2889ea8>;tag=ff7abd7c
Call-ID: 40984dec-06ee-438d-91e2-72dc6d0e361a
CSeq: 2448 ACK
Max-Forwards: 70
User-Agent: Asterisk PBX 15.6.1
Content-Length:  0


    -- PJSIP/1102-00000007 answered PJSIP/1101-00000006
       > 0x7f315c03b970 -- Strict RTP learning after remote address set to: 192.168.100.11:8000
<--- Transmitting SIP response (750 bytes) to UDP:192.168.100.11:54069 --->
SIP/2.0 200 OK
Via: SIP/2.0/UDP 192.168.100.11:54069;rport=54069;received=192.168.100.11;branch=z9hG4bK-524287-1---3644c018964c9490
Call-ID: SphBTlUwKgmR_W0glZrJZQ..
From: <sip:1101@192.168.100.10>;tag=70578e12
To: <sip:1102@192.168.100.10>;tag=c095ef7c-df52-4402-9f27-d6375dfdf79d
CSeq: 2 INVITE
Server: Asterisk PBX 15.6.1
Allow: OPTIONS, SUBSCRIBE, NOTIFY, PUBLISH, INVITE, ACK, BYE, CANCEL, UPDATE, PRACK, REGISTER, MESSAGE, REFER
Contact: <sip:192.168.100.10:5060>
Supported: 100rel, timer, replaces, norefersub
Content-Type: application/sdp
Content-Length:   167

v=0
o=- 0 2 IN IP4 192.168.100.10
s=Asterisk
c=IN IP4 192.168.100.10
t=0 0
m=audio 29756 RTP/AVP 9
a=rtpmap:9 G722/8000
a=ptime:20
a=maxptime:150
a=sendrecv

<--- Received SIP request (417 bytes) from UDP:192.168.100.11:54069 --->
ACK sip:192.168.100.10:5060 SIP/2.0
Via: SIP/2.0/UDP 192.168.100.11:54069;branch=z9hG4bK-524287-1---64d2737df302e6d3;rport
Max-Forwards: 70
Contact: <sip:1101@192.168.100.11:54069;transport=UDP>
To: <sip:1102@192.168.100.10>;tag=c095ef7c-df52-4402-9f27-d6375dfdf79d
From: <sip:1101@192.168.100.10>;tag=70578e12
Call-ID: SphBTlUwKgmR_W0glZrJZQ..
CSeq: 2 ACK
User-Agent: Z 5.2.19 rv2.8.99
Content-Length: 0


    -- Channel PJSIP/1102-00000007 joined 'simple_bridge' basic-bridge <fe97ddae-0957-4bbf-950c-0e28d4f16ad2>
       > 0x7f315c041550 -- Strict RTP switching to RTP target address 192.168.100.10:8000 as source
    -- Channel PJSIP/1101-00000006 joined 'simple_bridge' basic-bridge <fe97ddae-0957-4bbf-950c-0e28d4f16ad2>
       > Bridge fe97ddae-0957-4bbf-950c-0e28d4f16ad2: switching from simple_bridge technology to native_rtp
       > Locally RTP bridged 'PJSIP/1101-00000006' and 'PJSIP/1102-00000007' in stack
       > 0x7f315c03b970 -- Strict RTP switching to RTP target address 192.168.100.11:8000 as source
       > 0x7f315c03b970 -- Strict RTP learning complete - Locking on source address 192.168.100.11:8000
<--- Received SIP request (897 bytes) from UDP:192.168.100.11:54069 --->
REGISTER sip:192.168.100.10:5060;transport=UDP SIP/2.0
Via: SIP/2.0/UDP 192.168.100.11:54069;branch=z9hG4bK-524287-1---d919f0d090f368aa;rport
Max-Forwards: 70
Contact: <sip:1101@192.168.100.11:54069;rinstance=f64697083f6591db;transport=UDP>
To: <sip:1101@192.168.100.10:5060;transport=UDP>
From: <sip:1101@192.168.100.10:5060;transport=UDP>;tag=3e2a8956
Call-ID: q_9YrMG1zXmEvXqVIuALxw..
CSeq: 47 REGISTER
Expires: 30
Allow: INVITE, ACK, CANCEL, BYE, NOTIFY, REFER, MESSAGE, OPTIONS, INFO, SUBSCRIBE
User-Agent: Z 5.2.19 rv2.8.99
Authorization: Digest username="1101",realm="asterisk",nonce="1541329981/c13f0eef46bf9a5280fa37f76ace69be",uri="sip:192.168.100.10:5060;transport=UDP",response="2652fb7416e92217575e335ee9a85188",cnonce="dbbc1c15dd8eb91e2f2c95bd2caf76b0",nc=00000002,qop=auth,algorithm=md5,opaque="51ad96470961707f"
Allow-Events: presence, kpml, talk
Content-Length: 0


<--- Transmitting SIP response (524 bytes) to UDP:192.168.100.11:54069 --->
SIP/2.0 401 Unauthorized
Via: SIP/2.0/UDP 192.168.100.11:54069;rport=54069;received=192.168.100.11;branch=z9hG4bK-524287-1---d919f0d090f368aa
Call-ID: q_9YrMG1zXmEvXqVIuALxw..
From: <sip:1101@192.168.100.10>;tag=3e2a8956
To: <sip:1101@192.168.100.10>;tag=z9hG4bK-524287-1---d919f0d090f368aa
CSeq: 47 REGISTER
WWW-Authenticate: Digest  realm="asterisk",nonce="1541330034/c4c8f077f6c2043e796a0715f7aeecbc",opaque="5a895ed97cc5a6ee",stale=true,algorithm=md5,qop="auth"
Server: Asterisk PBX 15.6.1
Content-Length:  0


<--- Received SIP request (897 bytes) from UDP:192.168.100.11:54069 --->
REGISTER sip:192.168.100.10:5060;transport=UDP SIP/2.0
Via: SIP/2.0/UDP 192.168.100.11:54069;branch=z9hG4bK-524287-1---8ef5097d7422333f;rport
Max-Forwards: 70
Contact: <sip:1101@192.168.100.11:54069;rinstance=f64697083f6591db;transport=UDP>
To: <sip:1101@192.168.100.10:5060;transport=UDP>
From: <sip:1101@192.168.100.10:5060;transport=UDP>;tag=3e2a8956
Call-ID: q_9YrMG1zXmEvXqVIuALxw..
CSeq: 48 REGISTER
Expires: 30
Allow: INVITE, ACK, CANCEL, BYE, NOTIFY, REFER, MESSAGE, OPTIONS, INFO, SUBSCRIBE
User-Agent: Z 5.2.19 rv2.8.99
Authorization: Digest username="1101",realm="asterisk",nonce="1541330034/c4c8f077f6c2043e796a0715f7aeecbc",uri="sip:192.168.100.10:5060;transport=UDP",response="34ecd6617998f9f009379136c9d5fdaa",cnonce="ed7feeb82013b97fd227a696aea112b9",nc=00000001,qop=auth,algorithm=md5,opaque="5a895ed97cc5a6ee"
Allow-Events: presence, kpml, talk
Content-Length: 0


<--- Transmitting SIP response (486 bytes) to UDP:192.168.100.11:54069 --->
SIP/2.0 200 OK
Via: SIP/2.0/UDP 192.168.100.11:54069;rport=54069;received=192.168.100.11;branch=z9hG4bK-524287-1---8ef5097d7422333f
Call-ID: q_9YrMG1zXmEvXqVIuALxw..
From: <sip:1101@192.168.100.10>;tag=3e2a8956
To: <sip:1101@192.168.100.10>;tag=z9hG4bK-524287-1---8ef5097d7422333f
CSeq: 48 REGISTER
Date: Sun, 04 Nov 2018 11:13:54 GMT
Contact: <sip:1101@192.168.100.11:54069;rinstance=f64697083f6591db>;expires=59
Expires: 60
Server: Asterisk PBX 15.6.1
Content-Length:  0


<--- Received SIP request (897 bytes) from UDP:192.168.100.10:35682 --->
REGISTER sip:192.168.100.10:5060;transport=UDP SIP/2.0
Via: SIP/2.0/UDP 192.168.100.10:35682;branch=z9hG4bK-524287-1---8cd38ab49b421086;rport
Max-Forwards: 70
Contact: <sip:1102@192.168.100.10:35682;rinstance=337737f4f2889ea8;transport=UDP>
To: <sip:1102@192.168.100.10:5060;transport=UDP>
From: <sip:1102@192.168.100.10:5060;transport=UDP>;tag=63dd660a
Call-ID: rSgeyzyjtNn0wjZ3mqUPhA..
CSeq: 41 REGISTER
Expires: 30
Allow: INVITE, ACK, CANCEL, BYE, NOTIFY, REFER, MESSAGE, OPTIONS, INFO, SUBSCRIBE
User-Agent: Z 5.2.19 rv2.8.99
Authorization: Digest username="1102",realm="asterisk",nonce="1541329985/27023fc3703631f2d8d8c10105aba2b9",uri="sip:192.168.100.10:5060;transport=UDP",response="ab3483ffa30080c620d6d82a3001905f",cnonce="bb2a26f2578229341c7eb694daa14061",nc=00000002,qop=auth,algorithm=md5,opaque="61c7383c1db23056"
Allow-Events: presence, kpml, talk
Content-Length: 0


<--- Transmitting SIP response (524 bytes) to UDP:192.168.100.10:35682 --->
SIP/2.0 401 Unauthorized
Via: SIP/2.0/UDP 192.168.100.10:35682;rport=35682;received=192.168.100.10;branch=z9hG4bK-524287-1---8cd38ab49b421086
Call-ID: rSgeyzyjtNn0wjZ3mqUPhA..
From: <sip:1102@192.168.100.10>;tag=63dd660a
To: <sip:1102@192.168.100.10>;tag=z9hG4bK-524287-1---8cd38ab49b421086
CSeq: 41 REGISTER
WWW-Authenticate: Digest  realm="asterisk",nonce="1541330038/e47e7436d1a642cf42ecd4032f9fc9e2",opaque="5d3cb0075f9be6ae",stale=true,algorithm=md5,qop="auth"
Server: Asterisk PBX 15.6.1
Content-Length:  0


<--- Received SIP request (897 bytes) from UDP:192.168.100.10:35682 --->
REGISTER sip:192.168.100.10:5060;transport=UDP SIP/2.0
Via: SIP/2.0/UDP 192.168.100.10:35682;branch=z9hG4bK-524287-1---87d88ea63d5b1fe8;rport
Max-Forwards: 70
Contact: <sip:1102@192.168.100.10:35682;rinstance=337737f4f2889ea8;transport=UDP>
To: <sip:1102@192.168.100.10:5060;transport=UDP>
From: <sip:1102@192.168.100.10:5060;transport=UDP>;tag=63dd660a
Call-ID: rSgeyzyjtNn0wjZ3mqUPhA..
CSeq: 42 REGISTER
Expires: 30
Allow: INVITE, ACK, CANCEL, BYE, NOTIFY, REFER, MESSAGE, OPTIONS, INFO, SUBSCRIBE
User-Agent: Z 5.2.19 rv2.8.99
Authorization: Digest username="1102",realm="asterisk",nonce="1541330038/e47e7436d1a642cf42ecd4032f9fc9e2",uri="sip:192.168.100.10:5060;transport=UDP",response="0c60eacb98d936b992b55d4c6fb27b7c",cnonce="ba2e6f67bc376afc4073b2e76d04e463",nc=00000001,qop=auth,algorithm=md5,opaque="5d3cb0075f9be6ae"
Allow-Events: presence, kpml, talk
Content-Length: 0


<--- Transmitting SIP response (486 bytes) to UDP:192.168.100.10:35682 --->
SIP/2.0 200 OK
Via: SIP/2.0/UDP 192.168.100.10:35682;rport=35682;received=192.168.100.10;branch=z9hG4bK-524287-1---87d88ea63d5b1fe8
Call-ID: rSgeyzyjtNn0wjZ3mqUPhA..
From: <sip:1102@192.168.100.10>;tag=63dd660a
To: <sip:1102@192.168.100.10>;tag=z9hG4bK-524287-1---87d88ea63d5b1fe8
CSeq: 42 REGISTER
Date: Sun, 04 Nov 2018 11:13:58 GMT
Contact: <sip:1102@192.168.100.10:35682;rinstance=337737f4f2889ea8>;expires=59
Expires: 60
Server: Asterisk PBX 15.6.1
Content-Length:  0


<--- Received SIP request (702 bytes) from UDP:192.168.100.11:54069 --->
BYE sip:192.168.100.10:5060 SIP/2.0
Via: SIP/2.0/UDP 192.168.100.11:54069;branch=z9hG4bK-524287-1---60c47510eba93215;rport
Max-Forwards: 70
Contact: <sip:1101@192.168.100.11:54069;transport=UDP>
To: <sip:1102@192.168.100.10>;tag=c095ef7c-df52-4402-9f27-d6375dfdf79d
From: <sip:1101@192.168.100.10>;tag=70578e12
Call-ID: SphBTlUwKgmR_W0glZrJZQ..
CSeq: 3 BYE
User-Agent: Z 5.2.19 rv2.8.99
Authorization: Digest username="1101",realm="asterisk",nonce="1541329982/97eba7a1aa8bfdea720a90f5e4f076d1",uri="sip:192.168.100.10:5060",response="2a6db35a60ce25472115a1dd69d02980",cnonce="1d2ad9b6d77ba22307656fb03e893402",nc=00000002,qop=auth,algorithm=md5,opaque="4e73d1de56e180d4"
Content-Length: 0


<--- Transmitting SIP response (351 bytes) to UDP:192.168.100.11:54069 --->
SIP/2.0 200 OK
Via: SIP/2.0/UDP 192.168.100.11:54069;rport=54069;received=192.168.100.11;branch=z9hG4bK-524287-1---60c47510eba93215
Call-ID: SphBTlUwKgmR_W0glZrJZQ..
From: <sip:1101@192.168.100.10>;tag=70578e12
To: <sip:1102@192.168.100.10>;tag=c095ef7c-df52-4402-9f27-d6375dfdf79d
CSeq: 3 BYE
Server: Asterisk PBX 15.6.1
Content-Length:  0


    -- Channel PJSIP/1101-00000006 left 'native_rtp' basic-bridge <fe97ddae-0957-4bbf-950c-0e28d4f16ad2>
  == Spawn extension (default, 1102, 1) exited non-zero on 'PJSIP/1101-00000006'
    -- Channel PJSIP/1102-00000007 left 'native_rtp' basic-bridge <fe97ddae-0957-4bbf-950c-0e28d4f16ad2>
<--- Transmitting SIP request (440 bytes) to UDP:192.168.100.10:35682 --->
BYE sip:1102@192.168.100.10:35682 SIP/2.0
Via: SIP/2.0/UDP 192.168.100.10:5060;rport;branch=z9hG4bKPjc824a5e8-55f8-4917-a2ef-d06f56436956
From: <sip:1101@10.0.2.15>;tag=096c61ee-0a03-4a79-adfa-36429ff2ad06
To: <sip:1102@192.168.100.10;rinstance=337737f4f2889ea8>;tag=ff7abd7c
Call-ID: 40984dec-06ee-438d-91e2-72dc6d0e361a
CSeq: 2449 BYE
Reason: Q.850;cause=16
Max-Forwards: 70
User-Agent: Asterisk PBX 15.6.1
Content-Length:  0


<--- Received SIP response (415 bytes) from UDP:192.168.100.10:35682 --->
SIP/2.0 200 OK
Via: SIP/2.0/UDP 192.168.100.10:5060;rport=5060;branch=z9hG4bKPjc824a5e8-55f8-4917-a2ef-d06f56436956
Contact: <sip:1102@192.168.100.10:35682>
To: <sip:1102@192.168.100.10;rinstance=337737f4f2889ea8>;tag=ff7abd7c
From: <sip:1101@10.0.2.15>;tag=096c61ee-0a03-4a79-adfa-36429ff2ad06
Call-ID: 40984dec-06ee-438d-91e2-72dc6d0e361a
CSeq: 2449 BYE
User-Agent: Z 5.2.19 rv2.8.99
Content-Length: 0

```

