# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="OieIcons Theme"

HOMEPAGE="https://www.opencode.net/adhe/oieicons"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://www.opencode.net/adhe/oieicons.git"
else
	COMMIT="2231c0d5e578933d9803b8e77701de67d88c2e92"
	SRC_URI="https://www.opencode.net/adhe/oieicons/-/archive/${COMMIT}/oieicons-${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~ppc-aix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
	S="${WORKDIR}/oieicons-${COMMIT}"
fi

LICENSE="GPL-3"
SLOT="0"

# dead symbolic links QA
src_prepare() {
	default
	find . -xtype l -delete || die
}

src_install() {
	cd OieIcons
	insinto /usr/share/icons/OieIcons
	doins -r index.theme scalable
}
