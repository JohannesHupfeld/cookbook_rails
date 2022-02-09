# Rails Cookbook

For my Ruby on Rails project I decided to take the same concept as my Sinatra project, the Cookbook app. This time around I implemented a few new features on top of the full CRUD functionality of the original project. In this Rails version of my Cookbook app a user adds a category to recipe they create. This allows users to simply go to all categories and choose a recipe based from a category. Users are given the ability to comment on any recipe they would like. On the recipes show page you will see up to 6 comments (Most Recent Comments) but you can always click on “All Comments” to view them all for that recipe. Another feature is being able to search for recipes using a search bar. This allows users to search for recipes with key words found in the recipe name or ingredients. Users are also able to login using there google account.

## Demo
[Demo](https://www.youtube.com/watch?v=Kpj_Y1xT3ps&t=2s)

## Instalation

Clone the repo and install dependencies

```bash
$ git clone https://github.com/JohannesHupfeld/cookbook_rails
$ bundle install
```
...if you have any issues delete gemfile.lock and bundle install again.

Migrate

```bash
$ rails db:migrate
```
## Development

After installation, run 

```bash
$ rails s
```

and open up your web browser to 'locolhost:3000'

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/JohannesHupfeld/CookBook. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The code is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the cookbook_rails project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/JohannesHupfeld/CookBook/blob/master/CODE_OF_CONDUCT.md).

