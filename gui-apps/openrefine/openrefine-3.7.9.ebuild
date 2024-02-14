# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit wrapper

DESCRIPTION="Wikidata batch editor, Wikimedia Commons mass upload tool"
HOMEPAGE="https://openrefine.org"

SRC_URI="https://github.com/OpenRefine/OpenRefine/releases/download/${PV}/${PN}-linux-${PV}.tar.gz"
KEYWORDS="~amd64"

LICENSE="BSD"
SLOT="0"

DEPEND="
dev-java/maven-bin
net-libs/nodejs
virtual/jre
"

src_install() {
	local apphome="/opt/${PN}"

	mkdir -p  "${ED}/${apphome}" || die
	mkdir     tools build || die
	chmod 775 tools build || die
	keepdir /opt/openrefine/tools
	keepdir /opt/openrefine/build
	# dosym "${apphome}/refine" /usr/bin/refine
	cp -r . "${ED}/${apphome}" || die

	make_wrapper refine "
		env REFINE_LIB_DIR=/opt/openrefine/server/target/lib \
		    REFINE_TOOLS_DIR=/opt/openrefine/tools \
		    REFINE_CLASSES_DIR=/opt/openrefine/server/classes \
		    REFINE_WEBAPP=/opt/openrefine/main/webapp /opt/openrefine/refine"
}

pkg_postinst() {
	elog "In order to use ${PN} run refine in a terminal, from Dmenu also works"
}
