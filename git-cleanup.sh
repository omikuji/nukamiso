# ANSI escape codes for color output
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Search for branches whose last commit was more than 30 days ago
echo -e "${RED}Deleted branches:${NC}"
git for-each-ref --sort=-committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)' | while read -r date branch; do
    # If the branch's last commit date was more than 30 days ago, delete the branch
    if [[ "$(date -j -f "%Y-%m-%d" "$date" +%s)" -lt "$(date -j -v-30d +%s)" ]]; then
        git branch -D "$branch" > /dev/null 2>&1 && echo "$branch"
    fi
done

# Search for branches whose last commit was less than or equal to 30 days ago
echo -e "${BLUE}Not deleted branches:${NC}"
git for-each-ref --sort=-committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)' | while read -r date branch; do
    # If the branch's last commit date was less than or equal to 30 days ago, output the branch
    if [[ "$(date -j -f "%Y-%m-%d" "$date" +%s)" -ge "$(date -j -v-30d +%s)" ]]; then
        echo "$branch"
    fi
done
