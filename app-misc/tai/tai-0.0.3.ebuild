# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
adler-0.2.3
adler32-1.2.0
autocfg-1.0.1
bitflags-1.2.1
bytemuck-1.5.0
byteorder-1.4.2
cfg-if-1.0.0
color_quant-1.1.0
const_fn-0.4.5
crc32fast-1.2.1
crossbeam-channel-0.5.0
crossbeam-deque-0.8.0
crossbeam-epoch-0.9.1
crossbeam-utils-0.8.1
deflate-0.8.6
either-1.6.1
gif-0.11.1
hermit-abi-0.1.18
image-0.23.13
jpeg-decoder-0.1.22
lazy_static-1.4.0
libc-0.2.86
memoffset-0.6.1
miniz_oxide-0.3.7
miniz_oxide-0.4.3
num-integer-0.1.44
num-iter-0.1.42
num-rational-0.3.2
num-traits-0.2.14
num_cpus-1.13.0
png-0.16.8
rayon-1.5.0
rayon-core-1.9.0
scoped_threadpool-0.1.9
scopeguard-1.1.0
tiff-0.6.1
weezl-0.1.4
"

S="${WORKDIR}/${P}"
inherit cargo
HOMEPAGE="https://github.com/mustafasalih1993/tai"
DESCRIPTION="tai (Terminal Ascii Image) tool to convert images to ascii"
SRC_URI="https://www.github.com/mustafasalih1993/tai/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" $(cargo_crate_uris ${CRATES})"
RESTRICT="mirror"
KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"
QA_FLAGS_IGNORED="usr/bin/tai"
