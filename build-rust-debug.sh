# build-rust.sh

#!/bin/bash

set -e
#!/bin/bash
cargo swift package --name BurntChroma-Debug --platforms ios macos

cp -rf BurntChroma-Debug/ . && rm -rf BurntChroma-Debug/
