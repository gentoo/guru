# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=(python3_{8,9,10})

inherit git-r3 python-single-r1

DESCRIPTION="Pokemon unicode sprites for your terminal!"

HOMEPAGE="https://gitlab.com/phoneybadger/pokemon-colorscripts"

EGIT_REPO_URI="https://gitlab.com/phoneybadger/pokemon-colorscripts.git"

LICENSE="MIT"

SLOT="0"

KEYWORDS="~amd64"

RDEPEND=">=dev-lang/python-3.10.8_p1"

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
