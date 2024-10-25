# Run the following command to install the required tools
chmod +x installProg.sh
./installProg.sh

mkdir $DOMAIN
cd $DOMAIN
echo $DOMAIN > target.txt

assetfinder --subs-only $DOMAIN > assetfinder.txt

subfinder -d $DOMAIN -all -recursive -o subfinder.txt

cat assetfinder.txt subfinder.txt | sort -u > subdomains.txt

httpx -l assetfinder.txt -o httpx.txt

katana -u httpx.txt -o katana.txt -d 5 -jc -fx -ef wolf,css,png,svg,jpg,woff2,jpeg,gif
cat httpx.txt | waybackurls > waybackurls.txt
cat katana.txt waybackurls.txt | sort -u > endpoints.txt

cat endpoints.txt | grep '=' | tee param.txt


# nuclei -list subdomains.txt -t $HOME/nuclei-templates/vulnerabilities -t $HOME/nuclei-templates/cves -t $HOME/nuclei-templates/exposures

# Separating JS & CSS files from endpoints and removing them from endpoints.txt
cat endpoints.txt | grep -iE '\.js$|\.css$' | tee js_css.txt


# Finding XSS by not including JS & CSS files
grep -v -f js_css.txt endpoints.txt | tee xss.txt
dalfox file xss.txt -w 7  | tee XSSvulnerable.txt

# Finding LFIs
cat endpoints.txt | gau | tee lfi.txt
nuclei -list target.txt -tags lfi

# Finding Open Redirects
cat endpoints.txt | grep -a -i =http | qsreplace 'evil.com' | while read host do;do curl -s -L $host -I| grep "evil.com" && echo "$host \033[0;31mVulnerable\n" ;done

# -ps -pss waybackarchive,commoncrawl,alienvault