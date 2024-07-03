#!/usr/bin/env bash
set -e

echo "Please ensure that you run this script from the root of the zkevm-prover repository."
echo "Press Enter to continue..."
read

ARCHIVE_NAME="v3.0.0-RC3-fork.6"
ARCHIVE_EXTENSION=".tgz"
ARCHIVE_URL="https://storage.googleapis.com/zkevm/zkproverc/${ARCHIVE_NAME}${ARCHIVE_EXTENSION}"

wget -c ${ARCHIVE_URL}
tar -xzvf ${ARCHIVE_NAME}${ARCHIVE_EXTENSION}
rm -rf config
cp -R ${ARCHIVE_NAME}/config .

rm ${ARCHIVE_NAME}${ARCHIVE_EXTENSION}
