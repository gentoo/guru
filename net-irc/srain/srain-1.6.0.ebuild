# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} pypy3 )
inherit meson python-any-r1 xdg

DESCRIPTION="Modern, beautiful IRC client written in GTK+ 3"
HOMEPAGE="https://github.com/SrainApp/srain"
SRC_URI="https://github.com/SrainApp/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="appindicator doc man"

RDEPEND="
	app-crypt/libsecret
	dev-libs/glib:2
	dev-libs/libconfig:=
	dev-libs/openssl:=
	net-libs/libsoup:2.4
	x11-libs/gtk+:3
	appindicator? ( dev-libs/libayatana-appindicator )
"

DEPEND="${RDEPEND}"
BDEPEND="
	doc? ( $(python_gen_any_dep '
		dev-python/sphinx[${PYTHON_USEDEP}]' ) )
	man? ( $(python_gen_any_dep '
		dev-python/sphinx[${PYTHON_USEDEP}]' ) )
	${PYTHON_DEPS}
"

python_check_deps() {
	if use doc || use man; then
		python_has_version -b "dev-python/sphinx[${PYTHON_USEDEP}]"
	fi
}

src_prepare() {
	default

	sed "s/\('doc'\), meson.project_name()/\1, '${PF}'/" \
		-i meson.build || die
}

src_configure() {
	local -a doc_builders=()
	use doc && doc_builders+=( html )
	use man && doc_builders+=( man )

	local emesonargs=(
		-Ddoc_builders="$(meson-format-array "${doc_builders[@]}")"
		$(meson_use appindicator app_indicator)
	)
	meson_src_configure
}
