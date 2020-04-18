if [ ! \( is_osx -o is_ubuntu \) ] ; then
    exit 1
fi

# Homebrew installs python2's pip as "pip2"
is_osx && pips=(pip2 pip FAIL)
is_ubuntu && pips=(pip3 pip FAIL)

for pip_cmd in $pips ; do [[ "$(which $pip_cmd)" ]] && break; done

# Exit if pip is not installed.
[[ $pip_cmd == FAIL ]] && e_error "Pip needs to be installed." && return 1

# Add pip packages
pip_packages=(
    bs4         # error-tolerant HTML parser
    gmpy2       # GMP for python
    pip3        # python3 package installer
    requests    # http request library
    tabulate    # pretty print tabular data
    pylin3
    python-dateutil
    mypy
)

installed_pip_packages="$($pip_cmd list 2>/dev/null | awk '{print $1}')"
pip_packages=($(setdiff "${pip_packages[*]}" "$installed_pip_packages"))

if (( ${#pip_packages[@]} > 0 )); then
    e_header "Installing pip packages (${#pip_packages[@]})"
    for package in "${pip_packages[@]}"; do
        e_arrow "$package"
        $pip_cmd install "$package"
    done
fi
