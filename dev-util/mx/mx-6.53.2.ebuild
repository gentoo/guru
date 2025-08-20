# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..14} )

inherit python-single-r1

DESCRIPTION="Command-line tool used for the development of Graal projects"
HOMEPAGE="https://github.com/graalvm/mx"
SRC_URI="https://github.com/graalvm/mx/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
RDEPEND="${PYTHON_DEPS}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
KEYWORDS="~amd64"

src_install() {
	SITE_PKG="$(python_get_sitedir)/${PN}"
	python_moduleinto ${SITE_PKG}
	python_domodule *
	chmod 0755 "${D}/${SITE_PKG}/mx" || die "Failed to chmod mx executable"
	dosym "${SITE_PKG}/mx" "/usr/bin/${PN}" || die "Failed to install mx symlink in /usr/bin"
}
