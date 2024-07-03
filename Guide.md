# Version Selection and Compilation

## 1. Select the Release Version

Choose the release version: [zkevm-prover v6.0.1](https://github.com/0xPolygonHermez/zkevm-prover.git)

## 2. Download Necessary Files

**Important**: The script `./tools/download_archive.sh` in the project source downloads older versions of the files. You need to manually adjust the version to download the correct files.

### Steps:

1. List available file versions: [File Versions](https://storage.googleapis.com/zkevm)

2. Download the corresponding project version file, for example:

   ```
   wget -c https://storage.googleapis.com/zkevm/zkproverc/v6.0.0-rc.1-fork.9.tgz
   ```

3. Follow the steps in the `download_archive.sh` script after downloading the files.

## 3. Install Dependencies

Based on your system environment (Linux/Ubuntu):

```
sudo apt update
sudo apt install build-essential libbenchmark-dev libomp-dev libgmp-dev nlohmann-json3-dev postgresql libpqxx-dev libpqxx-doc nasm libsecp256k1-dev grpc-proto libsodium-dev libprotobuf-dev libssl-dev cmake libgrpc++-dev protobuf-compiler protobuf-compiler-grpc uuid-dev
```

## 4. Compilation

```
cd src/grpc
make
cd ../..

make clean
make generate
make -j
```

## 5. Adjust Configuration Files

Here's an example of how you might adjust the `zkevm-prover/tools/download_archive.sh` script:

```
#!/usr/bin/env bash
set -e

echo "Please ensure that you run this script from the root of the zkevm-prover repository."
echo "Press Enter to continue..."
read

ARCHIVE_NAME="v6.0.0-rc.1-fork.9"
ARCHIVE_EXTENSION=".tgz"
ARCHIVE_URL="https://storage.googleapis.com/zkevm/zkproverc/${ARCHIVE_NAME}${ARCHIVE_EXTENSION}"

wget -c ${ARCHIVE_URL}
tar -xzvf ${ARCHIVE_NAME}${ARCHIVE_EXTENSION}
mv config config_backup
cp -R ${ARCHIVE_NAME}/config .

rm ${ARCHIVE_NAME}${ARCHIVE_EXTENSION}

echo "Archive ${ARCHIVE_NAME}${ARCHIVE_EXTENSION} downloaded and extracted successfully."
```

### Notes:

- The script's steps are:
  1. Download the corresponding version's archive and name it accordingly.
  2. Extract the archive.
  3. Rename the existing `config` directory (do not delete it as it contains necessary configuration files for starting various modules like prover, executor, and hashdb).
  4. Copy the `config` directory from the extracted archive to the project directory.
  5. Delete the archive file.

## 6. Starting the Modules

### Executor and StateDB Module

```
cd zkevm-prover
./build/zkProver -c config_run/config_executor_and_statedb.json
```

### Prover Module

```
cd zkevm-prover
./build/zkProver -c config_run/config_prover.json
```