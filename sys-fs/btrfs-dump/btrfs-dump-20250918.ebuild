# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Metadata dumper for btrfs"
HOMEPAGE="https://github.com/maharmstone/btrfs-dump"

SRC_URI="https://github.com/maharmstone/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64"

BDEPEND="sys-apps/util-linux"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	cmake_src_configure
}
