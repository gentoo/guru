# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION=""
HOMEPAGE="https://github.com/Freed-Wu/$PN"

_VERSION=9e39ee6a9c9a4c43192b95b7efcc95ea1c79a28d
SRC_URI="
		 $HOMEPAGE/archive/${PV}.tar.gz -> $P.tar.gz
		 https://github.com/xmake-io/xmake-repo/archive/$_VERSION.tar.gz -> xmake-repo-$_VERSION.tar.gz
"
KEYWORDS="~amd64"


LICENSE="GPL-3"
SLOT="0"

DEPEND="
        app-i18n/librime
        dev-libs/glib
"

BDEPEND="
         dev-build/xmake
"

RDEPEND="
         $DEPEND
         app-misc/tmux
"

export XMAKE_ROOT=y

src_configure() {
	# https://github.com/xmake-io/xmake/discussions/5699
	HOME=$T PATH=$T:$PATH
	echo -e "#!$SHELL\necho I am git" >$T/git
	chmod +x $T/git
	install -d $HOME/.xmake/repositories
	ln -sf "$WORKDIR/xmake-repo-$_VERSION" $HOME/.xmake/repositories/xmake-repo

	xmake g --network=private
	xmake f --verbose
}

src_compile() {
	xmake
}

src_install() {
	xmake install -o $ED/usr
}
