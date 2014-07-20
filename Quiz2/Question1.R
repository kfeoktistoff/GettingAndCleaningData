# Register an application with the Github API here https://github.com/settings/applications. 
# Access the API to get information on your instructors repositories 
# (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). 
# Use this data to find the time that the datasharing repo was created. What time was it created? This tutorial may be 
# useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). You may also need to run the code in 
# the base R package and not R studio. 

library(httr)
library(httpuv)
library(jsonlite)

oauth_endpoints("github")
myapp <- oauth_app("github", "7fb85922bba6974b31d2", secret="secret-key-here")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", config(token = github_token))
stop_for_status(req)
json1 = content(req)
json1[[5]]$created_at