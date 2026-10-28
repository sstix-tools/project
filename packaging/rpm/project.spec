Name:           project
Version:        %{version}
Release:        1%{?dist}
Summary:        <TODO>
License:        MIT
BuildArch:      noarch
Requires:       coreutils

%description
<TODO>

%install
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_datadir}/zsh/site-functions
install -m 0755 %{_sourcedir}/project %{buildroot}%{_bindir}/project
install -m 0644 %{_sourcedir}/_project %{buildroot}%{_datadir}/zsh/site-functions/_project

%files
%{_bindir}/project
%{_datadir}/zsh/site-functions/_project
