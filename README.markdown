* * *
Hospitium
========

* * *

[![Build Status](https://secure.travis-ci.org/ninetwentyfour/Hospitium.png)](http://travis-ci.org/ninetwentyfour/Hospitium)

[http://hospitium.co/](http://hospitium.co/)

Created By: [Travis Berry](http://www.travisberry.com), [Apple Wood Rescue](http://www.applewoodrescue.org)

Hospitium is Licensed under the MIT license: [http://www.opensource.org/licenses/mit-license.php](http://www.opensource.org/licenses/mit-license.php)

RoR, Twitter Bootstrap, and others licensed under their respective licenses. 

* * *

Overview:
========================

* * *

[Hospitium](http://hospitium.co/) is the brain child of Apple Wood Rescue, a small animal rescue in Denver Colorado. Developed to fit the needs of the rescue, it has since been open sourced for anyone to use.

This program is completely free. You can modify it all you want and you can share it with anyone.

You can support the project by:

- Donating to [Apple Wood Rescue](http://www.applewoodrescue.org/donate/)

- Contributing to the development of Hospitium on [github](https://github.com/ninetwentyfour/Hospitium).


* * *

Install:
========================

* * *

There are several dependencies on other apps/services. 

- Ruby 1.9.2 and up.
- Memcache: [Simple local install](https://devcenter.heroku.com/articles/memcache#local_memcache_setup).
- [Juggernaut](https://github.com/maccman/juggernaut): I recommend hosting on heroku following these [instructions](https://gist.github.com/1003748). used for real time edits
- [SendGrid](http://sendgrid.com/): A sendgrid account is required to send emails. [http://sendgrid.com/](http://sendgrid.com/)
- [Bitly](https://bitly.com/): A bitly account is needed for link shortening. [http://bitly.com/a/your\_api\_key](http://bitly.com/a/your\_api\_key)
- [Twitter](https://twitter.com/): A twitter developer account is required for twitter integration. [https://dev.twitter.com/](https://dev.twitter.com/)
- [Facebook](http://www.facebook.com/): A facebook developer accoutn is required for facebook integration. [http://developers.facebook.com/](http://developers.facebook.com/)
- [S3](http://aws.amazon.com/s3/): A s3 account is used for asset hosting. [http://aws.amazon.com/s3/](http://aws.amazon.com/s3/)

Setup env variables. Good how to [here](http://devcenter.heroku.com/articles/config-vars#local_setup).

- S3\_KEY (your s3 Key)
- S3\_SECRET (your s3 secret)
- FOG\_DIRECTORY (the bucket to store your assets on s3)
- SENDGRID\_PASSWORD (the password of you sendgrid account)
- SENDGRID\_USERNAME (the username of you sendgrid account)
- JUGG_URL (the redis url from the heroku redis account)
- TWITTER\_CONSUMER_KEY (the consumer key for twitter)
- TWITTER\_CONSUMER_SECRET (the consumer secret for twitter)
- FACEBOOK\_CLIENT\_ID (the facebook client id)
- FACEBOOK\_CLIENT\_SECRET (the facebook client secret)
- BITLY\_API (the bitly api key)
- SALTY (random string for salts)
- SECRET_TOKEN (This is optional but a good idea to add a long random string)

Clone repo

`git clone git://github.com/ninetwentyfour/Hospitium.git`

`cd Hospitium`

`bundle install`

create a database called animal_development, or change db connection in `/config/database.yml`

`rake db:create`

`rake db:migrate`

`rake db:seed`

need to change assets setup

- comment out line 50 `/config/environments/development.rb`

In production change

- `config.action_controller.asset_host = "http://static-assets%d.hospitium.co"` to `= "your s3 account url here"`

`rails s`

Visit [http://localhost:3000](http://localhost:3000)

Sign in with 

- Login: admin 
- Password: pleasechange

Dashboard can be found at [http://localhost:3000/admin](http://localhost:3000/admin).

Please change your admin password and the organization name if you so choose.


* * *

Todo:
======================== 

* * *


- post to pet finder and other animal sites (adopt-a-pet)

- click to call integration with twilio (be able to call vets, contacts, etc from computer with mic or bridge call)

- create graphs of info and stats like average time in shelter etc

- add current location to animal (like address of foster home or vet)

- user docs (started at [https://hospitium.tenderapp.com/kb](https://hospitium.tenderapp.com/kb))

- add more descriptions to labels in create and edit of all models

- lots of testing

- make adopt list random or cycle through entries

- do public adopt pages grouped by organization - make embedable with code to copy in view

- add search to adopt list (search by location and species)

- add image to organization and contacts

- mailchimp email list integration

- create check for memcached server being up or available, if not, kick to db sessions

- import animals from other sites in both batches and api style

- add [aviary](http://www.aviary.com/) support to allow users to edit photos of animals

- make public animal list a queue that is moderated by super admins (not yet - wait to see spam levels)

- seo

- send facebook to pages or groups

- add label warning and make model strip any part of weight that isn't an integer (assumed grams)

- remove and move to env variables all api keys

- make weights decimals and make suffix user configurable 

- graph of animal ages

- do some cake thing on dashboard for animals birthdays

- let organizations add donate links to public pages

- mark what fields are public

- donations and fundraising MVC 

- maybe work with something like this [http://www.petdetect.com/](http://www.petdetect.com/)

- create cancel account mechanism and job that deletes info in 30 days

- track vet visits over time w/ notes

- calculate most adopted species and do percentages of it

- calculate average time from intake to adoption/death

- switch notifications and use in all text area fields redcarpet

- add note in add wordpress/adopt a pet accounts that they should create accounts for this, with unique usernames and strong passwords, with as little permissions as possible (not admin - just post ability)

* * *
