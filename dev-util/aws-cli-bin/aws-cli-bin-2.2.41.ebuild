# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN_BASE="$(ver_cut 1 ${PN})"
MY_PN="${MY_PN_BASE}$(ver_cut 2 ${PN})"

DESCRIPTION="A unified command line interface to Amazon Web Services"
HOMEPAGE="https://aws.amazon.com/cli/"
SRC_URI="https://awscli.amazonaws.com/${MY_PN}-exe-linux-x86_64-${PV}.zip -> ${P}.zip"

LICENSE="Apache-2.0 MIT LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="!!app-admin/awscli"
BDEPEND="app-arch/unzip"

S="${WORKDIR}/${MY_PN_BASE}"

src_install() {
	local install_dir="${D}/${EPREFIX}/opt/${PN}"

	./install -i ${install_dir} -b "${D}/${EPREFIX}/usr/bin"
}
