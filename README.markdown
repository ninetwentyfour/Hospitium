# [hospitium.co](https://hospitium.co/)

[![CircleCI](https://circleci.com/gh/ninetwentyfour/Hospitium.svg?style=svg)](https://circleci.com/gh/ninetwentyfour/Hospitium) [![Code Climate](https://codeclimate.com/github/ninetwentyfour/Hospitium.png)](https://codeclimate.com/github/ninetwentyfour/Hospitium) [![Dependency Status](https://gemnasium.com/ninetwentyfour/Hospitium.png)](https://gemnasium.com/ninetwentyfour/Hospitium) [![Coverage Status](https://coveralls.io/repos/ninetwentyfour/Hospitium/badge.png?branch=master)](https://coveralls.io/r/ninetwentyfour/Hospitium)

Created by [Travis Berry](http://www.travisberry.com) and [Apple Wood Rescue](http://www.applewoodrescue.org).

Licensed under the [MIT license](http://www.opensource.org/licenses/mit-license.php).

RoR, Twitter Bootstrap, and others are licensed under their respective licenses.

## Overview

[Hospitium](http://hospitium.co/) is the brain child of Apple Wood Rescue, a small animal rescue in Denver Colorado. Developed to fit the needs of the rescue, it has since been open sourced for anyone to use.

The software is completely **_free_**. You can modify it all you want and you can share it with anyone.

You can support the project by:

- Donating to [Apple Wood Rescue](http://www.applewoodrescue.org/donate/)
- Contributing to the development of Hospitium on [GitHub](https://github.com/ninetwentyfour/Hospitium)

## How to Install

1 - There are several dependencies on other apps/services:

- Ruby 2.1.1 and up
- Postgres: [www.postgresql.org](http://www.postgresql.org/)
- Memcache: [Local usage](https://devcenter.heroku.com/articles/memcachier#local-usage)
- Redis: [Getting Started](http://redis.io/topics/quickstart)
- [Juggernaut](https://github.com/maccman/juggernaut): it is used for real time edits; host it on Heroku following [these instructions](https://gist.github.com/1003748)
- [SendGrid](http://sendgrid.com/): an account is required to send emails
- [Bitly](https://bitly.com/): an account is needed for link shortening ‒ _[more info](https://bitly.com/a/your_api_key)_
- [Twitter](https://twitter.com/): a developer account is required for twitter integration ‒ _[more info](https://dev.twitter.com/)_
- [Facebook](http://www.facebook.com/): a developer account is required for facebook integration ‒ _[more info](http://developers.facebook.com/)_
- [S3](http://aws.amazon.com/s3/): an account is used for asset hosting

2 - Setup the env variables

&nbsp;&nbsp;Learn how: [Configuration and Config Vars](http://devcenter.heroku.com/articles/config-vars#local_setup)

&nbsp;&nbsp;To use [dotenv](https://github.com/bkeepers/dotenv) copy `.env.example` to `.env` and update any configs.

3 - Clone the git repository

```console
$ git clone git://github.com/ninetwentyfour/Hospitium.git
$ cd Hospitium
$ bundle install
```

4 - Database

&nbsp;&nbsp;It must be called _animal_development_.

&nbsp;&nbsp;Change connection params in the `/config/database.yml`, if needed.

&nbsp;&nbsp;Populate it:

```console
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

5 - Running

```console
$ rails s
```

Visit [localhost:3000](http://localhost:3000) to test it.

6 - Sign in

- **Login:** _admin_
- **Password:** _pleasechange_

&nbsp;&nbsp;The dashboard can be found at [localhost:3000/admin](http://localhost:3000/admin).

7 - Change your admin password

&nbsp;&nbsp;**This is very important!**

&nbsp;&nbsp;Change the organization name also if you so choose.

## Contributing

1. Fork it
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create new Pull Request
