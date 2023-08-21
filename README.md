Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.
<h1 align="center">Airbnb clone project</h1>

<p align="center">Dating application</p>

- Browse through a diverse range of profiles to find the perfect match for your next date.
<img src="https://github.com/meifruit/Hive/blob/master/app/assets/images/index.png"/>

- Seamlessly book a date with your chosen person, just like booking accommodations on Airbnb.
<img src="https://github.com/meifruit/Hive/blob/master/app/assets/images/show.png"/>

- Keep track of your upcoming dates and receive notifications about important updates.
<img src="https://github.com/meifruit/Hive/blob/master/app/assets/images/status.png"/>
 
<br>

## Getting Started
### Setup

Install gems
```
bundle install
```
Install JS packages
```
yarn install
```

### ENV Variables
Create `.env` file
```
touch .env
```
Inside `.env`, set these variable.
```
CLOUDINARY_URL=your_own_cloudinary_url_key
MAPBOX_API_KEY=your_own_mapbox_url_key
```

### DB Setup
```
rails db:create
rails db:migrate
rails db:seed
```

### Run a server
```
rails s
```

## Built With
- [Rails 6](https://guides.rubyonrails.org/) - Backend / Front-end
- [Stimulus JS](https://stimulus.hotwired.dev/) - Front-end JS
- [Render](https://render.com/) - Deployment
- [PostgreSQL](https://www.postgresql.org/) - Database
- [Bootstrap](https://getbootstrap.com/) — Styling
- [Figma](https://www.figma.com) — Prototyping

## Team Members
- Xuemei Huang
- Rika Saito
- Jun Ukemori
- Juan David Bernal
