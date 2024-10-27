# Add a green color print statement before running each command

# Run the following command to install the required tools
echo -e "\033[0;32mRunning installProg.sh...\033[0m"
chmod +x installProg.sh
./installProg.sh

# Create the necessary directory structure
echo -e "\033[0;32mCreating domain directory...\033[0m"
mkdir -p domains/$DOMAIN
cd domains/$DOMAIN
echo $DOMAIN > target.txt

# Find subdomains using assetfinder
echo -e "\033[0;32mRunning assetfinder...\033[0m"
assetfinder --subs-only $DOMAIN > assetfinder.txt

# Find subdomains using subfinder
echo -e "\033[0;32mRunning subfinder...\033[0m"
subfinder -d $DOMAIN -all -recursive -o subfinder.txt

# Merge and sort subdomain lists
echo -e "\033[0;32mMerging subdomain lists...\033[0m"
cat assetfinder.txt subfinder.txt | sort -u > subdomains.txt

# Probe for live subdomains using httpx
echo -e "\033[0;32mRunning httpx...\033[0m"
httpx -l assetfinder.txt -o httpx.txt

# Use katana to discover endpoints and filter out unwanted files
echo -e "\033[0;32mRunning katana for endpoint discovery...\033[0m"
katana -u httpx.txt -o katana.txt -d 5 -jc -fx -ef wolf,css,png,svg,jpg,woff2,jpeg,gif
cat httpx.txt | waybackurls > waybackurls.txt

# Combine katana and waybackurls outputs for unique endpoints
echo -e "\033[0;32mCombining endpoint lists...\033[0m"
cat katana.txt waybackurls.txt | sort -u > endpoints.txt

# Extract parameters from endpoints
echo -e "\033[0;32mExtracting parameters from endpoints...\033[0m"
cat endpoints.txt | grep '=' | tee param.txt
cat endpoints.txt | gau | tee urls.txt

# Run nuclei for vulnerability scanning
echo -e "\033[0;32mRunning nuclei vulnerability scan...\033[0m"
nuclei -list httpx.txt -t $HOME/nuclei-templates/vulnerabilities -t $HOME/nuclei-templates/cves -t $HOME/nuclei-templates/exposures

# Separating JS & CSS files from endpoints and removing them from endpoints.txt
echo -e "\033[0;32mSeparating JS and CSS files...\033[0m"
cat endpoints.txt | grep -iE '\.js$' | tee js_files.txt
cat endpoints.txt | grep -iE '\.css$' | tee css_files.txt

# Finding XSS by not including JS & CSS files
echo -e "\033[0;32mRunning dalfox for XSS detection...\033[0m"
dalfox file params.txt -w 14 | tee dalfox.txt

# Finding LFIs
echo -e "\033[0;32mIdentifying potential LFIs...\033[0m"
cat endpoints.txt | tee lfi.txt
nuclei -list target.txt -tags lfi

# Finding Open Redirects
echo -e "\033[0;32mSetting up for open redirect checks...\033[0m"
git clone https://github.com/faiyazahmad07/WEBSTER.git
cd WEBSTER

# Echo each URL in urls.txt to the python script as a single URL
# python3 webster.py -u urls.txt -p payload.txt -t 2

# Checking For Subdomain Takeover
echo -e "\033[0;32mChecking for subdomain takeover...\033[0m"
subzy run --targets subdomains.txt

# -ps -pss waybackarchive,commoncrawl,alienvault
