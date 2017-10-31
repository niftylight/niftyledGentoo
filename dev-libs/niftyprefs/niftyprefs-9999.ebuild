# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools

DESCRIPTION="lightweight library to handle preferences/configuration files"
HOMEPAGE="http://wiki.niftylight.de/libniftyprefs"
# removed git:// style URI to avoid security warning
EGIT_REPO_URI="https://github.com/niftylight/niftyprefs.git"
#EGIT_COMMIT="master"
#EGIT_BRANCH="${EGIT_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug static"

DOCS=( NEWS README.md AUTHORS ChangeLog )

RDEPEND="dev-libs/libxml2
	dev-libs/niftylog"
# we unconditionally build the documentation and don't have configure option
# for it, so we need doxygen installed
DEPEND="${RDEPEND}
	virtual/pkgconfig"

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
	    $(use_enable static)
}

src_compile() {
	emake
}
