# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A jq implementation for emojify"
HOMEPAGE="https://github.com/Freed-Wu/jq-emojify"

_VERSION=4.1.0
SRC_URI="
	$HOMEPAGE/archive/${PV}.tar.gz -> jq-$P.tar.gz
	https://github.com/github/gemoji/archive/v$_VERSION.tar.gz -> gemoji-$_VERSION.tar.gz
"
S="${WORKDIR}/jq-${P}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	app-misc/jq
"

BDEPEND="
	app-misc/jq
"

src_prepare() {
	default
	sed -i "s=/usr=$EPREFIX/usr=g" emojify scripts/generate-emoji.jq.jq
}

src_compile() {
	scripts/generate-emoji.jq.jq "../gemoji-$_VERSION/db/emoji.json" > emoji.jq
}

src_install() {
	insinto /usr/lib/jq
	doins emoji.jq
	dobin emojify
}
