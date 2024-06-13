# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
inherit edo meson python-any-r1

DESCRIPTION="A simple async wrapper around CURL for C++"
HOMEPAGE="https://nheko.im/nheko-reborn/coeurl"
SRC_URI="https://nheko.im/nheko-reborn/coeurl/-/archive/v${PV}/${PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="MIT"
SLOT="0/$(ver_cut 1-2)"
KEYWORDS="~amd64"
IUSE="ssl test"
REQUIRED_USE="test? ( ssl )"
RESTRICT="!test? ( test )"

RDEPEND="
	net-misc/curl[ssl?]
	dev-libs/libevent:=
	dev-libs/libfmt:=
	dev-libs/spdlog:=
"
DEPEND="
	${RDEPEND}
	test? ( dev-cpp/doctest )
"
BDEPEND="
	test? (
		dev-libs/openssl
		$(python_gen_any_dep 'dev-python/flask[${PYTHON_USEDEP}]')
	)
"

python_check_deps() {
	use test || return 0 # python is only used for tests, bug #911504

	python_has_version "dev-python/flask[${PYTHON_USEDEP}]"
}

src_prepare() {
	default
	rm -r subprojects || die
}

src_configure() {
	local -a emesonargs=(
		$(meson_use test tests)
	)
	meson_src_configure
}

src_test() {
	openssl req -x509 -newkey rsa:4096 -nodes \
		-out "${T}"/cert.pem -keyout "${T}"/key.pem \
		-days 365 -subj "/CN=localhost" || die

	edo ${EPYTHON} ./tests/testserver.py &
	sleep 3

	edo ${EPYTHON} ./tests/testserver.py "${T}" &
	sleep 3

	meson_src_test
}
