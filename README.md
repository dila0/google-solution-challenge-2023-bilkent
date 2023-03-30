<div id="top"></div>

[![Contributors]][contributors-url]
[![Forks]][forks-url]
[![Stargazers]][stars-url]
[![Issues]][issues-url]

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/dila0/google-solution-challenge-2023-bilkent">
    <img src="/lunarislogo.png" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">Lunaris - Safety In Your Pocket</h3>

  <p align="center">
    Developed for Google Solution Challenge'23
    <br />
    <br />
    <br />
    <a href="https://play.google.com/store/apps/details?id=com.hekatech.google_solution">View on Play Store</a>
    ·
    <a href="https://github.com/dila0/google-solution-challenge-2023-bilkent/issues">Report Bug</a>
    ·
    <a href="https://github.com/dila0/google-solution-challenge-2023-bilkent/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

[![Lunaris-ss][screenshot]](https://play.google.com/store/apps/details?id=com.hekatech.google_solution)


<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Built With

This section should list any major frameworks/libraries used to bootstrap your project. Leave any add-ons/plugins for the acknowledgements section. Here are a few examples.

* [![Flutter][Flutter]][flutter-url]
* [![Firebase][Firebase]][firebase-url]
* [![Dart][Dart]][dart-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started
Make sure that you have Flutter on your device. 
We have developed our app using Flutter 3.7.7

### Prerequisites

This is an example of how to list things you need to use the software and how to install them.
* Flutter
  ```sh
  npm install -g flutter-cli
  flutter doctor
  ```

### Installation

_Below is an example of how you can instruct your audience on installing and setting up your app. This template doesn't rely on any external dependencies or services._

1. Clone the repo
   ```sh
   gh repo clone dila0/google-solution-challenge-2023-bilkent
   ```
2. Install dart packages
   ```sh
   flutter pub get
   ```
3. Run through Android Studio
   We have tested the app on on Pixel 5 API 33. So using it for emulation is suggested.

OR

1. Download from the link below for Android
   [Play Store](https://play.google.com/store/apps/details?id=com.hekatech.google_solution)
   Note that trigger word detection feature is not enabled on the Play Store version yet due to API limit.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage
Register using your credentials.
Change your emergency message through profile and add emergency contacts.
Enable trigger word detection through settings. (This functionality uses Porcupine API, if API limit is exceeded this may not work. In this case please contact us.)
Select a contact option and call.
During call the voice will wait until you stop talking and ask another question.
If you feel unsafe say "Americano" if trigger word detection is enabled.
If not click "Emergency Call" button.
<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [ ] Train model on Tensorflow for trigger word detection
- [ ] More contact options
- [ ] Safety map using Google Maps API
- [ ] Google account sign-in option
- [ ] Multi-language Support
    - [ ] Turkish
    - [ ] French
    - [ ] German

See the [open issues]( https://github.com/dila0/google-solution-challenge-2023-bilkent/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing
If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue.
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTACT -->

##### This project is  developed for Google Solution Challange 2023 by:
* [Ali Tunahan Işık](https://github.com/ali-tunahan)    ![LinkedIn][linkedin-shield][linkedin-url-ati]
* [Atakan Şerifoğlu](https://github.com/atakanserifoglu)   ![LinkedIn][linkedin-shield][linkedin-url-atakan]
* [Dila Tosun](https://github.com/dila0)   ![LinkedIn][linkedin-shield][linkedin-url-dila]
* [Tuna Bozkurt](https://github.com/tbozk)   ![LinkedIn][linkedin-shield][linkedin-url-tuna]


<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
[contributors-url]: https://github.com/dila0/google-solution-challenge-2023-bilkent/graphs/contributors
[forks-url]: https://github.com/dila0/google-solution-challenge-2023-bilkent/network/members
[stars-url]: https://github.com/dila0/google-solution-challenge-2023-bilkent/stargazers
[issues-url]: https://github.com/dila0/google-solution-challenge-2023-bilkent/issues

[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url-ati]: https://www.linkedin.com/in/ali-tunahan

[linkedin-url-tuna]: https://www.linkedin.com/in/tuna-bozkurt-248bb1209/

[linkedin-url-atakan]: https://www.linkedin.com/in/atakanserifoglu/

[linkedin-url-dila]: https://www.linkedin.com/in/dila-tosun/

[Flutter]: https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white
[flutter-url]: https://flutter.dev
[Firebase]: https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase
[firebase-url]: https://firebase.google.com

[Dart]: https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white
[dart-url]: https://dart.dev