#
# spec file for package supportutils-plugin-trento
#
# Copyright SUSE LLC
#
# All modifications and additions to the file contributed by third parties
# remain the property of their copyright owners, unless otherwise agreed
# upon. The license for this file, and modifications and additions to the
# file, is the same license as for the pristine package itself (unless the
# license for the pristine package is not an Open Source License, in which
# case the license is the MIT License). An "Open Source License" is a
# license that conforms to the Open Source Definition (Version 1.9)
# published by the Open Source Initiative.

# Please submit bugfixes or comments via https://bugs.opensuse.org/
#


Name:           supportutils-plugin-trento
# Version will be processed via set_version source service
Version:        0
Release:        0
License:        Apache-2.0
Summary:        Supportconfig plugin for the Trento application
Group:          System/Monitoring
URL:            https://github.com/trento-project/support
Source:         %{name}-%{version}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-build
BuildArch:      noarch
Provides:       %{name} = %{version}-%{release}
Provides:       trento-supportconfig-plugin = %{version}-%{release}
Obsoletes:      trento-supportconfig-plugin <= %{version}-%{release}
Requires:       supportutils
Suggests:       yq
Suggests:       jq
Suggests:       helm
Suggests:       kubernetes-client

%description
Supportconfig plugin for Trento.

The script allows the user to collect all relevant installation details for a support request.

%prep
%setup -q # unpack project sources

%build

%install
install -D -m 0755 trento-support.sh "%{buildroot}%{_bindir}/trento-support"
install -d "%{buildroot}/usr/lib/supportconfig/plugins"
install -m 0544 packaging/suse/supportutils-plugin-trento/trento "%{buildroot}/usr/lib/supportconfig/plugins"

%files
%defattr(-,root,root)
%{_bindir}/trento-support
/usr/lib/supportconfig
/usr/lib/supportconfig/plugins
/usr/lib/supportconfig/plugins/trento

%license LICENSE

%changelog
