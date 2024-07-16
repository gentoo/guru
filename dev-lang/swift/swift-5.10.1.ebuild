# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
inherit python-single-r1

DESCRIPTION="A high-level general-purpose, multi-paradigm, compiled programming language"
HOMEPAGE="https://www.swift.org/"
SRC_URI="https://download.swift.org/${P}-release/fedora39/${P}-RELEASE/${P}-RELEASE-fedora39.tar.gz"
S="${WORKDIR}/${P}-RELEASE-fedora39/usr"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="strip"

RDEPEND="
	${PYTHON_DEPS}
	dev-db/sqlite
	dev-lang/python
	dev-libs/libedit
	dev-libs/libxml2
	dev-vcs/git
	net-misc/curl
	sys-devel/binutils[gold]
	sys-devel/gcc
	sys-libs/ncurses
	sys-libs/zlib
"

BDEPEND="dev-util/patchelf"

QA_PREBUILT="*"

src_install() {
	# lib/swift/linux/libicudataswift.so.69.1 has an empty DT_RUNPATH, which
	# fails `rpath_security_checks`. It contains only data, so we can remove its
	# rpath altogether.
	patchelf --remove-rpath lib/swift/linux/libicudataswift.so.69.1

	# The RELEASE tarball is a self-contained portable installation that's
	# _significantly_ easier to leave as-is rather than attempt to splat onto
	# the filesystem; we'll install the contents as-is into
	# `/usr/lib64/swift-{version}` (e.g., `/usr/lib64/swift-5.10.1`) and expose
	# the relevant binaries via linking.
	local dest_dir="/usr/lib64/swift-${PV}"
	mkdir -p "${ED}${dest_dir}" || die
	cp -pPR "${S}" "${ED}${dest_dir}" || die

	# Swift ships with its own `clang`, `lldb`, etc.; these don't need to be
	# exposed externally, so we'll just symlink Swift-specific binaries into
	# `/usr/bin`.
	find bin -maxdepth 1 \( -type f -o -type l \) \
		\( -name "swift*" -o -name "sourcekit*" \) -executable -print0 |
		while IFS= read -r -d '' exe_path; do
			local exe_name="$(basename "$exe_path")"
			dosym -r "${dest_dir}/usr/bin/${exe_name}" "/usr/bin/${exe_name}"
		done
}
