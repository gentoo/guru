# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature readme.gentoo-r1

DESCRIPTION="Automatically creates a timeshift-snapshot when executed"
HOMEPAGE="https://gitlab.com/gobonja/timeshift-autosnap"
SRC_URI="https://gitlab.com/gobonja/timeshift-autosnap/-/archive/${PV}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-backup/timeshift"

PATCHES=( "${FILESDIR}/${PN}-remove-arch-specific.patch" )

bashrc=/etc/portage/bashrc
DISABLE_AUTOFORMATTING=1
DOC_CONTENTS="to run timeshift-autosnap everytime you emerge a package run:
# touch ${bashrc}

# grep -q '#!/bin/' ${bashrc} || awk -i inplace 'BEGINFILE{print '#!/bin/sh'}{print}' ${bashrc}

# grep -q timeshift-autosnap ${bashrc} || echo '
function pre_pkg_setup() {
	/usr/bin/timeshift-autosnap ;
}' >> ${bashrc}"

src_install(){
	dobin timeshift-autosnap
	insinto /etc
	doins timeshift-autosnap.conf
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
	optfeature "grub-btrfs snapshot support" app-backup/grub-btrfs
}
