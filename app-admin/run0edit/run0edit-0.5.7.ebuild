# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
inherit python-single-r1

DESCRIPTION="Script to edit a single file as root using run0"
HOMEPAGE="https://github.com/HastD/run0edit"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/HastD/run0edit.git"
else
	SRC_URI="https://github.com/HastD/run0edit/releases/download/v${PV}/run0edit-${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RDEPEND="
	${PYTHON_DEPS}
	>=sys-apps/systemd-256:=
"

DOCS=( {CHANGELOG,SECURITY,README}.md )

src_prepare() {
	default

	mv run0edit_main.py run0edit || die

	python_fix_shebang run0edit run0edit_inner.py

	local b2=$(b2sum "${S}"/run0edit_inner.py | cut -d' ' -f1)
	local sitedir=$(python_get_sitedir)

	# patch hard-coded variables to work
	sed -i \
		-e "s|^INNER_SCRIPT_PATH:.*|INNER_SCRIPT_PATH: Final[str] = \"${sitedir}/run0edit_inner.py\"|" \
		-e "/^INNER_SCRIPT_B2:/{
			N
			s|^.*|INNER_SCRIPT_B2: Final[str] = \"${b2}\"|
		}" \
		run0edit || die
}

src_install() {
	python_domodule run0edit_inner.py

	python_doscript run0edit

	einstalldocs

	# setup editor.conf
	dodir /etc/"${PN}"
	echo "$(which ${EDITOR})" >> "${ED}"/etc/"${PN}"/editor.conf || die
}
