# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# Credits to shurutov, inspired by https://forums.gentoo.org/viewtopic-t-1045122-view-previous.html

EAPI=8

inherit systemd

DESCRIPTION="PowerPanel software for CyberPower UPS systems"
HOMEPAGE="https://www.cyberpowersystems.com/"
SRC_URI="x86? ( https://dl4jz3rbrsfum.cloudfront.net/software/PPL_32bit_v${PV}.tar.gz -> ${P}.tar.gz )
	amd64? ( https://dl4jz3rbrsfum.cloudfront.net/software/PPL_64bit_v${PV}.tar..gz -> ${P}.tar.gz )"

LICENSE="PowerPanel"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="${DEPEND}
	dev-libs/json-c
	virtual/libusb
	|| (
		dev-libs/openssl-compat:1.1.1
		dev-libs/openssl:0/1.1
	)
"
QA_FLAGS_IGNORED="usr/sbin/pwrstat usr/sbin/pwrstatd usr/lib64/libpaho-mqtt3cs.so.1"
PATCHES=(
	"${FILESDIR}/${PN}-scripts.patch"
)

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

	exeinto /opt/${PN}
	doexe script/pwrstatd-powerfail.sh
	doexe script/pwrstatd-lowbatt.sh
	doexe script/pwrstatd-email.sh
	doexe script/shutdown.sh
	doexe script/hibernate.sh

	newlib.so lib/libpaho-mqtt3cs.so.1.3.1 libpaho-mqtt3cs.so.1

	newinitd "${FILESDIR}/pwrstatd" pwrstatd
	systemd_dounit script/pwrstatd.service
	systemd_newunit script/default_pwrstatd pwrstatd

	fowners root:root /usr/sbin/pwrstat
	fowners root:root /usr/sbin/pwrstatd
	fowners root:root /opt/${PN}/pwrstatd-powerfail.sh
	fowners root:root /opt/${PN}/pwrstatd-lowbatt.sh
	fowners root:root /opt/${PN}/pwrstatd-email.sh
	fowners root:root /opt/${PN}/shutdown.sh
	fowners root:root /opt/${PN}/hibernate.sh
	fowners root:root /etc/init.d/pwrstatd
	fowners root:root /etc/pwrstatd.conf

	fperms 700 /usr/sbin/pwrstat
	fperms 700 /usr/sbin/pwrstatd
	fperms 755 /opt/${PN}/pwrstatd-powerfail.sh
	fperms 755 /opt/${PN}/pwrstatd-lowbatt.sh
	fperms 755 /opt/${PN}/pwrstatd-email.sh
	fperms 755 /opt/${PN}/shutdown.sh
	fperms 755 /opt/${PN}/hibernate.sh
	fperms 755 /etc/init.d/pwrstatd
	fperms 755 /etc/pwrstatd.conf
}
