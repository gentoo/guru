# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="Sweet"

DESCRIPTION="light and dark colorful gtk theme"

HOMEPAGE="https://github.com/EliverLara/Sweet"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/EliverLara/Sweet.git"
else
	COMMIT="9e3bfeeeee44e5acf13b2bb9fcadb45aea75bc05"
	SRC_URI="https://github.com/EliverLara/Sweet/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~ppc-aix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
	S="${WORKDIR}/${MY_PN}-${COMMIT}"
fi

LICENSE="GPL-3"
SLOT="0"

src_install() {
	dodir /usr/share/themes/sweet-gtk
	insinto /usr/share/themes/sweet-gtk
	doins -r Art assets gnome-shell gtk-{2.0,3.0} \
		  metacity-1 src xfwm4 index.theme
}
