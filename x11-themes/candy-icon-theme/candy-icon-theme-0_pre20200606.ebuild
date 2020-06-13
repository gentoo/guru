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
	COMMIT="1b69d37f6ffecf04d4029ee6fa1d72c2f5875a92"
	SRC_URI="https://github.com/EliverLara/candy-icons/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~ppc-aix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
	S="${WORKDIR}/${MY_PN}-${COMMIT}"
fi

LICENSE="GPL-3"
SLOT="0"

# dead symbolic links QA
src_prepare() {
	find . -xtype l -delete || die
}

src_install() {
	dodir /usr/share/icons/candy-icons
	insinto /usr/share/icons/candy-icons
	doins -r index.theme preview places apps
}
