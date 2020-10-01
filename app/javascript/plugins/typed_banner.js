import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  // check if there is some text to animate
  const bannerText = document.getElementById('banner-typed-text');

  if (bannerText) {
    new Typed('#banner-typed-text', {
      strings: ["...let your dreams set sail.^4000"],
      typeSpeed: 80,
      loop: true
    });
  }
};

document.addEventListener('turbolinks:load', () => {
  loadDynamicBannerText();
});