# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit wrapper

DESCRIPTION="Wikidata batch editor, Wikimedia Commons mass upload tool"
HOMEPAGE="https://openrefine.org"

SRC_URI="https://github.com/OpenRefine/OpenRefine/releases/download/${PV}/${PN}-linux-${PV}.tar.gz
	commons? ( https://github.com/OpenRefine/CommonsExtension/releases/download/v0.1.1/openrefine-commons-0.1.1.zip )"
KEYWORDS="~amd64"
IUSE="+commons"

LICENSE="BSD"
SLOT="0"

BDEPEND="commons? ( app-arch/unzip )"

DEPEND="
	virtual/jre
	dev-java/maven-bin
	net-libs/nodejs
"

src_install() {
	local apphome="/opt/${PN}"

	mkdir -p  "${ED}/${apphome}" tools build || die
	chmod 775 tools build || die
	keepdir ${apphome}/{tools,build}

	if use commons ; then
		cp -r "${WORKDIR}/${NANE}/commons-extension" webapp/extensions || die
	fi

	cp -r . "${ED}/${apphome}" || die

	make_wrapper refine "
		env REFINE_LIB_DIR=${apphome}/server/target/lib \
		    REFINE_TOOLS_DIR=${apphome}/tools \
		    REFINE_CLASSES_DIR=${apphome}/server/classes \
		    REFINE_WEBAPP=${apphome}/main/webapp /opt/openrefine/refine"
}

pkg_postinst() {
	elog "In order to use ${PN} run refine in a terminal, from Dmenu also works"
	elog "First run better in terminal - for long installing"
}
