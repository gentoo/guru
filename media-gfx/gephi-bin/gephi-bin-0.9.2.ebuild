# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MYPN="${PN/-bin/}"
MYP="${MYPN}-${PV}"

DESCRIPTION="The Open Graph Viz Platform"
HOMEPAGE="https://gephi.org/"
SRC_URI="https://github.com/gephi/gephi/releases/download/v${PV}/${MYP}-linux.tar.gz"

LICENSE="CDDL GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="strip"
RDEPEND="virtual/jre:1.8"

S="${WORKDIR}"

QA_PREBUILT="
	/opt/${MYPN}/platform/modules/lib/amd64/linux/libjnidispatch-422.so
	/opt/${MYPN}/platform/modules/lib/i386/linux/libjnidispatch-422.so
"

src_prepare() {
	sed -e 's|\#jdkhome="\/path\/to\/jdk"|jdkhome=\$(java-config -O)|g' -i "${S}/${MYP}/etc/gephi.conf"

	#remove windows things
	rm -r "${S}/${MYP}"/bin/*.exe || die
	rm -r "${S}/${MYP}"/platform/lib/*.exe || die
	rm -r "${S}/${MYP}"/platform/lib/*.dll || die
	rm -r "${S}/${MYP}/platform/modules/lib/x86" || die #windows only
	rm -r "${S}/${MYP}"/platform/modules/lib/amd64/*.dll || die

	use amd64 && rm -rf "${S}/${MYP}/platform/modules/lib/i386"
	use x86 && rm -rf "${S}/${MYP}/platform/modules/lib/amd64"

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
