import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["...let your dreams set sail.^4000"],
    typeSpeed: 80,
    loop: true
  });
};

document.addEventListener('turbolinks:load', () => {
  loadDynamicBannerText();
});