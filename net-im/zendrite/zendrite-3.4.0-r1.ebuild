# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Zendrite is a second-generation Matrix homeserver written in Go"
HOMEPAGE="
	https://zendrite.pat-s.me/
	https://codefloe.com/pat-s/zendrite
"

# See https://bugs.gentoo.org/981253
SRC_URI="
	https://codefloe.com/pat-s/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://vimja.cloud/public.php/dav/files/z59eKDyLFokW2KK/${CATEGORY}/${PN}/${P}-vendor.tar.xz
"

S="${WORKDIR}/${PN}"

# https://wiki.gentoo.org/wiki/Writing_go_Ebuilds#Licenses
LICENSE="AGPL-3+ Apache-2.0 BSD MIT MPL-2.0 ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="
	>=dev-lang/go-1.27.0
	test? ( dev-libs/olm )
"
RDEPEND="
	acct-user/zendrite
	acct-group/zendrite
"

src_compile() {
	ego build ./...
	GOBIN="${S}/bin" ego install ./...
}

src_test() {
	# Do not run tests that require access to a working PostgreSQL installation...
	tests_requiring_a_postgres_installation=(
		TestAdvanceOwnershipBootstrapsFirstGeneration
		TestAdvanceOwnershipRejectsForeignScope
		TestAdvanceOwnershipRejectsRetiredGeneration
		TestAdvanceOwnershipSerializesConcurrentPromoters
		TestApplicationNameSurvivesPostgresTruncation
		TestBackendsAfterTheHorizonAreNotFencingEvidence
		TestConfirmedOwnershipIsNotAbandoned
		TestConnectionManagerAppliesTheGuard
		TestContractSurface
		TestDispatchedTransactionsAreNotRecalled
		TestFenceBackendsTerminatesRetiredActivations
		TestGuardConnectionRefusesRetiredActivation
		TestGuardedConnectionsCarryTheActivationMarker
		TestGuardedOpenRefusesRetiredOwnership
		TestGuardedPoolDiscardsRecentlyTerminatedBackend
		TestGuardedPoolDiscardsRecentlyTerminatedBackend
		TestGuardedReconnectRefusesRetiredOwnership
		TestHeartbeatKeepsOwnershipFresh
		TestHeartbeatRetiresTheOwnerAfterTakeover
		TestOwnerPartitionedFromKubernetesCannotOverlap
		TestOwnershipGoesStaleWithoutAHeartbeat
		TestOwnershipHistoryFailsClosedWhenTampered
		TestPausedOwnerIsRefusedAtEveryBoundary
		TestPrepareStorageConnectionIsFenceable
		TestPrepareStorageReportsWhyItWasRefused
		TestRecordWithoutContractIsRefused
		TestRefusedConnectionsDoNotLeakBackends
		TestResumedOwnerCannotCommitAfterTakeover
		TestStorageCompatibilityAndMigrationSerialization
		TestSweepNeverFencesANewerGeneration
		TestUncertainFencingBlocksTakeover
		TestUnguardedConnectionsKeepStandaloneBehaviour
		TestUpDropEventReferenceSHAPrevEvents
		TestUpgradeContractRecord
		TestPostgres*
		TestOutputEventTimestampUpgrade/.*
		.*/postgres
		.*/.*/postgres
	)

	skip_postgres_tests=$(
		echo ${tests_requiring_a_postgres_installation[@]} | sed --expression='s/ /|/g'
	)
	ego test ./... -skip "${skip_postgres_tests}"
}

src_install() {

	dobin "${S}"/bin/*

	insinto /etc/zendrite
	doins "${S}"/zendrite-sample.yaml

	newinitd "${FILESDIR}"/init-r2 zendrite
	newconfd "${FILESDIR}"/conf-r2 zendrite
}
