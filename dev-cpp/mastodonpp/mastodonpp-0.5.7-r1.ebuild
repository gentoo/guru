# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake
[[ "${PV}" == "9999" ]] && inherit git-r3

DESCRIPTION="C++ wrapper for the Mastodon and Pleroma APIs."
HOMEPAGE="https://schlomp.space/tastytea/mastodonpp"
if [[ "${PV}" != "9999" ]]; then
	SRC_URI="https://schlomp.space/tastytea/mastodonpp/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}"
	KEYWORDS="~amd64"
else
	EGIT_REPO_URI="https://schlomp.space/tastytea/mastodonpp.git"
fi

LICENSE="AGPL-3"
SLOT="0"
IUSE="doc examples test"

RDEPEND=">=net-misc/curl-7.56.0[ssl]"
DEPEND="${RDEPEND}"
BDEPEND="
	doc? ( app-text/doxygen[dot] )
	test? ( dev-cpp/catch )
"

RESTRICT="!test? ( test )"

PATCHES=( "${FILESDIR}"/${PN}-0.5.7-add-support-for-catch-3.patch )

src_configure() {
	local mycmakeargs=(
		-DWITH_EXAMPLES=NO
		-DWITH_TESTS="$(usex test)"
		-DWITH_DOC="$(usex doc)"
	)

	cmake_src_configure
}

src_test() {
	BUILD_DIR="${BUILD_DIR}/tests" cmake_src_test
}

src_install() {
	if use doc; then
		HTML_DOCS="${BUILD_DIR}/doc/html/*"
	fi

	if use examples; then
		docinto examples
		for file in examples/*.cpp; do
			dodoc ${file}
		done
	fi

	cmake_src_install
}
