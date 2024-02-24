# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit python-single-r1 optfeature wrapper

DESCRIPTION="Modular visual interface for GDB in Python"
HOMEPAGE="https://github.com/cyrus-and/gdb-dashboard"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cyrus-and/gdb-dashboard"
else
	SRC_URI="https://github.com/cyrus-and/gdb-dashboard/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-debug/gdb[python]"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_install() {
	insinto "/usr/share/${PN}"
	newins .gdbinit "${PN}"

	# install a convenient wrapper. disables any typical .gdbinit (-nh) to
	# get a clean state without interference. -q to disable annoying
	# copyright message at startup.
	make_wrapper "$PN" "gdb -q -nh -iex 'source /usr/share/${PN}/${PN}'"

	dodoc README.md
}

pkg_postinst() {
	einfo "To use ${PN}:"
	einfo "    Either use the installed '${PN}' wrapper script directly."
	einfo "    Or put 'source /usr/share/${PN}/${PN}' in your .gdbinit file."
	einfo ""

	optfeature "syntax highlighting" "dev-python/pygments"
}
