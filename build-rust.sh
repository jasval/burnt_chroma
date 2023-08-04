# build-rust.sh

#!/bin/bash

set -e

THISDIR=$(dirname $0)
cd $THISDIR

# Build the project for the desired platforms:
cargo build --release --target x86_64-apple-darwin
cargo build --release --target aarch64-apple-darwin
mkdir -p ./target/universal-macos/release

lipo \
    ./target/aarch64-apple-darwin/release/libburnt_chroma.a \
    ./target/x86_64-apple-darwin/release/libburnt_chroma.a -create -output \
    ./target/universal-macos/release/libburnt_chroma.a

cargo build --release --target aarch64-apple-ios

cargo build --release --target x86_64-apple-ios
cargo build --release --target aarch64-apple-ios-sim
mkdir -p ./target/universal-ios/release

lipo \
    ./target/aarch64-apple-ios-sim/release/libburnt_chroma.a \
    ./target/x86_64-apple-ios/release/libburnt_chroma.a -create -output \
    ./target/universal-ios/release/libburnt_chroma.a

 swift-bridge-cli create-package \
  --bridges-dir ./generated \
  --out-dir . \
  --ios target/aarch64-apple-ios/release/libburnt_chroma.a \
  --simulator target/universal-ios/release/libburnt_chroma.a \
  --macos target/universal-macos/release/libburnt_chroma.a \
  --name SwiftBurntChroma