# build-rust.sh

#!/bin/bash
cargo swift package --release --name BurntChroma --platforms ios

cp -rf BurntChroma/ . && rm -rf BurntChroma/