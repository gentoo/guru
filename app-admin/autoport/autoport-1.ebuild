EAPI=8

DESCRIPTION='Automates Gentoos portage folder (paccept, puse, pmask, punmask) to automatically add your stuff into them [USAGE= (paccept "www-client/zen-bin ~amd64") adds that text into a file named "www-client" inside /etc/portage/package.accept_keywords/ so you dont have to]'
HOMEPAGE="https://github.com/Fera-Maxwell/autoport"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {
	newbin "${FILESDIR}/autoport" autoport

	dosym autoport /usr/bin/paccept
	dosym autoport /usr/bin/puse
	dosym autoport /usr/bin/pmask
	dosym autoport /usr/bin/punmask
}
