# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="Sweet-folders"

DESCRIPTION="sweet gradient icons"

HOMEPAGE="https://github.com/EliverLara/Sweet-folders"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/EliverLara/Sweet-folders.git"
else
	COMMIT="d50fbe3d93df4c494958c773b681ab36049935a1"
	SRC_URI="https://github.com/EliverLara/Sweet-folders/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~ppc-aix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
	S="${WORKDIR}/${MY_PN}-${COMMIT}"
fi

LICENSE="GPL-3"
SLOT="0"

src_install() {
	insinto /usr/share/icons/
	doins -r Sweet-*
}
