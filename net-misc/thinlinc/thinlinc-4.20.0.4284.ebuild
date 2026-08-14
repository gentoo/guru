# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# XXX: This software bundles some software like an openssh client and a tigervnc client.
# However, the execution path is hardcoded in the binary so it's not trivial to unbundle it.

EAPI=8

inherit desktop wrapper xdg

DESCRIPTION="An enterprise-grade Server-Based Computing (SBC) solution"
HOMEPAGE="https://www.cendio.com/thinlinc"

MY_PV="$(ver_rs 3 '-')"
MY_P="tl-${MY_PV}-client-linux-dynamic-x86_64"
SRC_URI="amd64? ( https://www.cendio.com/downloads/clients/${MY_P}.tar.gz -> ${P}.tar.gz )"

S="${WORKDIR}/${MY_P}"

LICENSE="Cendio-EULA"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror strip"

RDEPEND="
	sys-apps/pcsc-lite
"

QA_PREBUILT="*"

src_prepare() {
	default

	rm -r lib/tlclient/lib || die
	sed -i 's/Categories=Application;/Categories=/g' lib/tlclient/share/applications/thinlinc-client.desktop || die
}

src_install() {
	local ins_dir=/opt/thinlinc

	make_wrapper tlclient "${ins_dir}"/bin/tlclient

	into "${ins_dir}"
	dobin bin/*

	mkdir -p "${D}/${ins_dir}"
	# Using doins -r would strip executable bits from all binaries
	cp -pPR lib/ "${D}/${ins_dir}"|| die

	domenu lib/tlclient/share/applications/thinlinc-client.desktop

	(
		cd lib/tlclient/share/icons/hicolor || die
		for i in *; do
			doicon -s "${i}" "${i}"/apps/*
			doicon -c mimetypes -s "${i}" "${i}"/mimetypes/*
		done
	)

	insinto /usr/share/mime/packages
	doins lib/tlclient/share/mime/packages/thinlinc-client-mime.xml
}
