## Getting Started

Clone our Git repo
```
git clone
bundle install
```

To use client, you need to add "API_KEY" and "SENDER_DOMAIN" to:
```
config/mailgun_config.yml
```

After that you need just to run Rails server
```
rails s
```

## Features
- [x] Viewing mailing lists
- [x] Creating emails with WYSIWYG editor
- [x] Sending emails to emails from mailing list

## Bugs

Sending starts when you confirm sending, but after that, you willn't get any information about progress.
You can see progress in server console.

## To do
- [ ] Seding emails with background jobs and show sending progress
- [ ] Work with mailing lists (CRUD)
- [ ] Storing statistics
- [ ] Predefined HTML email templates
- [ ] Auto transformation text from HTML template to text version of email
