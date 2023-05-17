# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Dynamic Kernel Module Support"
HOMEPAGE="https://github.com/dell/dkms"
LICENSE="GPL-2"
DEPEND=""
KEYWORDS="~amd64 ~arm64 ~x86"
SLOT="0"
IUSE="kernel-hooks"

SRC_URI="https://github.com/dell/dkms/archive/v${PV}.tar.gz -> ${P}.tar.gz"
DOCS=( AUTHORS sample.conf sample.spec )

src_prepare() {
	#Removing gzip compressions in Makefile
	sed -i '/dkms.8.gz/d' "${S}"/Makefile
	default
}

src_compile() {
	einfo "Skipping compilation"
}

src_install() {
	emake install DESTDIR="${D}" LIBDIR="${D}"/usr/$(get_libdir)/

	keepdir /var/lib/dkms
	insinto /var/lib/dkms
	doins dkms_dbversion

	keepdir /etc/dkms
	doins template-dkms-mkrpm.spec

	einstalldocs
	if use kernel-hooks; then
		einfo "You're installed kernel hooks that automatically rebuild your modules"
	else rm -r "${D}"/etc/kernel/;
	fi

	ewarn "DKMS might say about missing headers even if sys-kernel/linux-headers installed"
	ewarn "Just don't keep attention, that don't affect anything"
}
