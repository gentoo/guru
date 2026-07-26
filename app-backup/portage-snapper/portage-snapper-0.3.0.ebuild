# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Snapper snapshots around Portage transactions, snap-pac style"
HOMEPAGE="https://github.com/ursm/portage-snapper"
SRC_URI="https://github.com/ursm/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-backup/snapper"

src_install() {
	emake DESTDIR="${D}" install
	einstalldocs
}

pkg_postinst() {
	elog "The scripts are installed, but /etc/portage/ is left untouched."
	elog "Enable portage-snapper manually:"
	elog
	elog "  1. Add to /etc/portage/bashrc:"
	elog "       source /usr/share/portage-snapper/hook.bash"
	elog
	elog "  2. Point /etc/portage/bin/post_emerge at it, e.g. as a symlink:"
	elog "       ln -s /usr/share/portage-snapper/post_emerge /etc/portage/bin/post_emerge"
	elog "     or call it from your own post_emerge wrapper."
	elog
	elog "Tune behavior in /etc/portage-snapper.conf. A configured snapper config"
	elog "is required (default: root)."
}
