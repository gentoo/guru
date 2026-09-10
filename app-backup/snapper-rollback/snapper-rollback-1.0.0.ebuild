# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit python-single-r1

DESCRIPTION="Rollback to a snapper btrfs snapshot using the flat subvolume layout"
HOMEPAGE="https://github.com/jrabinow/snapper-rollback"
SRC_URI="https://github.com/jrabinow/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/btrfsutil[${PYTHON_USEDEP}]
	')
	app-backup/snapper
"

src_prepare() {
	default

	# python_fix_shebang cannot parse "env -S python3", so drop the -S flag.
	sed -i -e '1s|/usr/bin/env -S python3|/usr/bin/env python3|' "${PN}.py" || die
}

src_install() {
	newsbin "${PN}.py" "${PN}"
	python_fix_shebang "${ED}/usr/sbin/${PN}"

	insinto /etc
	doins "${PN}.conf"

	einstalldocs
}
