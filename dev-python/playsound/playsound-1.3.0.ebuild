# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_10 pypy3 )
inherit distutils-r1 pypi

DESCRIPTION="Single function module with no dependencies for playing sounds."
HOMEPAGE="https://pypi.org/project/playsound/ https://github.com/TaylorSMarks/playsound"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

DEPEND="${RDEPEND}"
