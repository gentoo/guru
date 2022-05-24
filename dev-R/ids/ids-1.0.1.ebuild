# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Generate Random Identifiers'
HOMEPAGE="
	https://github.com/richfitz/ids
	https://cran.r-project.org/package=ids
"

KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="
	dev-R/openssl
	dev-R/uuid
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/knitr
	dev-R/rcorpora
	dev-R/rmarkdown
	dev-R/testthat
"
