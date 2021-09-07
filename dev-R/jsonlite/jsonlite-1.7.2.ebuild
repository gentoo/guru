# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages toolchain-funcs

DESCRIPTION='A Simple and Robust JSON Parser and generator for R'
KEYWORDS="~amd64"
LICENSE='MIT'

#unbundling status: https://github.com/jeroen/jsonlite/issues/201
src_prepare() {
	tc-export AR
	R-packages_src_prepare
}
