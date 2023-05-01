# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 )

inherit python-single-r1

DESCRIPTION="OpenHPC metapackage"

HOMEPAGE="
	https://openhpc.community
	https://github.com/openhpc/ohpc
"

KEYWORDS="~amd64"
SLOT="0"
LICENSE="metapackage"
IUSE="+io-libs +parallel +perf-tools +python +runtimes +serial +slurm-client +slurm-server" #geopm warewulf
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#TODO: add metis/partition useflags in a way that doesn't pull in non-free parmetis
RDEPEND="
	${PYTHON_DEPS}
	app-shells/pdsh
	sys-apps/ipmitool
	sys-process/numactl
	virtual/mpi
	|| (
		sys-libs/libunwind
		sys-libs/llvm-libunwind
	)
	io-libs? (
		sci-libs/hdf5[cxx,fortran,mpi]
		sci-libs/netcdf[hdf5,mpi]
		sci-libs/netcdf-cxx
		sci-libs/netcdf-fortran
		sys-cluster/adios2[fortran,hdf5,mpi]
		sys-cluster/parallel-netcdf
		python? (
			$(python_gen_cond_dep '
				sys-cluster/adios2[python,${PYTHON_SINGLE_USEDEP}]
			')
		)
	)
	parallel? (
		dev-libs/boost[mpi]
		sci-libs/fftw[mpi]
		sci-libs/hypre[mpi]
		sci-libs/mfem[mpi,mumps,petsc,slepc]
		sci-libs/mumps[mpi,scotch]
		sci-libs/scalapack
		sci-libs/scotch[mpi,threads]
		sci-libs/superlu_dist[fortran]
		sci-libs/trilinos[hypre,mumps,scotch,scalapack,petsc]
		sci-mathematics/petsc[fftw,hypre,mpi,mumps,scotch]
		sci-mathematics/slepc[mpi]
		sys-cluster/opencoarrays
		io-libs? (
			sci-libs/mfem[netcdf]
			sci-libs/trilinos[hdf5,netcdf]
			sci-mathematics/petsc[hdf5]
		)
		python? (
			$(python_gen_cond_dep '
				dev-libs/boost[numpy,python,${PYTHON_USEDEP}]
			')
		)
		serial? ( sci-libs/mfem[superlu] )
	)
	perf-tools? (
		dev-libs/papi
		sys-apps/likwid
		sys-cluster/dimemas
		sys-cluster/extrae[${PYTHON_SINGLE_USEDEP}]
		sys-cluster/mpi-benchmarks
		sys-cluster/osu-micro-benchmarks
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
		app-containers/apptainer
	)
	serial? (
		dev-lang/R[lapack]
		sci-libs/gsl[cblas-external]
		sci-libs/metis
		sci-libs/openblas[eselect-ldso]
		sci-libs/plasma
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
#	perf-tools
	#tau

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
