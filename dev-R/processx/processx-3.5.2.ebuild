# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Execute and Control System Processes'
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="
	>=dev-R/ps-1.2.0
	dev-R/R6
"
RDEPEND="${DEPEND}"
