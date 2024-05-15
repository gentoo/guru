# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

inherit git-r3 python-single-r1

DESCRIPTION="Pokemon unicode sprites for your terminal!"
HOMEPAGE="https://gitlab.com/phoneybadger/pokemon-colorscripts"
EGIT_REPO_URI="https://gitlab.com/phoneybadger/pokemon-colorscripts.git"

LICENSE="MIT"
SLOT="0"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}"

src_prepare() {
	default
	sed -i \
	's#PROGRAM_DIR = os.path.dirname(PROGRAM)#PROGRAM_DIR = "/opt/pokemon-colorscripts/"#g' \
	pokemon-colorscripts.py || die "sed failed."
}

src_install() {
	insinto /opt/pokemon-colorscripts
	doins -r "${S}/colorscripts"
	doins "${S}/pokemon.json"

	python_scriptinto /opt/pokemon-colorscripts
	python_doscript "${S}/pokemon-colorscripts.py"

	dosym -r /opt/pokemon-colorscripts/pokemon-colorscripts.py /usr/bin/pokemon-colorscripts
}
