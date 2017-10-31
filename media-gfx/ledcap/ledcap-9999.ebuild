# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools

DESCRIPTION="niftyled screen capture tool"
HOMEPAGE="http://wiki.niftylight.de/ledcap"
# removed git:// style URI due to security issues
EGIT_REPO_URI="https://github.com/niftylight/ledcap.git"
#EGIT_COMMIT="master"
#EGIT_BRANCH="${EGIT_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug imlib X"

DOCS=( NEWS README.md AUTHORS ChangeLog )

RDEPEND="media-gfx/niftyled
	imlib? ( media-libs/imlib2 )
	X? ( x11-libs/libX11 )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

REQUIRED_USE="|| ( X imlib )"

src_prepare()
{
	default
	eautoreconf
}

src_unpack()
{
	git-r3_src_unpack
}

src_configure()
{
	econf \
	    $(use_enable debug) \
	    $(use_enable imlib imlib-capture) \
	    $(use_enable X x-capture)
}

pkg_postinst()
{
	echo
	elog "Sample configs come with libniftyled. Find them in"
	elog "/usr/share/niftyled/examples/"
	elog "Copy config to ~/.ledcap.xml or use the -c argument"
	elog "to select a config. For further information,"
	elog "see documentation at http://wiki.niftylight.de/${PN}"
	echo
}
