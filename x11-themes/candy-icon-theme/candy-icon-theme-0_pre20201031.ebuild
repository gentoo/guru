# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="candy-icons"

DESCRIPTION="sweet gradient icons"

HOMEPAGE="https://github.com/EliverLara/candy-icons"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/EliverLara/candy-icons.git"
else
	COMMIT="4c80adb4630fb75c16ce2c94be7614e6d45f35ba"
	SRC_URI="https://github.com/EliverLara/candy-icons/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~ppc-aix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
	S="${WORKDIR}/${MY_PN}-${COMMIT}"
fi

LICENSE="GPL-3"
SLOT="0"

# dead symbolic links QA
src_prepare() {
	default
	find . -xtype l -delete || die
}

src_install() {
	dodir /usr/share/icons/candy-icons
	insinto /usr/share/icons/candy-icons
	doins -r index.theme apps devices places preferences preview
}
