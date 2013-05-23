%define __os_install_post %{nil}
Summary: ec2-api-tools
Name: ec2-api-tools
Version: %{version}
Release: %{release}
License: Amazon Software License
Vendor: Amazon
Packager: Andrew Kesterson <andrew@aklabs.net>
Group: Application/Utilities
Provides: %{name}
Requires: java
BuildArch: x86_64
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}
Source: %{name}-%{version}-%{release}.tar.gz


%description
Amazon EC2 Command Line Utilities. http://aws.amazon.com/developertools/351

%install
mkdir -p %{buildroot}/opt/ec2-api-tools
echo 'export EC2_HOME=/opt/ec2-api-tools' > %{buildroot}/etc/profile.d/ec2-api-tools.sh
chmod +x %{buildroot}/etc/profile.d/ec2-api-tools.sh
tar -zxvf %{_sourcedir}/%{name}-%{version}-%{release}.tar.gz -C %{buildroot}/opt/ec2-api-tools

%files
/opt/ec2-api-tools
/etc/profile.d/ec2-api-tools.sh
