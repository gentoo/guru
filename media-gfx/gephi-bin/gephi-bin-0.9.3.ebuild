# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYPN="${PN/-bin/}"
MYP="${MYPN}-${PV}"

DESCRIPTION="The Open Graph Viz Platform"
HOMEPAGE="
	https://gephi.org/
	https://github.com/gephi/gephi
"
SRC_URI="https://github.com/gephi/gephi/releases/download/v${PV}/${MYP}-linux-x64.tar.gz"
S="${WORKDIR}"

LICENSE="CDDL GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
RDEPEND="virtual/jre:1.8"

RESTRICT="strip"

QA_PREBUILT="/opt/${MYPN}/platform/modules/lib/amd64/linux/libjnidispatch-nb.so"

src_prepare() {
	sed -e 's|jdkhome=.*|jdkhome=\$(java-config -O)|g' -i "${S}/${MYP}/etc/gephi.conf" || die

	#remove windows things
	rm -r "${S}/${MYP}"/bin/*.exe || die
	rm -r "${S}/${MYP}"/platform/lib/*.exe || die
	rm -r "${S}/${MYP}"/platform/lib/*.dll || die
	rm -r "${S}/${MYP}/platform/modules/lib/x86" || die #windows only
	rm -r "${S}/${MYP}"/platform/modules/lib/amd64/*.dll || die

	rm -rf "${S}/${MYP}/platform/modules/lib/i386" || die
	rm -rf "${S}/${MYP}/platform/modules/lib/aarch64" || die

	# remove bundled jre
	rm -rf "${S}/${MYP}/jre-x64" || die

	eapply_user
}

src_install() {
	insinto "/opt/${MYPN}"
	doins -r "${MYP}"/*
	keepdir "/opt/${MYPN}/etc"
	fperms a+x "/opt/${MYPN}/bin/gephi"
	fperms a+x "/opt/${MYPN}/platform/lib/nbexec"
	dosym "../../opt/${MYPN}/bin/gephi" "${EPREFIX}/usr/bin/gephi"
}
