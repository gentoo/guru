# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# Credits to shurutov, inspired by https://forums.gentoo.org/viewtopic-t-1045122-view-previous.html

EAPI=8

DESCRIPTION="PowerPanel software for CyberPower UPS systems"
HOMEPAGE="https://www.cyberpowersystems.com/"
SRC_URI="x86? ( https://dl4jz3rbrsfum.cloudfront.net/software/PPL_32bit_v${PV}.tar.gz -> ${P}.tar.gz )
	amd64? ( https://dl4jz3rbrsfum.cloudfront.net/software/PPL_64bit_v${PV}.tar..gz -> ${P}.tar.gz )"

LICENSE="PowerPanel"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd"

DEPEND=""
RDEPEND="${DEPEND}
	dev-libs/json-c
	dev-libs/openssl
	virtual/libusb"
BDEPEND=""
QA_FLAGS_IGNORED="CFLAGS LDFLAGS"

src_install() {
	dosbin bin/pwrstat
	dosbin bin/pwrstatd

	doman doc/pwrstat.8
	doman doc/pwrstatd.8

	dodoc doc/README
	dodoc doc/LICENSE
	dodoc doc/user-manual
	dodoc doc/install-guide
	dodoc doc/deploy-guide

	insinto /etc
	doins conf/pwrstatd.conf

	exeinto /etc
	doexe script/pwrstatd-powerfail.sh
	doexe script/pwrstatd-lowbatt.sh
	doexe script/pwrstatd-email.sh
	doexe script/shutdown.sh
	doexe script/hibernate.sh

	newlib.so lib/libpaho-mqtt3cs.so.1.3.1 libpaho-mqtt3cs.so.1

	if use systemd; then
		insinto /usr/lib/systemd/system/
		doins script/pwrstatd.service
		newinitd script/default_pwrstatd pwrstatd
	else
		newinitd ${FILESDIR}/pwrstatd pwrstatd
	fi

	fowners root:root /usr/sbin/pwrstat
	fowners root:root /usr/sbin/pwrstatd
	fowners root:root /etc/pwrstatd-powerfail.sh
	fowners root:root /etc/pwrstatd-lowbatt.sh
	fowners root:root /etc/pwrstatd-email.sh
	fowners root:root /etc/shutdown.sh
	fowners root:root /etc/hibernate.sh
	fowners root:root /etc/init.d/pwrstatd
	fowners root:root /etc/pwrstatd.conf

	fperms 700 /usr/sbin/pwrstat
	fperms 700 /usr/sbin/pwrstatd
	fperms 755 /etc/pwrstatd-powerfail.sh
	fperms 755 /etc/pwrstatd-lowbatt.sh
	fperms 755 /etc/pwrstatd-email.sh
	fperms 755 /etc/shutdown.sh
	fperms 755 /etc/hibernate.sh
	fperms 755 /etc/init.d/pwrstatd
	fperms 755 /etc/pwrstatd.conf
}

pkg_postinst() {
	if use systemd; then
		systemctl daemon-reload
	fi
}
