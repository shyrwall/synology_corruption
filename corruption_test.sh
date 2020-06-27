#!/bin/sh

SRC_NAS=$1
SYNOLOGY_NAS=$2

if [ -z "${SRC_NAS}" ]; then
    echo -n "Directory on a non-synology product: "
    read SRC_NAS
fi

if [ -z "${SYNOLOGY_NAS}" ]; then
    echo -n "Directory on a synology product to test: "
    read SYNOLOGY_NAS
fi

SRC_DIR="$SRC_NAS/corruption_test"

mkdir $SRC_DIR

# Generate 100 files at 1GB each with random data
for FILE in $(seq 1 100)
do
 echo "Creating file $FILE"
 dd if=/dev/urandom of=$SRC_DIR/$FILE bs=1024k count=1000
done

# Get MD5 hash for each file and save
cd $SRC_DIR
echo "Computing md5 hashes for src files"
for FILE in $(seq 1 100)
do
 echo "Computing md5 hash for $FILE"
 md5sum $FILE >> $SRC_DIR/md5.txt
done

# Copy files over to synology nas
DST_DIR="$SYNOLOGY_NAS/corruption_test"
mkdir $DST_DIR


for FILE in $(seq 1 100)
do
 echo "Copying $SRC_DIR/$FILE to $DST_DIR/$FILE"
 cp $SRC_DIR/$FILE $DST_DIR/$FILE
done

# Get MD5 hash for copied files
cd $DST_DIR
echo "Computing md5 hashes for synology dst files"
for FILE in $(seq 1 100)
do
 echo "Computing md5 hash for $FILE"
 md5sum $FILE >> $DST_DIR/md5.txt
done


# Compare with simple diff
diff $SRC_DIR/md5.txt $DST_DIR/md5.txt


echo "Please remove $SRC_DIR and $DST_DIR manually. Don't want an 'rm' in this script :D"

