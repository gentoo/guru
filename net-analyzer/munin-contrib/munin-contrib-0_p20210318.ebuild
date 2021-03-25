# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

COMMIT="7fd554f04b67a985e99f15aa56aa4546d6006f2f"

SRC_URI="https://github.com/munin-monitoring/contrib/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"
DESCRIPTION="user contributed stuff related to munin"
HOMEPAGE="https://github.com/munin-monitoring/contrib"
LICENSE="GPL-3+ Apache-2.0 GPL-2 LGPL-2 GPL-2+ LGPL-3+" #TODO: investigate all the licenses
SLOT="0"
IUSE="examples +plugins templates tools"
RDEPEND="net-analyzer/munin"

S="${WORKDIR}/contrib-${COMMIT}"

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
	insinto "/usr/libexec/munin"
	use tools && doins -r tools
	insinto "/usr/libexec/munin/plugins/contrib"
	use plugins && doins -r plugins
	insinto "/etc/munin/templates"
	use templates && doins -r templates/munstrap
	use examples && dodoc -r samples/munin.conf
	dodoc README.md
}
