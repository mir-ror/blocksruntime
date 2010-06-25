program="libBlocksRuntime"
version="0.1"
abi_major="0"
abi_minor="0"
abi_version="$abi_major.$abi_minor"
cflags="-DBlocksRuntime_EXPORTS -fPIC -std=c99 -Wall -Wextra -W -pedantic -Wno-unused-parameter"
ldflags=""
sources="runtime.c data.c"
libdepends=""
deps=""
mans=""
headers="*.h"
extra_dist=""
subdirs=""

pre_configure_hook() {
    return
}

post_configure_hook() {
  # FIXME - This is not a good idea...
  echo "
#define HAVE_SYSCONF 1
#define HAVE_SYNC_BOOL_COMPARE_AND_SWAP_INT 1
#define HAVE_SYNC_BOOL_COMPARE_AND_SWAP_LONG 1" >> config.h
}
