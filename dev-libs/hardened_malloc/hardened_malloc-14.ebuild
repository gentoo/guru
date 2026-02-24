# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Hardened allocator designed for modern systems."
HOMEPAGE="https://github.com/GrapheneOS/hardened_malloc"
SRC_URI="https://github.com/GrapheneOS/hardened_malloc/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_test() {
	emake test
}

src_compile() {
	emake VARIANT=light
	emake VARIANT=default
}

src_install() {
	dolib.so out-light/libhardened_malloc-light.so
	dolib.so out/libhardened_malloc.so
}
