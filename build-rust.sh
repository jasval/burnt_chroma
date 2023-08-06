# build-rust.sh

#!/bin/bash
cargo swift package --release --name BurntChroma --platforms ios macos

cp -rf BurntChroma/ . && rm -rf BurntChroma/