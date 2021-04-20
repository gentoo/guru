# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby25 ruby26 ruby27 ruby30"
RUBY_FAKEGEM_RECIPE_TEST="rspec3"

inherit ruby-fakegem

DESCRIPTION="Fish-like autosuggestions for zsh"
HOMEPAGE="https://github.com/zsh-users/zsh-autosuggestions"
SRC_URI="https://github.com/zsh-users/zsh-autosuggestions/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"
RDEPEND=">=app-shells/zsh-4.3.11"
BDEPEND="
	test? (
		${RDEPEND}
		app-misc/tmux
		dev-ruby/bundler
		dev-ruby/pry
		dev-ruby/pry-byebug
		dev-ruby/rspec-wait
	)
"
DEPEND=""

src_install() {
	insinto "/usr/share/zsh/site-functions/"
	doins "${WORKDIR}/all/${P}/${PN}.zsh"
}

pkg_postinst() {
	elog "In order to use ${CATEGORY}/${PN} add ". /usr/share/zsh/site-functions/zsh-autosuggestions.zsh" at the end of your ~/.zshrc (including the dot)"
}
