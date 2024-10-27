#!/bin/bash

# Run commands and store outputs in variables
subdomains=$(cat subdomains.txt)
vulnerabilities=$(cat nuclei.txt)
js_css=$(cat js_files.txt css_files.txt)
xss=$(cat dalfox.txt)
lfi=$(cat lfi.txt)
open_redirects=$(cat open_redirects.txt)
subdomain_takeover=$(cat subdomains_takeover.txt)

# Copy the template to the final HTML file
cp template.html report.html

# Replace placeholders with command outputs
sed -i "s/\[SUBDOMAINS\]/$subdomains/" report.html
sed -i "s/\[VULNERABILITIES\]/$vulnerabilities/" report.html
sed -i "s/\[JS_CSS\]/$js_css/" report.html
sed -i "s/\[XSS\]/$xss/" report.html
sed -i "s/\[LFI\]/$lfi/" report.html
sed -i "s/\[OPEN_REDIRECTS\]/$open_redirects/" report.html
sed -i "s/\[SUBDOMAIN_TAKEOVER\]/$subdomain_takeover/" report.html

echo "Report generated: report.html"
