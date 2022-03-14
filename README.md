# Ask-Me

###### Ruby: `2.7.4` Rails: `6.1.4` Language `Russian`

### About

Ask-me is an application where you can ask each other any questions and get answers, similar to the popular ask.fm. The user can add an avatar and change the background color of the profile. On the user page, you can leave questions and answer them. When adding a question, the algorithm looks for hashtags starting with "#", changes color and makes them clickable. Clicking on a hashtag takes you to a page with questions from all users with that hashtag. The hashtags of all users are displayed on the main page.

[`reCAPTCHA`](https://www.google.com/recaptcha/about/) is used for spam protection.

### Installation

1. Clone repo
```
$ git clone git@github.com:phobco/ask-me.git
$ cd ask-me
```

2. Install gems
```
$ bundle
```

3. Create database and run migrations
```
$ rails db:create
$ rails db:migrate
```

4. Generate `master.key` and credentials file (at first remove old file `config/credentials.yml.enc`)
```
$ EDITOR=nano rails credentials:edit
```

Set your `reCAPTCHA` keys if needed at `credentials.yml.enc`
```
recaptcha:
  site_key: <your site key>
  secret_key: <your secret key>
```

5. Start sever
```
$ rails s
```

Open `localhost:3000` in browser.

### Production link

Deployed on `Heroku`: [`link`](https://askme-phobco.herokuapp.com/)
