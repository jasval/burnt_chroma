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

cargo run --release --bin uniffi-bindgen generate src/lib.udl --language swift --out-dir generated/

rm -rf BurntChroma/Sources/BurntChroma.xcframework
rm -rf generated/BurntChroma.xcframework

xcodebuild -create-xcframework \
    -library target/universal-ios/release/libburnt_chroma.a \
    -headers generated/burnt_chromaFFI.h \
    -library target/universal-macos/release/libburnt_chroma.a \
    -headers generated/burnt_chromaFFI.h \
    -output generated/BurntChroma.xcframework

mv -f generated/BurntChroma.xcframework BurntChroma/Sources/BurntChroma.xcframework