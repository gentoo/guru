# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )
inherit python-single-r1

DESCRIPTION="A simple bash + python script to restore your i3 session"
HOMEPAGE="https://github.com/jdholtz/i3-restore/"
SRC_URI="https://github.com/jdholtz/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	x11-wm/i3
	"${PYTHON_DEPS}"
"
DEPEND="
	x11-misc/xdotool
	app-misc/jq
	$(python_gen_cond_dep \
	'dev-python/psutil[${PYTHON_USEDEP}]' )
"

src_prepare() {
	sed -i 's#CURR_DIR="$(dirname "${0}")"#CURR_DIR=/usr/libexec/i3-restore#' i3-save i3-restore || die "Sed error"
	sed -i "s/version=.*/version=${PV}/" utils/common.bash
	default
}

src_install() {
	keepdir /usr/libexec/${PN}/logs || die
	fperms 777 /usr/libexec/${PN}/logs || die

	insinto "/usr/libexec/${PN}"
	doins -r utils
	dobin i3-save
	dobin i3-restore

	python_moduleinto "/usr/libexec/${PN}"
	python_domodule programs
}

pkg_postinst() {
	elog "Usage: i3-save and i3-restore"
	elog "See the documentation about automatic saving and restoring https://github.com/jdholtz/i3-restore/?tab=readme-ov-file#automating-the-script"
	elog "Alternative software: https://github.com/JonnyHaystack/i3-resurrect"
}
