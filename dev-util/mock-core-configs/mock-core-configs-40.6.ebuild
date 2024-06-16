# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P=${P}-1

DESCRIPTION="Mock core config files basic chroots"
HOMEPAGE="https://rpm-software-management.github.io/mock/ https://github.com/rpm-software-management/mock"
SRC_URI="https://github.com/rpm-software-management/mock/archive/refs/tags/${MY_P}.tar.gz"
S="${WORKDIR}/mock-${MY_P}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	insinto /etc/mock
	doins -r ${PN}/etc/mock/*
}
