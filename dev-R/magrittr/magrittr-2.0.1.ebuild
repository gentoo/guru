# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages

DESCRIPTION='A Forward-Pipe Operator for R'
LICENSE='MIT'
KEYWORDS="~amd64"

DEPEND="
	>=dev-lang/R-3.3
	dev-R/glue
	>=dev-R/rlang-0.4.10
"
RDEPEND="${DEPEND}"
