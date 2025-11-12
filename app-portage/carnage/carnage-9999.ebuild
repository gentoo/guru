# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature desktop xdg

DESCRIPTION="TUI front-end for Portage and eix"
HOMEPAGE="https://github.com/dsafxP/carnage"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dsafxP/carnage.git"
else
	SRC_URI="https://github.com/dsafxP/carnage/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

IUSE="man"

RDEPEND="
	>=dev-python/lxml-6.0.2[${PYTHON_USEDEP}]
	>=dev-python/msgpack-1.1.2[${PYTHON_USEDEP}]
	>=dev-python/textual-6.6.0[${PYTHON_USEDEP}]
	>=dev-python/tomlkit-0.13.3[${PYTHON_USEDEP}]
"

BDEPEND="
	man? (
		|| (
			app-text/lowdown
			virtual/pandoc
		)
	)
"

python_compile() {
	distutils-r1_python_compile

	if use man; then
		local docgen=lowdown

		# prefer pandoc if it's installed
		has_version virtual/pandoc && docgen=pandoc

		"${docgen}" docs/man.carnage.md -s -t man -o docs/carnage.1 \
			|| die "Failed to generate man page with ${docgen}"
	fi
}

src_install() {
	distutils-r1_src_install

	domenu assets/carnage.desktop

	doicon -s scalable assets/carnage.svg

	use man && doman docs/carnage.1
}

pkg_postinst() {
	optfeature "package & use flag browsing" app-portage/eix
}
