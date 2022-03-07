# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Basic R Input Output'
KEYWORDS="~amd64"
LICENSE='MIT'

SUGGESTED_PACKAGES="
	dev-R/covr
	>=dev-R/testthat-2.1.0
"
