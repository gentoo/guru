# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..14} )

inherit git-r3 python-r1

EGIT_REPO_URI="https://github.com/graalvm/mx.git"
DESCRIPTION="Command-line tool used for the development of Graal projects"
HOMEPAGE="https://github.com/graalvm/mx"
LICENSE="GPL-2+"
SLOT="0"
RDEPEND="${PYTHON_DEPS}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_unpack() {
	git-r3_src_unpack || die "Failed to clone git repo"
	if [ -d "${S}/.git" ]; then
		rm -rf "${S}/.git" || die "Failed to remove .git in ${S}"
	fi
}

src_install() {
	einfo "Installing ${PN} into /opt/${PN}"
	insinto /opt/${PN}
	doins -r "${S}/." || die "Failed to copy repository to /opt/${PN}"
	if [ -f "${D}/opt/${PN}/mx" ]; then
		chmod 0755 "${D}/opt/${PN}/mx" || die "Failed to chmod mx executable"
	fi
	dosym /opt/${PN}/mx /usr/bin/mx
}
