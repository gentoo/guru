# Copyright 1999-2024 Gentoo Authors
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
MY_JAVA_DEPEND=">=virtual/jre-11"
RDEPEND="${MY_JAVA_DEPEND}"

RESTRICT="strip"

QA_PREBUILT="/opt/${MYPN}/platform/modules/lib/amd64/linux/libjnidispatch-nb.so"

src_prepare() {
	default

	local gephi_conf="${MYP}/etc/gephi.conf"
	sed -e '/jdkhome=.*/d' -i "${gephi_conf}" || die
	# Extra newline since gephi.conf does not end with a newline char.
	cat <<-EOF >> "${gephi_conf}"

	gentoo_java_vm="\$(depend-java-query --get-vm '${MY_JAVA_DEPEND}')"
	jdkhome="\$(java-config -P \${gentoo_java_vm} | grep JAVA_HOME | cut -d '=' -f 2)"
EOF

	#remove windows things
	rm -r "${MYP}"/bin/*.exe || die
	rm -r "${MYP}"/platform/lib/*.exe || die
	rm -r "${MYP}"/platform/lib/*.dll || die
	rm -r "${MYP}/platform/modules/lib/x86" || die #windows only
	rm -r "${MYP}"/platform/modules/lib/amd64/*.dll || die

	rm -rf "${MYP}/platform/modules/lib/i386" || die
	rm -rf "${MYP}/platform/modules/lib/aarch64" || die

	# remove bundled jre
	rm -rf "${MYP}/jre-x64" || die
}

src_install() {
	insinto "/opt/${MYPN}"
	doins -r "${MYP}"/*
	keepdir "/opt/${MYPN}/etc"
	fperms a+x "/opt/${MYPN}/bin/gephi"
	fperms a+x "/opt/${MYPN}/platform/lib/nbexec"
	dosym "../../opt/${MYPN}/bin/gephi" "${EPREFIX}/usr/bin/gephi"
}
