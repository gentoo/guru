# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{7..13} )
DISTUTILS_USE_PEP517=setuptools

inherit readme.gentoo-r1 systemd distutils-r1

DESCRIPTION="A web frontend for the motion daemon, Python 3"
HOMEPAGE="https://github.com/motioneye-project/motioneye"
MY_PV="b5"
SRC_URI="https://github.com/${PN}-project/${PN}/archive/refs/tags/$(ver_cut 1-3)${MY_PV}.tar.gz"
S="${WORKDIR}/${PN}-$(ver_cut 1-3)${MY_PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="dev-python/babel
		dev-python/boto3
		dev-python/jinja2
		dev-python/pillow
		dev-python/pycurl
		dev-python/tornado
		media-video/motion[ffmpeg,v4l]"

DEPEND="${RDEPEND}"

BDEPEND="test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

DISABLE_AUTOFORMATTING="yes"
DOC_CONTENTS="
Motioneye is run under the motion user installed via the media-video/motion package.

Configuration files are under /etc/motioneye and need to be writable by the motion user.
Copy /etc/motioneye/motioneye.conf.sample to /etc/motioneye/motioneye.conf and edit
Logs are located by default under /var/log/motioneye and must be writable by the motion user.
Videos are saved by default under /var/lib/motioneye and must be writable by the motion user.

Web interface
- default listens on 0.0.0.0:8765
- default login user=admin pasword left blank

To install motioneye as a service, use:
- rc-update add motioneye default # with OpenRC
- systemctl enable motioneye.service # with systemd
"
distutils_enable_tests pytest
src_install() {
	distutils-r1_src_install
	diropts -omotion -gmotion
	keepdir /var/lib/${PN}
	keepdir /var/log/${PN}
	dodir /etc/${PN}
	insopts -m 660 -omotion -gmotion
	insinto /etc/${PN}
	doins "$S/${PN}/extra/${PN}.conf.sample"

	newinitd "$S/${PN}/extra/${PN}.sysv" "${PN}"
	systemd_newunit "$S/${PN}/extra/${PN}.systemd" "${PN}.service"
	readme.gentoo_create_doc
}

pkg_postinst () {
	readme.gentoo_print_elog
}
