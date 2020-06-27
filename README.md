Synology Corruption Test


See https://www.reddit.com/r/synology/comments/hgp5mj/data_corruption/ for backstory

Simple script (excuse my lack of sh skillz) that does the following,

1. Generate 100 500MB files from /dev/urandom to a "confirmed good" dir
2. Compute the MD5 hash on the files and save
3. Copy the 100 500MB files to a "synology nas" dir.
4. Compute MD5 hash on the files and save
5. Do a diff on the md5 files.


See "TESTS" file for the tests.
