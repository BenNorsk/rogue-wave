import { Controller } from "stimulus"

console.log(">>> Hello from Stimulus Controller | carousel ")
export default class extends Controller {
  static targets = [ "slide" ]



  // 1
  initialize() {
    console.log(this.slideTargets)
    // sets the index slide visible in the DOM
    this.showCurrentSlide()
  }

  next() {
    // Should increment the index up, then loop back to 0
    if (this.index < this.slideTargets.length - 1 ) {
      this.index++
    } else {
      this.index = 0
    }
  }

  previous() {
    if (this.index > 0) {
      this.index--
    } else {
      this.index = this.slideTargets.length - 1
    }
  }

  // 2 Loops though all elements until the index in the loop == the index variable stored in the DOM
  showCurrentSlide() {
    this.slideTargets.forEach((element, i) => {
      // add/remove slide--current class, depending on test conditional, element.index == iteration
      element.classList.toggle("slide--current", this.index == i)
    })
  }

  // this.data.get("attributename") = retrieves value from DOM
  // this.data.set("attributename", value) => sets the value in DOM
  // these can be wrapped up into get and set methods, allowing
  // this.index to be called => getting the index value from the DOM
  // & this.index = 2 => setting the value in the DOM.
  get index() {
    console.log("...getting index");
    return parseInt(this.data.get("index"))
  }

  set index(value) {
    console.log("...setting index");
    this.data.set("index", value)
    this.showCurrentSlide()
  }
}