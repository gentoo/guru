# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://gitlab.com/dslackw/${PN}"
case "${PV}" in
	9999)
		inherit git-r3
		;;
	*)
		SRC_URI="${EGIT_REPO_URI}/-/archive/${PV}/${P}.tar.gz"
		KEYWORDS="~amd64"
esac

PYTHON_COMPAT=( python3_{6,7,8,9} )
inherit distutils-r1

DESCRIPTION="Very simple Python library for color and formatting in terminal"
HOMEPAGE="${EGIT_REPO_URI}"
LICENSE="MIT"

SLOT="0"
