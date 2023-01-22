# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
USE_RUBY="ruby26 ruby27 ruby30"

RUBY_FAKEGEM_TASK_TEST="CUCUMBER_PUBLISH_QUIET=true test features"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.adoc README.adoc"

RUBY_FAKEGEM_EXTRAINSTALL="data"

RUBY_FAKEGEM_GEMSPEC="asciidoctor-pdf.gemspec"

inherit ruby-fakegem

DESCRIPTION="A native PDF converter for AsciiDoc based on Asciidoctor and Prawn"
HOMEPAGE="https://github.com/asciidoctor/asciidoctor-pdf"
SRC_URI="https://github.com/asciidoctor/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# rake have no task test, skipping for now
RESTRICT=test

ruby_add_rdepend "
	>=dev-ruby/asciidoctor-2.0
	>=dev-ruby/concurrent-ruby-1.1
	>=dev-ruby/matrix-0.4
	>=dev-ruby/prawn-2.4.0
	>=dev-ruby/prawn-icon-3.0.0
	>=dev-ruby/prawn-svg-0.32.0
	>=dev-ruby/prawn-table-0.2.0
	>=dev-ruby/prawn-templates-0.1.0
	>=dev-ruby/treetop-1.6.0
	"

all_ruby_prepare() {
	rm Gemfile || die

	sed -i -e "s:_relative ': './:" ${RUBY_FAKEGEM_GEMSPEC} || die
}

all_ruby_install() {
	all_fakegem_install
}
