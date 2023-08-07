# build-rust.sh

#!/bin/bash

set -e
#!/bin/bash
cargo swift package --name BurntChroma-Debug --platforms ios

cp -rf BurntChroma-Debug/ . && rm -rf BurntChroma-Debug/
