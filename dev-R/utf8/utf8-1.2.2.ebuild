# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages toolchain-funcs

HOMEPAGE="
	https://github.com/patperry/r-utf8
	https://cran.r-project.org/package=utf8
"
DESCRIPTION='Unicode Text Processing'
LICENSE='Apache-2.0'
KEYWORDS="~amd64"
DEPEND=">=dev-lang/R-2.1.0"
RDEPEND="${DEPEND}"

src_prepare() {
	tc-export AR
	R-packages_src_prepare
}
