import flatpickr from "flatpickr";

console.log(">>> Flatpickr loaded")

document.addEventListener('turbolinks:load', () => {
  flatpickr(".datepicker", {
    mode: "range"
  });
});