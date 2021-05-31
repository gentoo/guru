# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='GitHub API'
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="
	>=dev-R/cli-2.0.1
	>=dev-R/httr-1.2
	dev-R/jsonlite
	dev-R/ini
	dev-R/gitcreds
"
RDEPEND="${DEPEND}"
