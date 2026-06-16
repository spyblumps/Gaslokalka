eval "$(ssh-agent -s)" > /dev/null
ssh-add ./my_github_key 2> /dev/null
