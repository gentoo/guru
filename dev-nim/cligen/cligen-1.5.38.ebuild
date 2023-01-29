# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="Infer & generate command-line interface/option/argument parser"
HOMEPAGE="
	https://github.com/c-blake/cligen
	https://nimble.directory/pkg/cligen
"
SRC_URI="https://github.com/c-blake/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC MIT"
SLOT="${PV}"
KEYWORDS="~amd64"
RESTRICT="test"  # Version.nim test fails

DOCS=( configs examples {MOTIVATION,README,RELEASE-NOTES,TODO}.md )

set_package_url "https://github.com/c-blake/cligen"

src_test() {
	emake -f GNUmakefile
}

src_install() {
	docompress -x /usr/share/doc/${PF}/examples
	nimble_src_install
}
