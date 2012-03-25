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

Hospitium is the brain child of Apple Wood Rescue, a small animal rescue in Denver Colorado. Developed to fit the needs of the rescue, it has since been open sourced for anyone to use.

This program is completely free. You can modify it all you want and you can share it with anyone.

A free hosted solution is coming soon.

You can support the project by:

- Donating to [Apple Wood Rescue](http://www.applewoodrescue.org/donate/)

- Contributing to the development of Hospitium on [github](https://github.com/ninetwentyfour/Hospitium).


* * *

Install:
========================

* * *

**These instruction are a bit out of date. I'll work on new ones and post as soon as I can.**

Set db connection in `/config/database.yml`

`$ cd /foo/bar/app_location/`

`$ bundle install`

`$ rake db:migrate`

For the time being (until I or someone create a migration to create default data) you need to manually add the roles to the database.

Add a row and with SuperAdmin as the name. Then create row 2 with name Admin.

`$ rails server`

Go to [http://localhost:3000](http://localhost:3000)

Sign up for a user if first install or empty db

Dashboard can be found at [http://localhost:3000/admin](http://localhost:3000/admin)

Hospitium uses Amazon s3 for file storage. It currently relies on `ENV['S3_SECRET']` and `ENV['S3_KEY']` being set. You can see an example of how to use for development [here](http://devcenter.heroku.com/articles/config-vars#local_setup).


* * *

Todo:
======================== 

* * *

- <del>Make age calculate over time. (possibly just use date of birth if too hard to track for now)</del>

- post to pet finder and other animal sites (adopt-a-pet)

- <del>Animal Weight MVC</del>

- <del>facebook integration</del>

- <del>post to wordpress / tumblr [http://jmettraux.wordpress.com/2007/11/05/posting-to-wordpress-via-ruby-and-atompub/](http://jmettraux.wordpress.com/2007/11/05/posting-to-wordpress-via-ruby-and-atompub/)</del>

- <del>add checkbox for public on animals and create pubic adopt list.</del>

- <del>twitter integration</del>

- click to call integration with twilio (be able to call vets, contacts, etc from computer with mic or bridge call)

- <del>show data that belongs to user only</del>

- <del>make more options dropdowns and checkboxes</del>

- <del>hide uuids in views</del>

- <del>setup emails</del>

- create graphs of info and stats like average time in shelter etc

- mobile layouts

- add current location to animal (like address of foster home or vet)

- <del>add adopted date to animal</del>

- <del>force all models to redirect to /admin except organizations and animals for adopt pages</del>

- <del>add versioning and undo / redo</del>

- <del>move colors to own mvc</del>

- add photo and video uploads (got a simple paperclip running on animals - possibly to a separate model : possibly use youtube or some other service to handle video)

- city state and zip fields

- <del>make new users default to admin role</del>

- <del>force unique names on organizations and emails</del>

- user docs (started at [https://github.com/ninetwentyfour/Hospitium/wiki/User-Docs](https://github.com/ninetwentyfour/Hospitium/wiki/User-Docs))

- <del>style uploaded images and show pages</del>

- <del>add organization contact info so people can contact about public animals</del>

- add more descriptions to labels in create and edit of all models

- <del>bug with new users not being able to create organizations</del>

- lots of testing

- <del>make address required in organizations</del>

- <del>show location on adopt list</del>

- make adopt list random or cycle through entries

- do public adopt pages grouped by organization - make embedable with code to copy in view

- <del>add warning to animal image upload that square images are preferred.</del>

- <del>make user show email or add username to user and show that in rails admin instead of user ID</del>

- <del>limit image size in view incase they upload giant images</del>

- <del>add more image resize options to animal pics</del>

- <del>need to make github style add collaborators to organizations</del>

- <del>no follow all links created by users (e.g. organization website) / make do follow for future paid accounts</del>

- <del>add adopt link to animals to set what the canonical adopt page is for adoptable animals</del>

- <del>move sessions to database</del>

- <del>use uuid instead of id on adopt list and shows / organizations / admin interface</del>

- add search to adopt list (search by location and species)

- performance tweaks (limit data in calls, cache where we can, etc)

- add image to organization and contacts

- mailchimp email list integration

- Need to hide twitter accounts from rails admin

- create check for memcached server being up or available, if not, kick to db sessions

- import animals from other sites in both batches and api style

- <del>add bitly to shorten all share links</del>

- add [aviary](http://www.aviary.com/) support to allow users to edit photos of animals

- make public animal list a queue that is moderated by super admins (not yet - wait to see spam levels)

- seo

- send facebook to pages or groups

- <del>send all new public animals to hospitium twitter</del>

- <del>scope data in dashboard</del>

- standardize address before saving with google maps api, and show map on show pages with locations

- <del>show twitter and fb on dashboard and do pie charts of animals in statuses (adopted - etc)</del>

- <del>cache twitter on dashboard</del>

- add label warning and make model strip any part of weight that isn't an integer (assumed grams)

- <del>make statuses like animal colors (addable by user)</del>

- <del>create login messages to display helpful hints at random</del>

- <del>do browser testing and add warnings for ie =< 8</del>

- remove and move to env variables all api keys

- <del>clean up show admin view (code is a mess)</del>

- make weights decimals and make suffix user configurable 

- add microchip field to animal

- graph of animal ages

- do some cake thing on dashboard for animals birthdays

- let organizations add donate links to public pages

- mark what fields are public

- rabies boolean on animal

- <del>privacy policy and terms of service</del>

- donations and fundraising MVC 

- maybe work with something like this [http://www.petdetect.com/](http://www.petdetect.com/)

- <del>remove a bunch of stuff from organizations create and edit</del>

- create cancel account mechanism and job that deletes info in 30 days

- <del>fix undo</del>

- <del>do missing animal and all around photo like the default missing gravatar but like a mouse silhouette</del>

- <del>fix bg with filters and search for non super admins</del>

- <del>fix bulk delete for non super admins</del>

- add comments section that grows over time for animal

- track vet visits over time w/ notes

- create some dummy default data for things like species / animal colors (maybe map to adopt a pet fields?)

- calculate most adopted species and do percentages of it

- calculate average time from intake to adoption/death

- tag via @hospitium_app to sent tweets (make customizable messages / no via for premium accounts)

- add text area sizer

- link all email fields

- switch notifications and use in all text area fields redcarpet

* * *


