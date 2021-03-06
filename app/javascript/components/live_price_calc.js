console.log(">>> Live_price_calc.js loaded")


const datePattern = /(?<startdate>\d{4}-\d{2}-\d{2}) to (?<enddate>\d{4}-\d{2}-\d{2})|(?<startenddate>\d{4}-\d{2}-\d{2})/;


const numberFormat = (x) => {
  const numberPattern = /\B(?=(\d{3})+(?!\d))/g
  return x.toString().replace(numberPattern, ",");
}

const defined = (variable) => {
  return typeof(variable) !== "undefined"
}

const calcPrice = () => {
  // fixed value from page
  pricePerDay = document.getElementById("price-per-day");

  // User input
  dateRangeInput = document.getElementById("date-range");

  // Fields I will update
  totalPrice = document.getElementById("live-price-calc");
  daysElement = document.getElementById("live-days-calc");
  plural = document.getElementById("plural-days");

  let days = 0;
  let totalPriceValue = 0;

  if (dateRangeInput === null ) { return }

  if (dateRangeInput.value) {
    const matchValues = dateRangeInput.value.match(datePattern);

    let startDate = matchValues["groups"]["startdate"];
    let endDate = matchValues["groups"]["enddate"];
    let startEndDate = matchValues["groups"]["startenddate"];

    if (defined(startDate)) {
      days = (Date.parse(endDate) - Date.parse(startDate)) / (60*60*24*1000) + 1;
      totalPriceValue = Number(pricePerDay.innerText) * days;
      plural.innerText = "s"
    }
    if (defined(startEndDate)) {
      days = 1;
      totalPriceValue = Number(pricePerDay.innerText);
      plural.innerText = ""
    }

    totalPrice.innerText = numberFormat(totalPriceValue.toFixed(2));
    daysElement.innerText = days;


  } else {
    totalPrice.innerText = 0;
    daysElement.innerText = 0;
  }
}



document.addEventListener('turbolinks:load', () => {
  // guard clause to prevent loading if not the show boat page
  totalPrice = document.getElementById("live-price-calc");
  if (totalPrice === null ) { return }
  setInterval(() => calcPrice(), 1000);
});