# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg cmake wrapper flag-o-matic

DESCRIPTION="Graphical Git client to help understand and manage source code history"
HOMEPAGE="https://github.com/gitahead/gitahead"
SRC_URI="
	https://github.com/gitahead/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/stinb/libgit2/archive/834d652bcb932af447d7f0acd1214a4057cb0771.tar.gz
		-> ${P}-dep_libgit2_libgit2.tar.gz
	https://github.com/hunspell/hunspell/archive/8a2fdfe5a6bb1cbafc04b0c8486abcefd17ad903.tar.gz
		-> ${P}-dep_hunspell_hunspell.tar.gz
	gnome-keyring? (
		https://github.com/git/git/archive/0d0ac3826a3bbb9247e39e12623bbcfdd722f24c.tar.gz -> ${P}-dep_git_git.tar.gz
	)
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
IUSE="gnome-keyring"

RDEPEND="
	app-text/cmark:=
	dev-libs/libpcre2:=
	dev-libs/openssl:=
	dev-qt/qt5compat:6
	dev-qt/qtbase:6[concurrent,gui,network,widgets]
	net-libs/http-parser:=
	net-libs/libssh2
	sys-libs/zlib
	gnome-keyring? (
		app-crypt/libsecret
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-qt/qttools:6[linguist]
	virtual/pkgconfig
"

QA_FLAGS_IGNORED="usr/share/GitAhead/Plugins/.*"
QA_PRESTRIPPED="usr/share/GitAhead/Plugins/.*"

src_unpack() {
	unpack "${P}.tar.gz"

	cd "${S}" || die
	local i list=(
		dep_libgit2_libgit2
		dep_hunspell_hunspell
	)
	use gnome-keyring && list+=( dep_git_git )
	for i in "${list[@]}"; do
		[ ! -f "${DISTDIR}/${P}-${i}.tar.gz" ] && die "The file ${DISTDIR}/${P}-${i}.tar.gz doesn't exist"
		tar xf "${DISTDIR}/${P}-${i}.tar.gz" --strip-components 1 -C "${i//_//}" || die "Failed to unpack ${P}-${i}.tar.gz"
	done
}

src_prepare() {
	if ! use gnome-keyring; then
		sed -i 's/add_subdirectory(git)//' ./dep/CMakeLists.txt || die
	fi
	sed -i 's/add_subdirectory(openssl)//' ./dep/CMakeLists.txt || die
	# Respect LDFLAGS
	sed -i '/CMAKE_EXE_LINKER_FLAGS/d' CMakeLists.txt || die

	cmake_src_prepare
}

src_configure() {
	filter-flags -flto* # Segfault in libQt5Core.so.5
	local mycmakeargs=(
		# libgit2 flags
		-DBUILD_TESTS=OFF
		-DREGEX_BACKEND=pcre2
		-DUSE_GSSAPI=OFF
		-DUSE_HTTP_PARSER=system
	)
	cmake_src_configure
}

src_install() {
	cd "${BUILD_DIR}" || die

	eninja package
	cd ./_CPack_Packages/Linux/STGZ || die
	mkdir -p "${D}"/usr/share || die
	bash ./GitAhead-2.7.1.sh --prefix="${D}"/usr/share --include-subdir || die
	rm -fr "${D}"/usr/share/GitAhead/*.so.* || die

	cd "${D}"/usr/share/GitAhead/Resources/GitAhead.iconset || die
	local res
	for res in 16 32 64 128 256 512; do
		newicon -s "${res}" "icon_${res}x${res}.png" "${PN}.png"
	done

	make_wrapper "${PN}" "${EPREFIX}/usr/share/GitAhead/GitAhead"
	make_desktop_entry "/usr/share/GitAhead/GitAhead" "GitAhead" "${PN}" "Development"
}

pkg_postinst() {
	xdg_pkg_postinst

	ewarn "${P} collects some statistical usage data."
	ewarn "To permanently opt-out of reporting:"
	ewarn "toggle a button in Help -> About GitAhead -> Privacy"
	ewarn "or write to ~/.config/gitahead.com/GitAhead.conf those lines:"
	ewarn "[tracking]"
	ewarn "enabled=false"
}
