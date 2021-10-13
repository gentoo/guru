# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit python-single-r1

DESCRIPTION="OpenHPC metapackage"

SLOT="0"
LICENSE="GPL-2"
HOMEPAGE="
	https://openhpc.community
	https://github.com/openhpc/ohpc
"
KEYWORDS="~amd64"
IUSE="+io-libs +parallel +perf-tools +python +runtimes +serial +slurm-client +slurm-server" #geopm warewulf

#TODO: add metis/partition useflags in a way that doesn't pull in non-free parmetis
RDEPEND="
	${PYTHON_DEPS}
	|| ( sys-libs/libunwind sys-libs/llvm-libunwind )

	app-shells/pdsh
	sys-apps/ipmitool
	sys-process/numactl
	virtual/mpi

	io-libs? (
		sci-libs/hdf5[cxx,fortran,mpi]
		sci-libs/netcdf[hdf5,mpi]
		sci-libs/netcdf-cxx
		sci-libs/netcdf-fortran
		sys-cluster/parallel-netcdf
	)

	parallel? (
		dev-libs/boost[mpi]
		sci-libs/fftw[mpi]
		sci-libs/hypre[mpi]
		sci-libs/mumps[mpi,scotch]
		sci-libs/scalapack
		sci-libs/scotch[mpi,threads]
		sci-libs/trilinos[boost,hypre,mumps,scotch,scalapack,petsc]
		sci-mathematics/petsc[fftw,hypre,mpi,mumps,scotch]
		sci-mathematics/slepc[mpi]
		sys-cluster/opencoarrays

		io-libs? (
			sci-libs/trilinos[hdf5,netcdf]
			sci-mathematics/petsc[hdf5]
		)
		python? (
			$(python_gen_cond_dep 'dev-libs/boost[numpy,python,${PYTHON_USEDEP}]')
		)
	)

	perf-tools? (
		dev-libs/papi
		sys-apps/likwid
		sys-cluster/extrae[${PYTHON_SINGLE_USEDEP}]
	)

	python? (
		$(python_gen_cond_dep '
			dev-python/mpi4py[${PYTHON_USEDEP}]
			dev-python/numpy[${PYTHON_USEDEP}]
			dev-python/scipy[${PYTHON_USEDEP}]
		')
	)

	runtimes? (
		sys-cluster/charliecloud[${PYTHON_SINGLE_USEDEP}]
		sys-cluster/singularity
	)

	serial? (
		dev-lang/R[lapack]
		sci-libs/gsl[cblas-external]
		sci-libs/metis
		sci-libs/openblas[eselect-ldso]
		sci-libs/superlu
	)

	slurm-client? (
		sys-apps/hwloc
		sys-cluster/slurm[numa,pam]
		io-libs? ( sys-cluster/slurm[hdf5] )
	)

	slurm-server? (
		sys-cluster/slurm[numa,perl,slurmdbd]
		io-libs? ( sys-cluster/slurm[hdf5] )
	)

"
#	io-libs
	#adios[mpi]
	#phdf5[mpi]

#	parallel
	#sci-libs/superlu_dist
	#mfem

#	perf-tools
#		sys-cluster/dimemas[libunwind]
	#imb
	#omb
	#scalasca
	#tau
	#scorep

#	serial
	#plasma

#	slurm-server
	#pdsh-slurm

	#geopm? (
		#geopm[mpi]
	#)

	#warewulf? (
		#warewulf-cluster
		#warewulf-common-localdb
		#warewulf-common
		#warewulf-ipmi
		#warewulf-ipmi-initramfs
		#warewulf-provision
		#warewulf-provision-initramfs
		#warewulf-provision-server-ipxe
		#warewulf-provision-server
		#warewulf-vnfs
	#)

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
