# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Command-line package manager"
HOMEPAGE="https://github.com/rpm-software-management/dnf5"
SRC_URI="https://github.com/rpm-software-management/dnf5/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls systemd test"
PROPERTIES="test_network"
RESTRICT="!test? ( test )"

RDEPEND="
	>=app-arch/rpm-4.17.0
	dev-cpp/sdbus-c++:=
	<dev-cpp/toml11-4.0.0
	>=dev-db/sqlite-3.35.0:3
	>=dev-libs/glib-2.46.0:2
	dev-libs/json-c:=
	dev-libs/libfmt:=
	>=dev-libs/librepo-1.17.1
	>=dev-libs/libsolv-0.7.25
	dev-libs/libxml2
	sys-apps/util-linux
	>=sys-libs/libmodulemd-2.11.2
	systemd? ( sys-apps/systemd:= )
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-python/breathe
	dev-python/sphinx
	virtual/pkgconfig
	test? (
		app-arch/rpm
		app-arch/createrepo_c
		dev-util/cppunit
	)
"

PATCHES=(
	# Prevent empty cache directory from being created.
	"${FILESDIR}/${P}-remove-empty-dir.patch"
	# Prevent test suite from writing to system files.
	"${FILESDIR}/${P}-sandbox-test.patch"
)

src_prepare() {
	cmake_src_prepare
	# Replace hardcoded TMPDIR.
	sed -i "s|/tmp/|${T}/|" test/libdnf5/utils/test_fs.cpp || die
	# remove -Werror{,=unused-result}; bug 936870
	sed 's/-Werror[^[:space:])]*//' -i CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		-DWITH_HTML=OFF
		-DWITH_PERL5=OFF
		-DWITH_PYTHON3=OFF
		-DWITH_RUBY=OFF
		-DWITH_ZCHUNK=OFF
		-DWITH_SYSTEMD=$(usex systemd)
		-DWITH_TESTS=$(usex test)
		-DWITH_TRANSLATIONS=$(usex nls)
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	cmake_src_compile doc-man
}
