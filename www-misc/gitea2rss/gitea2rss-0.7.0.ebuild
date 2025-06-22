# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Generates RSS feeds from Gitea releases, tags and commits"
HOMEPAGE="https://codeberg.org/tastytea/gitea2rss"
SRC_URI="https://codeberg.org/tastytea/gitea2rss/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-3"
SLOT="0"
if [[ "${PV}" != "9999" ]]; then
	KEYWORDS="~amd64 ~arm ~x86"
fi
IUSE="test"

RDEPEND="
	net-misc/curl[ssl]
	dev-libs/jsoncpp
"
DEPEND="
	${RDEPEND}
	test? ( dev-cpp/catch )
"
BDEPEND="
	virtual/pkgconfig
	app-text/asciidoc
"

RESTRICT="!test? ( test )"

DOCS=("README.adoc" "doc/nginx-example.conf")

src_configure() {
	local mycmakeargs=(
		-DWITH_TESTS="$(usex test)"
	)
	if use test; then
		# Don't run tests that need a network connection.
		mycmakeargs+=(-DEXTRA_TEST_ARGS="~[http]")
	fi

	cmake_src_configure
}

src_test() {
	BUILD_DIR="${BUILD_DIR}/tests" cmake_src_test
}
