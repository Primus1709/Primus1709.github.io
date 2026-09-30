# Portfolio

A personal portfolio site built with Ruby on Rails 8. Projects are written as short case studies (the problem, how you built it, what came of it), and there's a password-protected admin area for adding projects and reading messages from the contact form.

## What's in it

- **Home page** with your intro, selected work, about, skills and a contact form
- **Work page** listing every published project
- **Case study page** for each project, with previous and next links
- **Admin** at `/admin` to add, edit, reorder, hide and delete projects, and read messages
- **Contact form** that saves messages to the database, with a rate limit and a hidden field that catches spam bots
- **Light and dark themes** that follow the visitor's system setting, with a toggle
- **Tests** for the models, the public pages and the admin

## Run it on your computer

You need **Ruby 3.2 or newer**. Check with `ruby -v`.

- macOS or Linux: install Ruby with [rbenv](https://github.com/rbenv/rbenv) or [mise](https://mise.jdx.dev).
- Windows: use [RubyInstaller](https://rubyinstaller.org) (pick the "with Devkit" version), or run everything inside WSL.

Then, in this folder:

```sh
gem install bundler
ruby bin/setup
```

That installs the gems, creates the database, adds three sample projects and starts the server. Open http://localhost:3000.

After the first time, start the server with:

```sh
ruby bin/rails server
```

## Make it yours

1. **Your details:** edit `config/profile.yml`. Name, intro, links, about, skills and what you're doing right now all live there. Reload the page to see changes.
2. **Your résumé:** put a PDF at `public/resume.pdf`. The Résumé link points there.
3. **Your projects:** go to http://localhost:3000/admin. In development the username is `admin` and the password is `password`. Edit the sample projects or delete them and add your own.
4. **Colors and fonts:** the variables at the top of `app/assets/stylesheets/application.css` control the whole look.

## Run the tests

```sh
ruby bin/rails test
```

## How it fits together

If you're using this project to learn Rails, this is the path a request takes:

1. `config/routes.rb` matches the URL to a controller action. `/projects/course-tracker` goes to `ProjectsController#show`.
2. The controller in `app/controllers/` loads data through a model. `Project.published.find_by!(slug: ...)`
3. The model in `app/models/` talks to the database and holds the rules, like "a project needs a title" or "links must start with https".
4. The view in `app/views/` turns that data into HTML. `.html.erb` files are HTML with Ruby inside `<%= %>` tags.
5. The layout in `app/views/layouts/` wraps every page with the header and footer.

Other places worth reading:

- `db/migrate/` describes the database tables. Rails builds `db/schema.rb` from these when you run `bin/setup`.
- `db/seeds.rb` adds the sample projects.
- `app/controllers/admin/base_controller.rb` is where the admin password check happens. Every admin controller inherits from it.
- `app/controllers/messages_controller.rb` has the rate limit and the spam check.
- `test/` has the tests. Reading them is a quick way to see what each part is supposed to do.

## Put it online

Any host that runs Rails works: [Render](https://render.com), [Fly.io](https://fly.io), [Railway](https://railway.com), or your own server with [Kamal](https://kamal-deploy.org). Whichever you pick, set these environment variables:

| Variable | What it's for |
| --- | --- |
| `RAILS_ENV` | Set to `production` |
| `SECRET_KEY_BASE` | Signs cookies. Generate one with `ruby bin/rails secret` |
| `ADMIN_PASSWORD` | Your admin password. Admin stays turned off until this is set |
| `ADMIN_USERNAME` | Optional, defaults to `admin` |
| `FORCE_SSL` | Optional, defaults to `true`. Set to `false` only if your host doesn't use HTTPS |

The build step should run:

```sh
bundle install
ruby bin/rails assets:precompile
ruby bin/rails db:prepare
```

and the start command is `ruby bin/rails server`.

The database is a SQLite file in `storage/`. On hosts where the disk is wiped on every deploy, attach a persistent disk mounted at `storage/`, or your projects and messages will reset.
