GreenUP HTTP
========================

The cute little C-library to replace FSNetworking library.

Written to spec to support GET, POST, PUT 
Supports raw sending, you'll have to create the json yourself.
http://tools.ietf.org/html/rfc2616



Changelog
-------------------------
Release 5.1
	- Fixed implicit cast. (Warning but still)
Release 5
	- Because of library issues/runtime issues on ios, ip address is a parameter to gh_make_request now
Release 4
	- Update ip lookup to use getaddrinfo instead of gethostbyname
Release 3
	- Fixed syntax issue in release_2
	- Updated test code
	- Troubleshot socket error with ios
Release 2.1 (syntax tag)
	- Fixed syntax error accidently pushed
Release 2
	- First implementation of library
	- Documentation and makefile
	- Memory Leak free!
Release 1
	- Working example with GET POST and PUT	