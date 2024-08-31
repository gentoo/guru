# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic qmake-utils toolchain-funcs virtualx xdg

DESCRIPTION="Practical and minimal image viewer"
HOMEPAGE="https://github.com/jurplel/qView https://interversehq.com/qview/"
SRC_URI="https://github.com/jurplel/qView/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/qView-${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
"

DEPEND="${RDEPEND}
	test? ( dev-qt/qttest:5 )
"

BDEPEND="
	dev-qt/linguist-tools:5
"

src_configure() {
	# https://github.com/jurplel/qView/issues/395
	if tc-is-clang && has_version "sys-devel/clang:$(clang-major-version)[default-libcxx]" || is-flagq -stdlib=libc++
	then
		append-cxxflags -stdlib=libstdc++
		append-ldflags -stdlib=libstdc++
	fi

	eqmake5 PREFIX=/usr qView.pro
}

src_test() {
	cd tests || die
	eqmake5 && emake
	virtx ./tests
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	einstalldocs
}
