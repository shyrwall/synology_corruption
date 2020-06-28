Synology Corruption Test

UPDATE 200629 : Problem seems related to sparse files. Files copied with "cp --sparse=never" does not get corrupted.
		  Also. EXT3 (manual mkfs on the Synologies) do not suffer from the corruption.

See https://www.reddit.com/r/synology/comments/hgp5mj/data_corruption/ for backstory

Simple script (excuse my lack of sh skillz) that does the following,

1. Generate 100 1GB files from /dev/urandom to a "confirmed good" dir
2. Compute the MD5 hash on the files and save
3. Copy the 100 1GB files to a "synology nas" dir.
4. Compute MD5 hash on the files and save
5. Do a diff on the md5 files.


See "TESTS" file for the tests.
