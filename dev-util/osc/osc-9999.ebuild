# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_9 )
PYTHON_REQ_USE="xml"
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1 shell-completion

DESCRIPTION="Command line tool for Open Build Service"
HOMEPAGE="
	https://en.opensuse.org/openSUSE:OSC
	https://github.com/openSUSE/osc
"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/openSUSE/${PN}.git"
else
	OBS_PROJECT="openSUSE:Tools"
	SRC_URI="https://github.com/openSUSE/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
# Test require config file: osc.oscerr.NoConfigfile
RESTRICT="test"

RDEPEND="
	app-arch/rpm[python,${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '
		dev-python/m2crypto[${PYTHON_USEDEP}]
	')
	${PYTHON_SINGLE_DEPS}
"
BDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/setuptools-scm-1.15.0[${PYTHON_USEDEP}]
	')
	test? (
		${RDEPEND}
		$(python_gen_cond_dep '
			dev-python/path[${PYTHON_USEDEP}]
	')
)"

PATCHES=( "${FILESDIR}"/${PN}-no-man-compression.patch )

distutils_enable_tests pytest
# Bug: https://bugs.gentoo.org/704520
#distutils_enable_sphinx docs dev-python/alabaster

src_install() {
	distutils-r1_src_install

	dosym osc-wrapper.py /usr/bin/osc
	rm -f "${ED}/usr/share/doc/${PN}"*/TODO* || die
	newbashcomp dist/complete.sh "${PN}"
	insinto /usr/lib/osc
	newins dist/osc.complete complete
	newzshcomp "${FILESDIR}/${PN}.zsh_completion" "_${PN}"
	dofishcomp "${PN}.fish"
}
