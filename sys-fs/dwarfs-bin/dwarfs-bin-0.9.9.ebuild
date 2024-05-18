# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Static version of a fast very high compression read-only FUSE file system"
HOMEPAGE="https://github.com/mhx/dwarfs"
SRC_URI="
	amd64? ( https://github.com/mhx/dwarfs/releases/download/v${PV}/dwarfs-${PV}-Linux-x86_64-clang.tar.xz -> ${P}-amd64.tar.xz )
	arm64? ( https://github.com/mhx/dwarfs/releases/download/v${PV}/dwarfs-${PV}-Linux-aarch64-clang.tar.xz -> ${P}-arm64.tar.gz )
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

RDEPEND="
	${PYTHON_DEPS}
	sys-fs/fuse:3
"
DEPEND="
	${RDEPEND}
"
QA_PREBUILT="
	opt/dwarfs-bin/bin/*
	opt/dwarfs-bin/sbin/*
"

src_unpack() {
	if use amd64; then
		S="${WORKDIR}/dwarfs-${PV}-Linux-x86_64-clang"
	elif use arm64; then
		S="${WORKDIR}/dwarfs-${PV}-Linux-aarch64-clang"
	fi

	default
}

src_prepare() {
	default
	einfo "Removing legacy fuse2-related stuff..."
	rm sbin/dwarfs2 sbin/mount.dwarfs2 || die
	einfo "Done."
}

src_install(){
	mkdir -p "${ED}/opt/${PN}" || die
	mv "${S}"/* "${ED}/opt/${PN}" || die

	for file in "${ED}/opt/${PN}/bin"/*; do
		dosym "../${PN}/bin/$(basename "${file}")" "/opt/bin/$(basename "${file}")"
	done
	for file in "${ED}/opt/${PN}/sbin"/*; do
		dosym "../${PN}/sbin/$(basename "${file}")" "/opt/bin/$(basename "${file}")"
	done

	newenvd - "90${P}" <<-_EOF_
		MANPATH="${EPREFIX}/opt/${PN}/share/man"
	_EOF_
}

pkg_postinst(){
	elog "You may find more information in the"
	elog "${HOMEPAGE}"
	elog "About creating: ${HOMEPAGE}/blob/main/doc/mkdwarfs.md"
	elog "About mounting: ${HOMEPAGE}/blob/main/doc/dwarfs.md"
}
