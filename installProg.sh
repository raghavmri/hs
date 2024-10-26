# Subfinder
if ! command -v subfinder &> /dev/null
then
    go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
else
    echo "Subfinder is already installed"
fi

# HTTPx
if ! command -v httpx &> /dev/null
then
    go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
else
    echo "HTTPx is already installed"
fi

# Nuclei
if ! command -v nuclei &> /dev/null
then
    go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
    nuclei -update-templates
else
    echo "Nuclei is already installed"
fi

# Waybackurls
if ! command -v waybackurls &> /dev/null
then
    go install github.com/tomnomnom/waybackurls@latest
else
    echo "Waybackurls is already installed"
fi

# Katana
if ! command -v katana &> /dev/null
then
    go install github.com/projectdiscovery/katana/cmd/katana@latest
else
    echo "Katana is already installed"
fi

# AssetFinder
if ! command -v assetfinder &> /dev/null
then
    go install github.com/tomnomnom/assetfinder@latest
else
    echo "AssetFinder is already installed"
fi

# Nmap
if ! command -v nmap &> /dev/null
then
    sudo apt install nmap -y
else
    echo "Nmap is already installed"
fi

# URO
if ! python3 -m pip show uro &> /dev/null
then
    pip3 install uro
else
    echo "URO is already installed"
fi

# gf
if ! command -v gf &> /dev/null
then
    go install github.com/tomnomnom/gf@latest
else
    echo "gf is already installed"
fi

# Dalfox
if ! command -v dalfox &> /dev/null
then
    go install github.com/hahwul/dalfox/v2@latest
else
    echo "Dalfox is already installed"
fi

# Gau
if ! command -v gau &> /dev/null
then
    go install github.com/lc/gau/v2/cmd/gau@latest
else
    echo "Gau is already installed"
fi

# Misc (qsreplace)
if ! command -v qsreplace &> /dev/null
then
    go install github.com/tomnomnom/qsreplace@latest
else
    echo "qsreplace is already installed"
fi

# BXSS
if ! command -v bxss &> /dev/null
then
    go install github.com/ethicalhackingplayground/bxss@latest
else
    echo "BXSS is already installed"
fi

# Subzy
if ! command -v subzy &> /dev/null
then
    go install -v github.com/PentestPad/subzy@latest
else
    echo "Subzy is already installed"
fi


# https://github.com/SirBugs/endext