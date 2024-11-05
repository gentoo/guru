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
KEYWORDS="~amd64 ~arm ~arm64 ~x86 ~arm64-macos ~x64-macos"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
         app-misc/jq
"

BDEPEND="
         app-misc/jq
"

src_prepare() {
	default
	sed -i s=/usr=$EPREFIX/usr=g emojify scripts/generate-emoji.jq.jq
}

src_install() {
	install -d "$ED/usr/lib/jq"
	scripts/generate-emoji.jq.jq ../gemoji-$_VERSION/db/emoji.json > "$ED/usr/lib/jq/emoji.jq"
	install -D emojify -t "$ED/usr/bin"
}
