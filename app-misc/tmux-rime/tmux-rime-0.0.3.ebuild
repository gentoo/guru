# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="rime for tmux"
HOMEPAGE="https://github.com/Freed-Wu/tmux-rime"

_VERSION=9e39ee6a9c9a4c43192b95b7efcc95ea1c79a28d
# xmake needs xmake-repo to map a package to a pkg-config file name
SRC_URI="
	$HOMEPAGE/archive/${PV}.tar.gz -> $P.tar.gz
	https://github.com/xmake-io/xmake-repo/archive/$_VERSION.tar.gz -> xmake-repo-$_VERSION.tar.gz
"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

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
	HOME="$T" PATH="$T:$PATH"
	# create a fake git to make xmake happy
	echo -e "#!$SHELL\necho I am git" > "$T/git" || die
	chmod +x "$T/git" || die
	# put xmake-repo to a correct position
	install -d "$HOME/.xmake/repositories" || die
	ln -sf "$WORKDIR/xmake-repo-$_VERSION" "$HOME/.xmake/repositories/xmake-repo" || die

	xmake g --network=private || die 'fail to set private network'
	xmake f --verbose || die 'fail to increase verbosity'
}

src_compile() {
	xmake || die 'fail to compile'
}

src_install() {
	xmake install -o "$ED/usr" || die 'fail to install'
}
