# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_10 )

inherit distutils-r1 pypi

DESCRIPTION="Python port of LLVM's FileCheck, flexible pattern matching file verifier"
HOMEPAGE="https://pypi.org/project/filecheck/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
