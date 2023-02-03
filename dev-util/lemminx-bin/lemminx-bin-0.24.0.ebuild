# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="XML Language Server"
HOMEPAGE="https://github.com/eclipse/lemminx"
SRC_URI="https://github.com/redhat-developer/vscode-xml/releases/download/${PV}/lemminx-linux.zip -> ${P}.zip"
S="${WORKDIR}"

LICENSE="EPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="app-arch/unzip"

QA_PREBUILT="/usr/bin/lemminx"

src_install() {
	newbin lemminx-linux lemminx
}
