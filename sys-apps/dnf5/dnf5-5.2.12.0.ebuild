# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..13} )
inherit cmake python-single-r1

DESCRIPTION="Command-line package manager"
HOMEPAGE="https://github.com/rpm-software-management/dnf5"
SRC_URI="https://github.com/rpm-software-management/dnf5/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="appstream nls python systemd test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

RDEPEND="
	>=app-arch/rpm-4.17.0
	dev-cpp/sdbus-c++:0/2
	dev-cpp/toml11
	>=dev-db/sqlite-3.35.0:3
	>=dev-libs/glib-2.46.0:2
	dev-libs/json-c:=
	dev-libs/libfmt:=
	>=dev-libs/librepo-1.17.1
	>=dev-libs/libsolv-0.7.25
	dev-libs/libxml2
	sys-apps/util-linux
	>=sys-libs/libmodulemd-2.11.2
	sys-libs/zlib
	appstream? ( >=dev-libs/appstream-0.16:= )
	python? ( ${PYTHON_DEPS} )
	systemd? ( sys-apps/systemd:= )
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-python/sphinx
	virtual/pkgconfig
	python? ( dev-lang/swig )
	test? (
		app-arch/rpm
		app-arch/createrepo_c
		dev-util/cppunit
	)
"

PATCHES=(
	# Prevent test suite from writing to system files.
	"${FILESDIR}/${PN}-5.2.5.0-sandbox-test.patch"
)

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_prepare() {
	cmake_src_prepare
	# Replace hardcoded TMPDIR.
	sed -i "s|/tmp/|${T}/|" test/libdnf5/utils/test_fs.cpp || die
	# remove -Werror{,=unused-result}; bug 936870
	sed -i 's/-Werror[^[:space:])]*//' CMakeLists.txt || die
	# breathe is only needed for api doc
	sed -i "/'breathe',/d" doc/conf.py.in || die
}

src_configure() {
	local mycmakeargs=(
		-DWITH_HTML=OFF
		-DWITH_PERL5=OFF
		-DWITH_RUBY=OFF
		-DWITH_ZCHUNK=OFF
		-DWITH_PLUGIN_APPSTREAM=$(usex appstream)
		-DWITH_PYTHON3=$(usex python)
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

src_install() {
	cmake_src_install
	use python && python_optimize
}
