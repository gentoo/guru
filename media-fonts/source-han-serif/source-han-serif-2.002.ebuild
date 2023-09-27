# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

# NOTE: There is a zh_HK version, but to use that zh_HK has to be added to
#       profiles/desc/l10n.desc in ::gentoo, as far as i'm aware.

DESCRIPTION="Pan-CJK OpenType/CFF font family"
HOMEPAGE="https://github.com/adobe-fonts/source-han-serif/"
SRC_URI="
	l10n_ja? ( https://github.com/adobe-fonts/${PN}/releases/download/${PV}R/12_SourceHanSerifJP.zip -> ${PN}-ja-${PV}.zip )
	l10n_ko? ( https://github.com/adobe-fonts/${PN}/releases/download/${PV}R/13_SourceHanSerifKR.zip -> ${PN}-ko-${PV}.zip )
	l10n_zh-CN? ( https://github.com/adobe-fonts/${PN}/releases/download/${PV}R/14_SourceHanSerifCN.zip -> ${PN}-zh_CN-${PV}.zip )
	l10n_zh-TW? ( https://github.com/adobe-fonts/${PN}/releases/download/${PV}R/15_SourceHanSerifTW.zip -> ${PN}-zh_TW-${PV}.zip )
"
S=${WORKDIR}

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x64-macos"
IUSE="l10n_ja l10n_ko +l10n_zh-CN l10n_zh-TW"
REQUIRED_USE="|| ( l10n_ja l10n_ko l10n_zh-CN l10n_zh-TW )"

FONT_SUFFIX="otf"
RESTRICT="binchecks strip"

BDEPEND="app-arch/unzip"

src_install() {
	use l10n_ja && FONT_S="${S}/SubsetOTF/JP" font_src_install
	use l10n_ko && FONT_S="${S}/SubsetOTF/KR" font_src_install
	use l10n_zh-CN && FONT_S="${S}/SubsetOTF/CN" font_src_install
	use l10n_zh-TW && FONT_S="${S}/SubsetOTF/TW" font_src_install
}
