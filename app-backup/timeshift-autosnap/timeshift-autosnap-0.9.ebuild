# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Automatically creats a snapshot everytime before portage installs a package"
HOMEPAGE="https://gitlab.com/gobonja/timeshift-autosnap"
SRC_URI="https://gitlab.com/gobonja/timeshift-autosnap/-/archive/${PV}/{$P}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
        app-backup/timeshift
        >=sys-apps/portage-2.1
"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=( "${FILESDIR}/${PN}-remove-arch-specific.patch" )

src_unpack() {
        default
	mv ${WORKDIR}/timeshift-autosnap-${PV}* ${WORKDIR}/timeshift-autosnap-${PV}
}

src_compile(){
	true
}

src_install(){
	dobin timeshift-autosnap
	insinto /etc
	doins timeshift-autosnap.conf
}

pkg_postinst() {
	touch /etc/portage/bashrc
        grep -q  '#!/bin/' /etc/portage/bashrc || awk -i inplace 'BEGINFILE{print "#!/bin/sh"}{print}' /etc/portage/bashrc
        grep -q 'timeshift-autosnap' /etc/portage/bashrc || echo 'function pre_pkg_setup() { /usr/bin/timeshift-autosnap ; }' >> /etc/portage/bashrc
}
