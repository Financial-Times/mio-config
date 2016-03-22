# Mio Config

Tool for building out Mio environment 

## Pre-requistes

Install Ruby Environment Manager
brew install rbenv

Add this to your ~/.bash_profile
eval "$(rbenv init -)"


Install Ruby 
rbenv install 2.3.0
 rbenv global 2.3.0


__ Bundler; for installing gems
   ``` 
   $sudo gem install bundler 
   ```



## Building etc

```
bundle install 

```


IRB 

$:<<'.' ; require 'client' ; require 'models/events' ; Mio::Events.all


