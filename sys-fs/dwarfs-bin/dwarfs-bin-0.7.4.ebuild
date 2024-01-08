# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Static version of a fast very high compression read-only FUSE file system"
HOMEPAGE="https://github.com/mhx/dwarfs"
SRC_URI="
	amd64? ( https://github.com/mhx/dwarfs/releases/download/v${PV}/dwarfs-${PV}-Linux-x86_64.tar.xz -> ${P}-amd64.tar.xz )
	arm64? ( https://github.com/mhx/dwarfs/releases/download/v${PV}/dwarfs-${PV}-Linux-aarch64.tar.xz -> ${P}-arm64.tar.gz )
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

RDEPEND="
	${PYTHON_DEPS}
	sys-fs/fuse:3
	!sys-fs/dwarfs
"
DEPEND="
	${RDEPEND}
"
QA_PREBUILT="
	sbin/dwarfs
	bin/*
"

src_unpack() {
	if use amd64; then
		S="${WORKDIR}/dwarfs-${PV}-Linux-x86_64"
	elif use arm64; then
		S="${WORKDIR}/dwarfs-${PV}-Linux-aarch64"
	fi

	default
}

src_prepare() {
	default
	einfo "Removing legacy fuse2-related stuff..."
	rm sbin/dwarfs2 sbin/mount.dwarfs2 || die
	einfo "Done. Correcting man paths..."
	mkdir -p usr/ || die
	mv share/ usr/ || die
	einfo "Done."
}

src_install(){
	mv "${S}"/* "${D}"/ || die
}

pkg_postinst(){
	elog "You may find more information in the"
	elog "${HOMEPAGE}"
	elog "About creating: ${HOMEPAGE}/blob/main/doc/mkdwarfs.md"
	elog "About mounting: ${HOMEPAGE}/blob/main/doc/dwarfs.md"
}
