# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 bash-completion-r1

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/csfore/gentodo.git"
else
	SRC_URI="https://github.com/csfore/gentodo/releases/download/${PV}/gentodo-${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

HOMEPAGE="https://github.com/csfore/gentodo"
DESCRIPTION="Todo program to help enhance your Gentoo workflow"

LICENSE="GPL-3"
SLOT="0"

IUSE="bash-completion"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPENDS="
	${PYTHON_DEPS}
"
DEPEND="
	${PYTHON_DEPS}
"
RDEPEND="
	${PYTHON_DEPS}
	dev-python/python-bugzilla
"

python_install_all() {
	if use bash-completion; then
		newbashcomp src/gentodo/gentodo-completions.bash gentodo
	fi
	distutils-r1_python_install_all
}
