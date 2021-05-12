# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

COMMIT="84f6a325fda18678cd08e9c3615d76e747a5ab51"

DESCRIPTION="This package provides various plugins for Munin"
HOMEPAGE="https://github.com/mendix/munin-plugins-mendix"
SRC_URI="https://github.com/mendix/munin-plugins-mendix/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"
KEYWORDS="~amd64"
LICENSE="BSD"
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
