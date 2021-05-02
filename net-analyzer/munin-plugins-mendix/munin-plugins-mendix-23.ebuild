# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="This package provides various plugins for Munin"
HOMEPAGE="https://github.com/mendix/munin-plugins-mendix"
SRC_URI="https://github.com/mendix/munin-plugins-mendix/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"
LICENSE="all-rights-reserved" #https://github.com/mendix/munin-plugins-mendix/issues/10
SLOT="0"
RDEPEND="net-analyzer/munin"

src_prepare() {
	default
}

src_configure() {
	return
}

src_compile() {
	return
}

src_install() {
	#install plugins without getting mad at preserving exec bit
	mkdir -p "${ED}/usr/libexec/munin/plugins/mendix" || die
	mv plugins/* "${ED}/usr/libexec/munin/plugins/mendix" || die

	insinto "/etc/munin/plugin-conf.d/"
	doins -r plugin-conf/*
}
