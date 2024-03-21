# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10,11} )
PYTHON_REQ_USE="xml(+)"

inherit python-r1 systemd

DESCRIPTION="A Web Service Discovery host daemon."
HOMEPAGE="https://github.com/christgau/wsdd"
SRC_URI="https://github.com/christgau/wsdd/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="samba"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# Samba is technically not a requirement of wsdd, but depend on it if the use flags is set.
RDEPEND="${PYTHON_DEPS} acct-group/${PN} acct-user/${PN} samba? ( net-fs/samba )"

src_install() {
	python_foreach_impl python_newscript src/wsdd.py wsdd

	# remove dependency on samba from init.d script if samba is not in use flags
	if ! use samba ; then
		sed -i -e '/need samba/d' etc/openrc/init.d/wsdd || die
	fi

	sed -i -e "s/daemon:daemon/${PN}:${PN}/" etc/openrc/init.d/wsdd || die

	doinitd etc/openrc/init.d/wsdd
	doconfd etc/openrc/conf.d/wsdd

	# install systemd unit file with dependency on samba service if use flag is set
	if use samba; then
		sed -i -e 's/;Wants=smb.service/Wants=samba.service/' etc/systemd/wsdd.service || die
	fi
	systemd_dounit etc/systemd/wsdd.service

	dodoc README.md
	doman man/wsdd.1
}
