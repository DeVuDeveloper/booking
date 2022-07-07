# Booking

<div id="top"></div>
<!-- PROJECT LOGO -->
<div align="center">
 

  <h1 align="center">Booking</h1>

  <p align="center">
    Booking web app
    <br />


<!-- TABLE OF CONTENTS -->
<details>
<summary align="center">Table of Contents</summary>

- [booking](#booking)
  - 
  - [Screenshots](#screenshots)
  - [Description 🏗️](#description-️)
  - [Live Demo](#live-demo)
  - [Getting Started 🏁](#getting-started-)
    - [Prerequisites and Dependencies 📜](#prerequisites-and-dependencies-)
      - [Setting Up PostgreSQL](#setting-up-postgresql)
    - [Clone this repository](#clone-this-repository)
    - [Move into the cloned directory with](#move-into-the-cloned-directory-with)
  - [Setup](#setup)
    - [Run linter](#run-linter)
      - [Auto-correct](#auto-correct)
    - [Run Project](#run-project)
  - [Run tests](#run-tests)
    - [Roadmap](#roadmap)
  - [Built With 🔨](#built-with-)
  - [Authors ✍️](#authors-️)
  - [🤝 Contributors](#-contributors)
  - [📝 License](#-license)
  - [Show your support 💪](#show-your-support-)
  - [Acknowledgments](#acknowledgments)
</details>

<!-- About the project -->
[App screenshot](https://example.com)

##  Screenshots
![Screenshot2](app/assets/images/screenshot2.png)
![Screenshot3](app/assets/images/screenshot3.png)
![Screenshot4](app/assets/images/screenshot4.png)

## Description 🏗️
Booking is web app for reserve display and reserve items. User can reserve item and admin can manage all, crerate, update, delete.

## Techologies

###  Ruby on Rails, PostgreSQL, TRailblazer, GraphQL, Grape, React

<p align="right">(<a href="#top">back to top</a>)</p>

## Live Demo

(In progress)

## Getting Started 🏁

### Prerequisites and Dependencies 📜

You will be needing:

- A terminal terminal
- A code editor
- Ruby (follow the instructions based on your OS)
  ```bash
  https://www.ruby-lang.org/en/documentation/installation/
  ```
- Rails (follow the instructions based on your OS)
    ```bash
    https://guides.rubyonrails.org/getting_started.html#creating-a-new-rails-project-installing-rails
    ```

- Postgresql (follow the instructions based on your OS)
  ```bash
  https://www.postgresql.org/download/
  ```


#### Setting Up PostgreSQL

- The postgres installation doesn't setup a user for you, so you'll need to follow these steps to create a user with permission to create databases. You can skip this if this is not your first time using PostgreSQL

  ```bash
  sudo -u postgres createuser <Username> -s
  ```

### Clone this repository

```bash
git clone https://github.com/VuDej/booking.git
```
### Move into the cloned directory with

  ```bash
  cd booking
  ```

## Setup

Install gems with:

  ```bash
  bundle install
  ```

Setup the database with:
```bash
rails db:create
```
<div>OR</div>

```bash
rake db:create
```

### Run linter

```bash
rubocop .
```

#### Auto-correct

In auto-correct mode, RuboCop linters offenses will be automatically fixed:

For rubocop:
```bash
rubocop -A
```
 **<div>OR</div>**
```bash
rubocop --auto-correct-all
```

### Run Project

Start server with:

```bash
rails s
```
<div align="center">OR</div>

```bash
rails server -p 3001 
```
This will start a server at:
```bash
localhost:3001
```
You can paste or type it on url bar

## Run tests

Make sure you have installed gems with:

 ```bash
  bundle install
```
Then run all the tests with:

```bash
rspec spec
```

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- ROADMAP -->
### Roadmap

- [x] Set up the repository/repositories on GitHub and use Gitflow.
- [x] Set up Postgres for the database
- [x] Create controllers, endpoints and models
- [x] Use Rails to create API.
- [x] Use React & Redux to create frontend UI.
- [x] Create unit tests
- [x] Create README
  
<p align="right">(<a href="#top">back to top</a>)</p>

## Built With 🔨
<div align="center">

|| Languages ||
|-|-------------|-|
||![Ruby](https://img.shields.io/badge/-Ruby-000000?style=flat&logo=ruby&logoColor=red)![Ruby on Rails](https://img.shields.io/badge/-Ruby_on_Rails-000000?style=flat&logo=ruby-on-rails&logoColor=blue)![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white) ![React](https://img.shields.io/badge/react-%2320232a.svg?style=for-the-badge&logo=react&logoColor=%2361DAFB) ![Redux](https://img.shields.io/badge/redux-%23593d88.svg?style=for-the-badge&logo=redux&logoColor=white)||

||![React](https://img.shields.io/badge/react-%2320232a.svg?style=for-the-badge&logo=react&logoColor=%2361DAFB) ![Redux](https://img.shields.io/badge/redux-%23593d88.svg?style=for-the-badge&logo=redux&logoColor=white) |     |


</div>

<div align="center">

||Tools 🛠️||
|-|-------------|-|
||![Git](https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white)  ![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)   ![Markdown](https://img.shields.io/badge/markdown-%23000000.svg?style=for-the-badge&logo=markdown&logoColor=white)  ![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)||
<p align="right">(<a href="#top">back to top</a>)</p>
</div>

## Authors ✍️
<div align="center">

| 👤 vudej  |
|---|
| <a target="_blank" href="https://github.com/VuDej"><img src="https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white" alt="Github profile"></a>  <a target="_blank" href="https://www.linkedin.com/in/dejan-vujovic/"><img src="https://img.shields.io/badge/-LinkedIn-0077b5?style=for-the-badge&logo=LinkedIn&logoColor=white" alt="Linkedin profile"></a> <a target="_blank" href="https://twitter.com/DejanVuj"><img src="https://img.shields.io/badge/-Twitter-1DA1F2?style=for-the-badge&logo=Twitter&logoColor=white" alt="Twitter profile"></a>
|

</div>

<p align="right">(<a href="#top">back to top</a>)</p>


## 🤝 Contributors

Contributions, issues, and feature requests are greatly appreciated!

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "improvements".

- Fork the Project
- Create your Feature Branch (git checkout -b feature/yourfeaturename)
- Commit your Changes (git commit -m 'Add suggested feature')
- Push to the Branch (git push origin feature/AmazingFeature)
- Open a Pull Request

Feel free to check the [issues page](https://github.com/VuDej/backend-rent/issues).

<p align="right">(<a href="#top">back to top</a>)</p>

## 📝 License

This project is licensed by [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Show your support 💪
Give a ⭐️ if you like this project!

<p align="right">(<a href="#top">back to top</a>)</p>