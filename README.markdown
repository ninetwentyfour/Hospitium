* * *
Hospitium
========

* * *

Warning! This is still super beta software. Things are changing fast and you may lose data.

[http://hospitium.heroku.com/](http://hospitium.heroku.com/)

Created By: [Travis Berry](http://www.travisberry.com), [Apple Wood Rescue](http://www.applewoodrescue.org)

Hospitium is Licensed under the MIT license: [http://www.opensource.org/licenses/mit-license.php](http://www.opensource.org/licenses/mit-license.php)

RoR, Rails Admin, Twitter Bootstrap, and others licensed under their respective licenses. 

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

- Make age calculate over time. (possibly just use date of birth if too hard to track for now)

- post to pet finder and other animal sites (adopt-a-pet)

- <del>Animal Weight MVC</del>

- facebook integration

- post to wordpress / tumblr 

- <del>add checkbox for public on animals and create pubic adopt list.</del>

- twitter integration

- click to call integration with twilio (be able to call vets, contacts, etc from computer with mic or bridge call)

- <del>show data that belongs to user only</del>

- <del>make more options dropdowns and checkboxes</del>

- <del>hide uuids in views</del>

- setup emails

- create graphs of info and stats like average time in shelter etc

- mobile layouts

- add current location to animal (like address of foster home or vet)

- <del>add adopted date to animal</del>

- force all models to redirect to /admin except organizations and animals for adopt pages

- add versioning and undo / redo

- <del>move colors to own mvc</del>

- add photo and video uploads (got a simple paperclip running on animals - possibly to a separate model : possibly use youtube or some other service to handle video)

- city state and zip fields

- <del>make new users default to admin role</del>

- <del>force unique names on organizations and emails</del>

- user docs (started at [https://github.com/ninetwentyfour/Hospitium/wiki/User-Docs](https://github.com/ninetwentyfour/Hospitium/wiki/User-Docs))

- style uploaded images and show pages

- <del>add organization contact info so people can contact about public animals</del>

- add more descriptions to labels in create and edit of all models

- <del>bug with new users not being able to create organizations</del>

- lots of testing

- <del>make address required in organizations</del>

- <del>show location on adopt list</del>

- make adopt list random or cycle through entries

- do public adopt pages grouped by organization - make embedable with code to copy in view

- add warning to animal image upload that square images are preferred. 

- make user show email or add username to user and show that in rails admin instead of user ID

- limit image size in view incase they upload giant images

- add more image resize options to animal pics

- need to make github style add collaborators to organizations

- no follow all links created by users (e.g. organization website) / make do follow for future paid accounts

- add adopt link to animals to set what the canonical adopt page is for adoptable animals

- rpsec and cucumber tests

- move sessions to database

- use uuid instead of id on adopt list and shows / organizations / admin interface

- add search to adopt list (search by location and species)

* * *


