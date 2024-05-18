EAPI=7

EGO_PN=github.com/stripe/stripe-cli

inherit git-r3 go-module bash-completion-r1

# remove -cli suffix
MY_PN=${PN%-cli}

DESCRIPTION="A command-line tool for Stripe"
HOMEPAGE="https://stripe.com/docs/stripe-cli"
EGIT_REPO_URI="https://${EGO_PN}.git"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="bash-completion"

BDEPEND=">=dev-lang/go-1.18"
DEPEND="${BDEPEND}"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build -o ${MY_PN} cmd/stripe/main.go
}

src_install() {
	dobin ${MY_PN}

	if use bash-completion ; then
		dobashcomp *.bash
	fi
}
