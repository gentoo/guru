# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )

inherit meson python-single-r1

DESCRIPTION="Script to edit a single file as root using run0"
HOMEPAGE="https://github.com/HastD/run0edit"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/HastD/run0edit.git"
else
	SRC_URI="https://github.com/HastD/run0edit/releases/download/v${PV}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="
	virtual/pandoc
	test? (
		$(python_gen_cond_dep '
			dev-python/coverage[${PYTHON_USEDEP}]
		')
	)
"
RDEPEND="
	${PYTHON_DEPS}
	>=sys-apps/systemd-256:=
"

DOCS=( {CHANGELOG,SECURITY,README}.md )

src_prepare() {
	default

	python_fix_shebang run0edit_main.py.in run0edit_inner.py

	local b2=$(b2sum "${S}"/run0edit_inner.py | cut -d' ' -f1)

	# patch hard-coded variables to work
	sed -i \
		-e "/^INNER_SCRIPT_B2:/{
			N
			s|^.*|INNER_SCRIPT_B2: Final[str] = \"${b2}\"|
		}" \
		run0edit_main.py.in || die
}

src_configure() {
	local emesonargs=(
		$(meson_feature test unit-tests)
		$(meson_feature test integration-tests)
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	rm -r "${ED}"/usr/share/licenses || die
}
