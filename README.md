Synology Corruption Test

UPDATE 200701 : Created a "basic" storage pool with just 1 drive (that passed extended smart checks and ironwolf check). 
		Then created a btrfs volume with checksumming on. The following errors come when testing, 

		992509.463200] BTRFS warning (device md3): csum failed ino 400 off 32030720 csum 746848803 expected csum 746881571
		[992509.506465] BTRFS warning (device md3): csum failed ino 400 off 32030720 csum 746848803 expected csum 746881571
		[992509.516962] md/raid1:md3: syno_raid1_self_heal_set_and_submit_read_bio(1226): No suitable device for self healing retry read at round 2 at sector 63919200
		[992509.531110] BTRFS error (device md3): failed to repair data csum of ino 400 off 32030720 (ran out of all copies)


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
