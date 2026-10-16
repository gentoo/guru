# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A framework for Web Testing and Automation"
HOMEPAGE="https://github.com/microsoft/playwright"
SRC_URI="
	https://github.com/microsoft/playwright/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/69517529/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	net-libs/nodejs
"
BDEPEND="
	net-libs/nodejs[npm]
"

PATCHES=(
	"${FILESDIR}/${PN}-1.64.1-dont-update-the-test-runner-during-the-build.patch"
)

src_compile() {
	npm run build || die
}

src_install() {
	insinto "/usr/$(get_libdir)/node_modules/${PN}"
	dosym -r "$_/cli.js" /usr/bin/playwright
	doins -r packages/playwright-core/*
	fperms +x /usr/bin/playwright
}
