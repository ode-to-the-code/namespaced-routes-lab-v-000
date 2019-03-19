When running rake db:seed on the NameSpaced Routes lab:
Error:
```LoadError:
  cannot load such file -- active_storage/engine```

Solution:
In Gemfile:
Remove: `, '5.0.7.1'` from `gem 'rails', '5.0.7.1'`
Add: `gem ‘listen’

Then delete Gemfile.lock
Run `bundle`

Run `rake db:seed`
If successful check the database by using `Song.first` in a Rails Console session

how to update your ruby version
http://help.learn.co/technical-support/local-environment/how-to-upgrade-from-ruby-23-to-26
