# Copyright 2023 Gabriel Sanches
# Distributed under the terms of the Zero-Clause BSD License

EAPI=8

inherit java-pkg-2

MY_PV=${PV/_p/-}
MY_PN=${PN%%-bin}
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Java language server"
HOMEPAGE="https://github.com/eclipse/eclipse.jdt.ls"
SRC_URI="https://download.eclipse.org/jdtls/snapshots/jdt-language-server-${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

S="${WORKDIR}"

LICENSE="EPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=virtual/jre-1.8:*"
RDEPEND="${DEPEND}"

JDTLS_LIBEXEC="/usr/libexec/${MY_PN}"
JDTLS_SHARE="/usr/share/${MY_PN}"

JDTLS_WRAPPER="${FILESDIR}/wrapper"

src_install() {
	dodir "${JDTLS_LIBEXEC}/bin"
	dodir "${JDTLS_SHARE}"

	cp -Rp plugins features "${ED}/${JDTLS_LIBEXEC}" || die "failed to copy"
	cp -Rp bin/${MY_PN} "${ED}/${JDTLS_LIBEXEC}/bin" || die "failed to copy"
	cp -Rp config_linux "${ED}/${JDTLS_SHARE}" || die "failed to copy"

	sed ${JDTLS_WRAPPER} -e "s;@PKGNAME@;${MY_PN};g" > wrapper
	dodir /usr/bin
	newbin wrapper ${MY_PN}
}

pkg_postinst() {
	elog "If the JDT Language Server fails to start (e.g. ClassNotFoundException),"
	elog "you may be running into stale Eclipse OSGi cache issues."
	elog
	elog "To fix this, remove the following directories:"
	elog "  rm -rf \"\${XDG_DATA_HOME}/jdtls\" or rm -rf \"~/.local/share/jdtls\""
	elog "  rm -rf \"\${XDG_STATE_HOME}/jdtls\" or rm -rf \"~/.local/state/jdtls\""
	elog
	elog "They will be recreated cleanly on the next launch."
}
