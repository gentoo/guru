# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit readme.gentoo-r1

DESCRIPTION="Automatically creates a timeshift-snapshot when executed"
HOMEPAGE="https://gitlab.com/gobonja/timeshift-autosnap"
SRC_URI="https://gitlab.com/gobonja/timeshift-autosnap/-/archive/${PV}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	app-backup/timeshift
	>=sys-apps/portage-2.1
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-remove-arch-specific.patch" )

DISABLE_AUTOFORMATTING=1
DOC_CONTENTS='to run timeshift-autosnap everytime you emerge a package run:
$ touch /etc/portage/bashrc
$ grep -q  "#!/bin/" /etc/portage/bashrc || awk -i inplace "BEGINFILE{print "#!/bin/sh"}{print}" /etc/portage/bashrc
$ grep -q timeshift-autosnap /etc/portage/bashrc || echo "function pre_pkg_setup() { /usr/bin/timeshift-autosnap ; }" >> /etc/portage/bashrc'

src_unpack() {
	default
	mv "${WORKDIR}"/timeshift-autosnap-${PV}* "${WORKDIR}"/timeshift-autosnap-${PV} || die
}

src_compile(){
	:
}

src_install(){
	dobin timeshift-autosnap
	insinto /etc
	doins timeshift-autosnap.conf
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
