# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Safe Password Entry for R, Git and SSH'
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND=">=dev-R/sys-2.1"
RDEPEND="${DEPEND}"
