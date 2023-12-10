%global debug_package %{nil}

Name:           kime
Version:        3.0.2
Release:        1%{?dist}
Summary:        Korean IME

License:        GPL
URL:            https://github.com/Riey/kime
Source0:        https://github.com/Riey/kime/archive/refs/heads/develop.zip

BuildRequires:  cmake
BuildRequires:  cargo
BuildRequires:  clang-libs
BuildRequires:  pkgconf-pkg-config

Requires:       gtk3
Requires:       gtk4
Requires:       qt5
Requires:       qt6
Requires:       dbus-devel
Requires:       xcb-util
Requires:       fontconfig
Requires:       freetype


%prep
%setup -q

%build
./build.sh

%install
install -Dm755 kime %{buildroot}%{_bindir}/kime

%files
%{_bindir}/kime
%doc README.md
%license LICENSE

%changelog
