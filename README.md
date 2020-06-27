Synology Curruption Test

See https://www.reddit.com/r/synology/comments/hgp5mj/data_corruption/ for backstory

Simple script (excuse my lack of sh skillz) that does the following,

1. Generate 100 500MB files from /dev/urandom to a "confirmed good" dir
2. Compute the MD5 hash on the files and save
3. Copy the 100 500MB files to a "synology nas" dir.
4. Compute MD5 hash on the files and save
5. Do a diff on the md5 files.

Not all tests below can be done by just running the script.

6/6 tests failed. 


Test 1 

	Test was run on an RS3617xs with an NFS exported dir with RAID5+spare and BTRFS
	Non-Synology source was an NFS export from a FreeNAS box with ZFS
	A Debian vm was used in the middle with the NFS-exports mounted.

	FAIL: Test had 2% of the files (2/100) fail.

Test 2

	Same as Test 1 but over ISCSI

	FAIL: Test had 1% of the files (1/100) fail.

Test 3 
	Same as Test 1 but instead of copying the files over NFS to the Synology SCP was used.
	Src was still over NFS from the Debian vm
	MD5 hashes computed locally on the Synology over SSH

	FAIL: Test had 1% of the files (1/100) fail.

Test 4
	Same as Test 1 but instead of copying the files over NFS to the Synology 
	they were SCPd locally from the FreeNAS box to the Synology removing NFS/ISCSI from the equation.
	MD5 hashes computed locally on the Synology over SSH

	FAIL: Test had 2% of the files (2/100) fail.


Test 5

	Test was run on an DS1517+ with an NFS exported dir with RAID6 and EXT4
	Non-Synology source was a single hdd connected via USB to a debian server with EXT4

	FAIL: Test had 3% of the files (3/100) fail.

Test 6 
	Same as Test 3 but over ISCSI

	FAIL: Test had 2% of the files (2/100) fail.


Obvious tests i should have tried from the start coming soon..


----

A hexdump comparison of an original file and a failed file in Test 4 shows the following,

< 367c9c50 6152 4b26 0f86 f883 946f 70ef 68e5 24c7
---
> 367c9c50 e152 4b26 0f86 f883 946f 70ef 68e5 24c7



One single byte has changed. From hex 61 to e1. This type of corruption will go unnoticed by most.

Other files show also a single byte being changed
